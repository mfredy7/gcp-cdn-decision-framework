# GCP CDN Decision Framework

A data-driven approach to evaluating Cloud CDN and Media CDN by analyzing egress traffic and user experience metrics. This repository provides the Terraform scaffolding, SQL diagnostics, and operational documentation needed to evaluate egress traffic and deploy a CDN on Google Cloud.

## Optional Step: AI-Assisted Architecture Assessment (via Gemini)

You can use generative AI to quickly analyze your log outputs. Copy and paste your SQL query results into Gemini along with the following prompt:

> "Act as a strict Google Cloud Network Architect. Analyze the following HTTP Load Balancer logs strictly using these rules: 1. Cloud/Media CDN: Recommend ONLY if you see high `total_gb_sent` for `STATIC_CACHEABLE_ASSET` in remote countries. 2. Backend Optimization: Recommend if you see high `avg_latency_ms` (>1000ms) for `DYNAMIC_API_UNCACHEABLE`. A CDN will not fix this. 3. No Action: If egress is low and latency is fine, do nothing.
> OUTPUT FORMAT: 1. Executive Summary. 2. Markdown Table: [Recommendation] | [Target Path] | [The Story (Correlation)] | [Justification (Quote exact Row/Country)] | [Product]. 3. Action Plan."

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
