#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
FAIL=0
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  if ! skyway lint "$f" >/dev/null 2>&1; then
    FAIL=$((FAIL + 1))
    echo "still failing: $f"
  fi
done
if [ "$FAIL" -gt 0 ]; then echo "verify: $FAIL file(s) still failing"; exit 1; fi
echo 'verify: all .sky files lint clean'
exit 0
