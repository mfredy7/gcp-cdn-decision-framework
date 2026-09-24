SELECT
  COALESCE(
    JSON_VALUE(json_payload.clientLocation),
    JSON_VALUE(json_payload.client_location),
    JSON_VALUE(json_payload.securityPolicyRequestData.clientCountry),
    http_request.remote_ip,
    'Unknown'
  ) AS client_country,
  CASE
    WHEN http_request.status >= 500 THEN 'ORIGIN_COLLAPSE_5XX'
    WHEN http_request.request_method IN ('POST', 'PUT', 'DELETE', 'PATCH')
         OR http_request.request_url LIKE '%/api/%'
         OR http_request.request_url LIKE '%/graphql%' THEN 'DYNAMIC_API_UNCACHEABLE'
    ELSE 'STATIC_CACHEABLE_ASSET'
  END AS workload_category,
  REGEXP_EXTRACT(http_request.request_url, r'https?://[^/]+(/[^?#]*)') AS path_prefix,
  http_request.request_method AS http_method,
  COALESCE(LOWER(REGEXP_EXTRACT(http_request.request_url, r'\.([a-zA-Z0-9]+)(?:[\?#]|$)')), 'none') AS file_type,
  COUNT(*) AS request_count,
  COUNTIF(http_request.status >= 500) AS error_5xx_count,
  ROUND(SUM(http_request.response_size) / 1024 / 1024, 2) AS total_mb_sent,
  ROUND(SUM(http_request.response_size) / 1024 / 1024 / 1024, 4) AS total_gb_sent,
  ROUND(AVG(http_request.latency.seconds * 1000 + http_request.latency.nanos / 1000000.0), 2) AS avg_latency_ms
FROM
  `YOUR_PROJECT_ID.global._Default._AllLogs`
WHERE
  resource.type = "http_load_balancer"
GROUP BY
  1, 2, 3, 4, 5
ORDER BY
  total_mb_sent DESC;
