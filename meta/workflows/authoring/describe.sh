#!/bin/bash
DST="$SKY_DIR/$SKY_NEW_NAME.sky"
sky describe "$DST" 2>/dev/null || true
echo "[clone] done -> $DST"