#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
if [ -z "$DIR" ]; then echo 'ERROR: --var dir is required' >&2; exit 2; fi
if [ ! -d "$DIR" ]; then echo "ERROR: not a directory: $DIR" >&2; exit 2; fi
N=0
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  echo "$f"
  N=$((N+1))
done
if [ "$N" -eq 0 ]; then echo "ERROR: no .sky files in $DIR" >&2; exit 2; fi
echo "inventory: $N workflow(s) in $DIR" >&2
