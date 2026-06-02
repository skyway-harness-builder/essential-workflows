#!/bin/bash
set -e
SKY_FILE="$SKY_DIR/$SKY_NAME.sky"
if [ ! -f "$SKY_FILE" ]; then
  echo "NOT_FOUND: $SKY_FILE"
  exit 1
fi
if [ -z "$SKY_RUN" ]; then
  echo "NO_RUN_ID"
  exit 1
fi
echo "=== run id ==="
echo "$SKY_RUN"
echo "=== run logs (best-effort) ==="
skyway logs "$SKY_RUN" 2>&1 || echo "LOGS_UNAVAILABLE: $SKY_RUN"
echo "=== workflow source: $SKY_FILE ==="
cat "$SKY_FILE"
