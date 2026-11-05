#!/bin/bash
set -euo pipefail
# Flat layout (<dir>/<name>.sky) or directory-unit layout (<dir>/<name>/workflow.sky, as installed by skyway library install).
SKY_FILE="${SKY_DIR:-}/${SKY_NAME:-}.sky"
if [ ! -f "$SKY_FILE" ]; then
  SKY_FILE="${SKY_DIR:-}/${SKY_NAME:-}/workflow.sky"
fi
if [ ! -f "$SKY_FILE" ]; then
  echo "NOT_FOUND: ${SKY_DIR:-}/${SKY_NAME:-}.sky and $SKY_FILE"
  exit 1
fi
if [ -z "${SKY_RUN:-}" ]; then
  echo "NO_RUN_ID"
  exit 1
fi
echo "=== run id ==="
echo "$SKY_RUN"
echo "=== run logs (best-effort) ==="
skyway logs "$SKY_RUN" 2>&1 || echo "LOGS_UNAVAILABLE: $SKY_RUN"
echo "=== workflow source: $SKY_FILE ==="
cat "$SKY_FILE"
