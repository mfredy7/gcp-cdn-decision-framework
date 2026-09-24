# Data Interpretation Matrix

| Metric | Move to CDN Indicator / Threshold | Do NOT Move / Bypass Indicator | Architectural Decision & Action |
| --- | --- | --- | --- |
| client_country | High traffic volume from countries geographically distant from the origin | Traffic primarily originates in the same region as the origin | Distant regions see the highest latency improvements from CDN caching. |
| workload_category | `STATIC_CACHEABLE_ASSET` or `ORIGIN_COLLAPSE_5XX` | `DYNAMIC_API_UNCACHEABLE` | STATIC: Prime candidate for CDN. COLLAPSE: Protect origin via CDN. DYNAMIC: Route directly to origin. |
| path_prefix | Static Paths (e.g., `/assets/*`, `/images/*`) | Dynamic Endpoints (e.g., `/api/*`, `/graphql/*`) | Route static paths to CDN backend, bypass for dynamic. |
| http_method | Safe Methods: GET, HEAD | State-Changing: POST, PUT, PATCH, DELETE | GET/HEAD are cacheable. State-changing methods must bypass cache. |
| file_type | Static extensions (e.g., `png`, `js`, `css`, `mp4`) | Dynamic/None (e.g., `json`, `none`) | Cache static assets, bypass dynamic responses. |
| request_count | High volume / concurrency | Low volume | High concurrency on static assets benefits greatly from CDN offload. |
| error_5xx_count | `> 0` indicating origin timeouts/overload | `0` errors (healthy origin) | High 5xx errors on cacheable paths warrant CDN deployment to protect backend. |
| total_mb_sent | High bandwidth consumption | Low bandwidth consumption | Analyze alongside cacheability to project cost savings. |
| total_gb_sent | Massive data transfer (>TB scale) | Low data transfer | High egress costs can be drastically reduced with CDN. |
| avg_latency_ms | High latency (>100ms) for static assets | Low latency | CDN significantly reduces latency for cacheable assets. |
| **Remote-Static Overlap (Synthesis)** | **High `total_gb_sent` + `STATIC_CACHEABLE_ASSET` + distant `client_country`** | High `total_gb_sent` + `DYNAMIC_API_UNCACHEABLE` | **High Egress + Static + Remote = Urgent CDN deployment.** Dynamic/API traffic requires backend optimization, not a CDN. |
