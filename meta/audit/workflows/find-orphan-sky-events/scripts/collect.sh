#!/bin/bash
set -u
DIR="$SKY_DIR"
if [ ! -d "$DIR" ]; then printf 'error: dir not found: %s\n' "$DIR" >&2; exit 2; fi
LISTENS="$(mktemp /tmp/sky-orphan-listens.XXXXXX)"
EMITS="$(mktemp /tmp/sky-orphan-emits.XXXXXX)"
printf '%s\n' "$LISTENS" > /tmp/sky-orphan-listens.path
printf '%s\n' "$EMITS" > /tmp/sky-orphan-emits.path
found=0
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  found=1
  base="$(basename "$f")"
  grep -oE 'trigger\\.sky_event\\.event[[:space:]]*=[[:space:]]*"[^"]+"' "$f" | sed -E 's/.*"([^"]+)".*/\\1/' | while IFS= read -r ev; do [ -n "$ev" ] && printf '%s\t%s\n' "$ev" "$base"; done >> "$LISTENS"
  grep -E '(^|[^[:alnum:]_])emit([.[:space:]=]|$)' "$f" | while IFS= read -r line; do ev="$(printf '%s\n' "$line" | sed -E 's/payload[[:space:]]*=.*$//' | grep -oE '"[^"]+"' | tail -1 | tr -d '"')"; [ -n "$ev" ] && printf '%s\t%s\n' "$ev" "$base"; done >> "$EMITS"
done
if [ "$found" -eq 0 ]; then printf 'error: no .sky files in %s\n' "$DIR" >&2; exit 2; fi
printf 'collected: %s listener edge(s), %s emit edge(s)\n' "$(wc -l < "$LISTENS" | tr -d ' ')" "$(wc -l < "$EMITS" | tr -d ' ')"
