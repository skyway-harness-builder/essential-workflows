#!/bin/bash
set -u
if [ ! -d "$SKY_DIR" ]; then echo "[codemod] no such dir: $SKY_DIR" >&2; exit 1; fi
if [ -z "$SKY_OLD" ] || [ -z "$SKY_NEW" ]; then echo "[codemod] both --var old and --var new are required" >&2; exit 1; fi
U_OLD=$(printf '%s' "$SKY_OLD" | tr 'a-z-' 'A-Z_')
U_NEW=$(printf '%s' "$SKY_NEW" | tr 'a-z-' 'A-Z_')
PAT="\{\{$SKY_OLD\}\}|\\\$SKY_$U_OLD([^A-Za-z0-9_]|\$)|§$SKY_OLD§|∆$SKY_OLD∆|\"$SKY_OLD\""
echo "[codemod] $SKY_OLD -> $SKY_NEW"
echo "[codemod] forms: {{$SKY_OLD}} -> {{$SKY_NEW}} | \$SKY_$U_OLD -> \$SKY_$U_NEW | §$SKY_OLD§/∆$SKY_OLD∆ -> §$SKY_NEW§/∆$SKY_NEW∆ | \"$SKY_OLD\" id-refs -> \"$SKY_NEW\""
hits=0
for f in "$SKY_DIR"/*.sky; do
  [ -e "$f" ] || continue
  out=$(grep -nE "$PAT" "$f" 2>/dev/null || true)
  if [ -n "$out" ]; then
    hits=$((hits+1))
    echo "--- $(basename "$f")"
    printf '%s\n' "$out" | sed 's/^/    /'
  fi
done
if [ "$hits" -eq 0 ]; then echo "[codemod] no occurrences of '$SKY_OLD' (any form) in $SKY_DIR — nothing to do"; exit 1; fi
echo "[codemod] $hits file(s) affected — review above, then approve the gate"
