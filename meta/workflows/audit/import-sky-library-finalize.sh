#!/bin/bash
set -eu
DST="$SKY_DIR"
STAGE="$(cat /tmp/sky-import-stage.path)"
if [ ! -f "$STAGE" ]; then echo "ERROR: staging list missing: $STAGE" >&2; exit 1; fi
KEPT=0
SKIPPED=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  BASE="$(basename "$f")"
  if [ -e "$DST/$BASE" ]; then
    echo "SKIPPED  $BASE (appeared in target since validate)"
    SKIPPED=$((SKIPPED+1))
    continue
  fi
  cp "$f" "$DST/$BASE"
  echo "KEPT     $BASE"
  KEPT=$((KEPT+1))
done < "$STAGE"
echo "---"
echo "manifest: kept=$KEPT skipped=$SKIPPED (rejected files were never staged)"
