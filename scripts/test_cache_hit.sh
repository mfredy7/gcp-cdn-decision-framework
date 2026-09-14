#!/bin/bash

# Export the target domain or Load Balancer Anycast IP
export TARGET_URL="http://YOUR_LOAD_BALANCER_IP/assets/app.js"

# 1. First probe: Cold origin fetch (Cache Fill)
curl -s -D - -o /dev/null "${TARGET_URL}"

# 2. Second probe: Immediate re-request (Edge Hit)
# curl -s -D - -o /dev/null "${TARGET_URL}"
