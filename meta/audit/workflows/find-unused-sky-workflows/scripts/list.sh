#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
if [ -z "$DIR" ]; then echo 'ERROR: --var dir is required' >&2; exit 1; fi
if [ ! -d "$DIR" ]; then echo "ERROR: not a directory: $DIR" >&2; exit 1; fi
FOUND=0
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  b="$(basename "$f" .sky)"
  echo "$b"
  FOUND=$((FOUND + 1))
done
if [ "$FOUND" -eq 0 ]; then echo "ERROR: no .sky files in $DIR" >&2; exit 1; fi
echo "---" >&2
echo "listed $FOUND workflow file(s) in $DIR" >&2