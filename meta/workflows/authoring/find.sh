#!/bin/bash
set -eu
DIR="$SKY_DIR"
NAME="$SKY_NAME"
MODE="${SKY_MODE:-archive}"
if [ "$MODE" != "archive" ] && [ "$MODE" != "restore" ]; then
  echo "ERROR: mode must be 'archive' or 'restore', got '$MODE'" >&2
  exit 1
fi
if [ "$MODE" = "restore" ]; then
  SOURCE="$DIR/_archive/$NAME.sky"
  DEST="$DIR/$NAME.sky"
else
  SOURCE="$DIR/$NAME.sky"
  DEST="$DIR/_archive/$NAME.sky"
fi
if [ ! -f "$SOURCE" ]; then
  echo "ERROR: source not found: $SOURCE" >&2
  exit 1
fi
if [ -e "$DEST" ]; then
  echo "ERROR: destination already exists: $DEST" >&2
  exit 1
fi
echo "mode=$MODE"
echo "source=$SOURCE"
echo "dest=$DEST"
