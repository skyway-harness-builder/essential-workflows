#!/bin/bash
set -euo pipefail
U_OLD=$(printf '%s' "$SKY_OLD" | tr 'a-z-' 'A-Z_')
U_NEW=$(printf '%s' "$SKY_NEW" | tr 'a-z-' 'A-Z_')
PAT="\{\{$SKY_OLD\}\}|\\\$SKY_$U_OLD([^A-Za-z0-9_]|\$)|§$SKY_OLD§|∆$SKY_OLD∆|\"$SKY_OLD\""
touched=0
for f in "$SKY_DIR"/*.sky; do
  [ -e "$f" ] || continue
  if ! grep -qE "$PAT" "$f" 2>/dev/null; then continue; fi
  sed "s/{{$SKY_OLD}}/{{$SKY_NEW}}/g; s/\$SKY_$U_OLD\([^A-Za-z0-9_]\)/\$SKY_$U_NEW\1/g; s/\$SKY_$U_OLD\$/\$SKY_$U_NEW/g; s/§$SKY_OLD§/§$SKY_NEW§/g; s/∆$SKY_OLD∆/∆$SKY_NEW∆/g; s/\"$SKY_OLD\"/\"$SKY_NEW\"/g" "$f" > "$f.tmp" && mv "$f.tmp" "$f"
  touched=$((touched+1))
  echo "[codemod] rewrote $(basename "$f")"
done
echo "$touched" > /tmp/codemod-sky-var.touched
echo "[codemod] applied $SKY_OLD -> $SKY_NEW in $touched file(s)"
