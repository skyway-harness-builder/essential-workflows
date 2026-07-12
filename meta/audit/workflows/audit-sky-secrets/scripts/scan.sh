#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
if [ -z "$DIR" ]; then echo 'ERROR: --var dir is required' >&2; exit 2; fi
if [ ! -d "$DIR" ]; then echo "ERROR: not a directory: $DIR" >&2; exit 2; fi
FAIL_COUNT=0
TOTAL=0
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  TOTAL=$((TOTAL + 1))
  if ! OUT=$(skyway lint "$f" 2>&1); then
    FAIL_COUNT=$((FAIL_COUNT + 1))
    echo "FAIL: $f"
    printf '%s\n' "$OUT" | grep -E 'SKY-WF-[0-9]+' || printf '%s\n' "$OUT"
  fi
done
if [ "$TOTAL" -eq 0 ]; then echo "ERROR: no .sky files found in $DIR" >&2; exit 2; fi
echo "---"
echo "scanned=$TOTAL failing=$FAIL_COUNT"
if [ "$FAIL_COUNT" -gt 0 ]; then exit 1; fi
exit 0