#!/bin/bash
set -euo pipefail
SRC="$SKY_SOURCE"
DST="$SKY_DIR"
if [ ! -d "$SRC" ]; then echo "ERROR: source dir not found: $SRC" >&2; exit 1; fi
if [ ! -d "$DST" ]; then echo "ERROR: target dir not found: $DST" >&2; exit 1; fi
FOUND=0
for f in "$SRC"/*.sky; do
  if [ -e "$f" ]; then FOUND=$((FOUND+1)); echo "$f"; fi
done
if [ "$FOUND" -eq 0 ]; then echo "ERROR: no .sky files in source: $SRC" >&2; exit 1; fi
echo "---"
echo "enumerated $FOUND candidate .sky file(s) in $SRC"
