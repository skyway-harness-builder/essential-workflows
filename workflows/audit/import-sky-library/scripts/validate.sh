#!/bin/bash
set -euo pipefail
SRC="$SKY_SOURCE"
DST="$SKY_DIR"
STAGE="$(mktemp /tmp/sky-import-stage.XXXXXX)"
echo "$STAGE" > /tmp/sky-import-stage.path
PASS=0
FAIL=0
SKIP=0
for f in "$SRC"/*.sky; do
  [ -e "$f" ] || continue
  BASE="$(basename "$f")"
  if [ -e "$DST/$BASE" ]; then
    echo "SKIP  $BASE (already exists in target)"
    SKIP=$((SKIP+1))
    continue
  fi
  if CODES="$(skyway lint "$f" 2>&1)"; then
    echo "PASS  $BASE"
    echo "$f" >> "$STAGE"
    PASS=$((PASS+1))
  else
    SUMMARY="$(printf '%s' "$CODES" | grep -Eo 'SKY-[A-Z]+-[0-9]+' | sort -u | tr '\n' ',' | sed 's/,$//' || true)"
    [ -n "$SUMMARY" ] || SUMMARY="lint-failed"
    echo "FAIL  $BASE ($SUMMARY)"
    FAIL=$((FAIL+1))
  fi
done
echo "---"
echo "validate summary: pass=$PASS fail=$FAIL skip=$SKIP"
echo "staging list: $STAGE"
