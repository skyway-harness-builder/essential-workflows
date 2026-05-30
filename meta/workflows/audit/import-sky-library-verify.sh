#!/bin/bash
set -eu
DST="$SKY_DIR"
STAGE="$(cat /tmp/sky-import-stage.path)"
FAILED=0
CHECKED=0
if [ -f "$STAGE" ]; then
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    BASE="$(basename "$f")"
    TARGET="$DST/$BASE"
    [ -e "$TARGET" ] || continue
    CHECKED=$((CHECKED+1))
    if sky lint "$TARGET" >/dev/null 2>&1; then
      echo "OK    $BASE"
    else
      echo "BROKEN $BASE (lint failed after import)"
      FAILED=$((FAILED+1))
    fi
  done < "$STAGE"
fi
rm "$STAGE"
rm /tmp/sky-import-stage.path
echo "---"
echo "verify: checked=$CHECKED broken=$FAILED"
if [ "$FAILED" -ne 0 ]; then echo "ERROR: $FAILED imported file(s) fail lint" >&2; exit 1; fi
echo "import complete: all imported files lint clean"
