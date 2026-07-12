#!/bin/bash
set -euo pipefail
if [ ! -d "${SKY_DIR:-}" ]; then echo "[catalog] no such dir: ${SKY_DIR:-}"; exit 1; fi
N=$(find "$SKY_DIR" -maxdepth 1 -name '*.sky' | wc -l | tr -d ' ')
echo "[catalog] indexing $N workflow(s) in $SKY_DIR"
