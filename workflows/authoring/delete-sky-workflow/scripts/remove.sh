#!/bin/bash
set -euo pipefail
F="$SKY_DIR/$SKY_NAME.sky"
rm "$F" && echo "[delete] removed $F"
