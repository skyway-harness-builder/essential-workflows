#!/bin/bash
set -eu
F="$SKY_DIR/$SKY_NAME.sky"
if [ ! -f "$F" ]; then
  echo "ERROR: no such .sky file: $F" >&2
  exit 1
fi
echo "resolved: $F"
echo "--- sky describe (best-effort) ---"
sky describe "$F" 2>/dev/null || echo "(sky describe unavailable; explain will read the file directly)"
