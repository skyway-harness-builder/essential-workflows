#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
NAME="$SKY_NAME"
MODE="${SKY_MODE:-archive}"
if [ "$MODE" = "restore" ]; then
  SOURCE="$DIR/_archive/$NAME.sky"
  DEST="$DIR/$NAME.sky"
else
  SOURCE="$DIR/$NAME.sky"
  DEST="$DIR/_archive/$NAME.sky"
fi
if [ "$MODE" = "archive" ]; then
  mkdir -p "$DIR/_archive"
  grep -v '^trigger\.' "$SOURCE" > "$SOURCE.tmp"
  mv "$SOURCE.tmp" "$SOURCE"
fi
if command -v git >/dev/null 2>&1 && git -C "$DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$DIR" mv "$SOURCE" "$DEST" || mv "$SOURCE" "$DEST"
else
  mv "$SOURCE" "$DEST"
fi
echo "moved $SOURCE -> $DEST"
