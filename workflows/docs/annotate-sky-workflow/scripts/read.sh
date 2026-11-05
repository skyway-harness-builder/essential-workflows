#!/bin/bash
set -euo pipefail
F="$SKY_DIR/$SKY_NAME.sky"
if [ ! -f "$F" ]; then
  echo "not found: $F" >&2
  exit 1
fi
echo "target: $F"
grep -c '^§' "$F" | sed 's/^/node-config blocks: /' || true
