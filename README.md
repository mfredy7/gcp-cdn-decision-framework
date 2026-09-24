# GCP CDN Decision Framework

A data-driven approach to evaluating Cloud CDN and Media CDN by analyzing egress traffic and user experience metrics. This repository provides the Terraform scaffolding, SQL diagnostics, and operational documentation needed to evaluate egress traffic and deploy a CDN on Google Cloud.

## Optional Step: AI-Assisted Architecture Assessment (via Gemini)

You can use generative AI to quickly analyze your log outputs. Copy and paste your SQL query results into Gemini along with the following prompt:

> "Act as a strict Google Cloud Network Architect. I am providing an export of my HTTP Load Balancer logs. YOUR INSTRUCTIONS: Analyze the data strictly using ONLY the rules below. Do not invent data, do not guess, and do not recommend any products outside of Cloud CDN or Media CDN. THE RULES: 1. Cloud CDN / Media CDN: Recommend this ONLY if you see high `total_gb_sent` for `STATIC_CACHEABLE_ASSET` in countries far from my primary backend. Specify Media CDN if the assets are large video/media files. 2. Backend Optimization: Recommend this if you see high `avg_latency_ms` (e.g., > 1000ms) for `DYNAMIC_API_UNCACHEABLE` traffic. Explicitly state that a CDN will not fix this, as the latency is coming from backend processing. 3. No Action: If egress volume is low (e.g., well under 1TB) and latency is acceptable, state that standard origin delivery is sufficient and a CDN is not currently required. OUTPUT FORMAT: You must format your exact response using these three specific sections: 1. Executive Summary (TL;DR) Write a 2-3 sentence summary designed for a CTO or Engineering Manager. Focus on the primary opportunities for cost and latency optimization. 2. Architectural Assessment (The Evidence & The Story) Present your findings in a clean Markdown table with the following columns: [Recommendation] | [Target Resource / Path] | [The Story (Correlation)] | [Justification (Quote exact Row/Country Code)] | [Recommended GCP Product] Crucial Instruction for 'The Story' column: Tell a 1-2 sentence narrative explaining the geographic pattern observed. For example: 'A concentrated cluster of remote users is heavily streaming static assets, driving up latency and egress costs.' 3. Recommended Next Steps (Action Plan) Provide 2-3 bullet points detailing exactly what the infrastructure team should do next based on your findings. Here is my data: [PASTE YOUR SQL TABLE DATA HERE]" 

---

## Repository Structure

* **`monitoring/`**
  * `log_analytics_queries.sql`: BigQuery/Log Analytics SQL query to evaluate the Remote-Static Overlap.
  * `dashboard_filters.txt`: Log Explorer regex filter for Origin Collapse diagnostics.
* **`terraform/`**
  * Best-practice Terraform implementation of a Google Cloud External HTTP Load Balancer with a Backend Bucket, Cloud CDN enabled, and diagnostic response headers.
* **`docs/`**
  * `data_interpretation_matrix.md`: Guide to evaluating the 10 SQL query columns and making architectural decisions.
  * `troubleshooting_and_operations.md`: Operational runbook for cache validation and emergency invalidations.

Read the full guide on Medium (LINK_TO_COME).
