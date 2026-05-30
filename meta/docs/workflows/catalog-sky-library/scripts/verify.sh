#!/bin/bash
set -e
IDX="$SKY_DIR/INDEX.md"
if [ ! -s "$IDX" ]; then echo "[catalog] INDEX.md missing or empty"; exit 1; fi
missing=0
for f in "$SKY_DIR"/*.sky; do
  [ -e "$f" ] || continue
  b=$(basename "$f" .sky)
  if ! grep -q "$b" "$IDX"; then echo "[catalog] not listed: $b"; missing=$((missing+1)); fi
done
if [ "$missing" -gt 0 ]; then echo "[catalog] $missing workflow(s) missing from INDEX.md"; exit 1; fi
echo "[catalog] INDEX.md covers all workflows -> $IDX"
