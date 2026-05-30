#!/bin/bash
set -u
DIR="$SKY_DIR"
if [ -z "$DIR" ]; then echo 'ERROR: --var dir is required' >&2; exit 2; fi
if [ ! -d "$DIR" ]; then echo "ERROR: dir not a directory: $DIR" >&2; exit 2; fi
found=0
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  base="$(basename "$f")"
  name="${base%.sky}"
  printf '%s\t%s\n' "$name" "$f"
  found=$((found + 1))
done
if [ "$found" -eq 0 ]; then echo "ERROR: no .sky files in $DIR" >&2; exit 2; fi
echo "discovered $found workflow(s) in $DIR" >&2
