SELECT
  JSON_VALUE(json_payload.cacheId) AS edge_pop,
  CASE
    WHEN JSON_VALUE(json_payload.statusDetails) = 'response_from_cache' THEN 'CACHE_HIT'
    WHEN JSON_VALUE(json_payload.statusDetails) = 'response_from_cache_validated' THEN 'CACHE_REVALIDATED'
    WHEN JSON_VALUE(json_payload.statusDetails) = 'response_sent_by_backend' THEN 'CACHE_MISS'
    ELSE JSON_VALUE(json_payload.statusDetails)
  END AS cache_execution_status,
  COUNT(*) AS total_requests,
  ROUND(SUM(http_request.response_size) / 1024 / 1024, 2) AS total_mb_delivered
FROM
  `YOUR_PROJECT_ID.global._Default._AllLogs`
WHERE
  resource.type = "http_load_balancer"
  AND timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
GROUP BY
  1, 2
ORDER BY
  total_requests DESC;
