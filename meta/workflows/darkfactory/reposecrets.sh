#!/bin/bash
set -u
REPO=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.repo // empty')
BODY=$(jq -n '{security_and_analysis:{secret_scanning:{status:"enabled"},secret_scanning_push_protection:{status:"enabled"}}}')
echo "$BODY" | gh api -X PATCH "repos/$REPO" --input - >/dev/null 2>&1 \
  && echo "reposecrets: secret scanning + push protection enabled" \
  || echo "reposecrets: WARN not enabled — public is free; PRIVATE needs GitHub Advanced Security. Skipped gracefully."
