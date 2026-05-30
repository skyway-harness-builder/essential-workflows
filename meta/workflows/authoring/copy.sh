#!/bin/bash
set -e
SRC="$SKY_DIR/$SKY_NAME.sky"
DST="$SKY_DIR/$SKY_NEW_NAME.sky"
if [ ! -f "$SRC" ]; then echo "[clone] no source workflow at $SRC"; echo "[clone] available in $SKY_DIR:"; ls "$SKY_DIR" 2>/dev/null || true; exit 1; fi
if [ -e "$DST" ]; then echo "[clone] destination already exists: $DST"; exit 1; fi
cp "$SRC" "$DST"
echo "[clone] copied $SKY_NAME -> $SKY_NEW_NAME"