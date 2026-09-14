#!/bin/bash
URL_MAP_NAME="YOUR_URL_MAP_NAME"

# Invalidate a single file globally (~10 second propagation)
gcloud compute url-maps invalidate-cdn-cache $URL_MAP_NAME \
    --path "/assets/app.js" \
    --async

# Invalidate an entire directory prefix
gcloud compute url-maps invalidate-cdn-cache $URL_MAP_NAME \
    --path "/assets/*"

# Invalidate scoped strictly to a specific staging or prod hostname
gcloud compute url-maps invalidate-cdn-cache $URL_MAP_NAME \
    --host "app.example.com" \
    --path "/static/*"
