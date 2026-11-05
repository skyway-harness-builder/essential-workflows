#!/bin/bash
set -euo pipefail
if [ ! -d "${SKY_DIR:-}" ]; then echo "[triggers] no such dir: ${SKY_DIR:-}"; exit 1; fi
tmp=$(mktemp)
for f in "$SKY_DIR"/*.sky; do
  [ -e "$f" ] || continue
  base=$(basename "$f")
  ev=$(grep -oE 'trigger\.sky_event[[:space:]]*=[[:space:]]*"[^"]*"' "$f" | head -1 | grep -oE '"[^"]*"' | tr -d '"' || true)
  [ -n "$ev" ] && printf 'sky_event:%s\t%s\n' "$ev" "$base" >> "$tmp"
  cr=$(grep -oE 'trigger\.cron[[:space:]]*=[[:space:]]*"[^"]*"' "$f" | head -1 | grep -oE '"[^"]*"' | tr -d '"' || true)
  [ -n "$cr" ] && printf 'cron:%s\t%s\n' "$cr" "$base" >> "$tmp"
  ge=$(grep -oE 'trigger\.github\.event[[:space:]]*=[[:space:]]*"[^"]*"' "$f" | head -1 | grep -oE '"[^"]*"' | tr -d '"' || true)
  if [ -n "$ge" ]; then
    ac=$(grep -oE 'trigger\.github\.action[[:space:]]*=[[:space:]]*"[^"]*"' "$f" | head -1 | grep -oE '"[^"]*"' | tr -d '"' || true)
    lb=$(grep -oE 'trigger\.github\.label[[:space:]]*=[[:space:]]*"[^"]*"' "$f" | head -1 | grep -oE '"[^"]*"' | tr -d '"' || true)
    printf 'github:%s:%s:%s\t%s\n' "$ge" "$ac" "$lb" "$base" >> "$tmp"
  fi
done
bindings=$(wc -l < "$tmp" | tr -d ' ')
report=$(awk -F'\t' '{cnt[$1]++; files[$1]=files[$1]"\n    "$2} END{for (s in cnt) if (cnt[s] > 1) print "CONFLICT  " s files[s]}' "$tmp")
rm "$tmp"
echo "[triggers] checked $bindings non-manual trigger binding(s)"
if [ -n "$report" ]; then printf '%s\n' "$report"; echo "[triggers] conflicting trigger signature(s) found"; exit 1; fi
echo "[triggers] no conflicts"