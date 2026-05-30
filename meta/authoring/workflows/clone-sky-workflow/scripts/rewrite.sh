#!/bin/bash
set -e
DST="$SKY_DIR/$SKY_NEW_NAME.sky"
sed "s/^name = \"$SKY_NAME\"/name = \"$SKY_NEW_NAME\"/" "$DST" > "$DST.tmp" && mv "$DST.tmp" "$DST"
grep -v '^trigger\.' "$DST" > "$DST.tmp" && mv "$DST.tmp" "$DST"
stripped=$(grep -c '^trigger\.' "$DST" 2>/dev/null || echo 0)
echo "[clone] set name -> $SKY_NEW_NAME and neutralized trigger (remaining trigger lines: $stripped)"