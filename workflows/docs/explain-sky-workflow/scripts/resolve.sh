#!/bin/bash
set -euo pipefail
F="$SKY_DIR/$SKY_NAME.sky"
if [ ! -f "$F" ]; then
  echo "ERROR: no such .sky file: $F" >&2
  exit 1
fi
echo "resolved: $F"
echo "--- skyway describe (best-effort) ---"
skyway describe "$F" 2>/dev/null || echo "(skyway describe unavailable; explain will read the file directly)"
