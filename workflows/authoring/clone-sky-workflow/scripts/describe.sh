#!/bin/bash
set -euo pipefail
DST="${SKY_DIR:-}/${SKY_NEW_NAME:-}.sky"
skyway describe "$DST" 2>/dev/null || true
echo "[clone] done -> $DST"