# Custom Response Headers Configuration
# Add this block to your google_compute_backend_service or google_compute_backend_bucket
# to expose edge telemetry metrics down to the client response.

custom_response_headers = [
  "X-Cache-Status: {cdn_cache_status}",
  "X-Cache-ID: {cdn_cache_id}",
  "X-Client-Geo: {client_region},{client_city}"
]
