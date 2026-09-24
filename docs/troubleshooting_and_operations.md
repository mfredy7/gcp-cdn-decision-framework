# Troubleshooting and Operations

## Cache Hit / Miss Validation

You can validate whether the CDN is serving from cache or fetching from the origin by inspecting the `X-Cache-Status` response header.

**1. First probe: Cold origin fetch (Cache Fill)**
```bash
export TARGET_URL="http://YOUR_LOAD_BALANCER_IP/assets/app.js"
curl -s -D - -o /dev/null "${TARGET_URL}" | grep -Ei "(HTTP/|via|age|x-cache|cache-control)"
```
*Expect `X-Cache-Status: miss`*

**2. Second probe: Immediate re-request (Edge Hit)**
```bash
curl -s -D - -o /dev/null "${TARGET_URL}" | grep -Ei "(HTTP/|via|age|x-cache|cache-control)"
```
*Expect `X-Cache-Status: hit` and an `Age` header.*

## Emergency Cache Invalidation

When emergency patches require purging stale assets prior to TTL expiration, submit invalidation requests across Google's edge fleet.

**Invalidate a single file:**
```bash
gcloud compute url-maps invalidate-cdn-cache URL_MAP_NAME \
    --path "/assets/app.js" \
    --async
```

**Invalidate a directory prefix:**
```bash
gcloud compute url-maps invalidate-cdn-cache URL_MAP_NAME \
    --path "/assets/*"
```

> **🚨 STRICT WARNING:** Note that cache invalidations are strictly rate-limited to 500 requests per minute per Google Cloud Project. Exceeding this will result in API quota errors. Do not automate rapid invalidations on high-churn objects.
