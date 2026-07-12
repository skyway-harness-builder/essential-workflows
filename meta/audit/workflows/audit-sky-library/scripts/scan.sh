#!/bin/bash
set -euo pipefail
if [ ! -d "${SKY_DIR:-}" ]; then echo "[audit] no such dir: ${SKY_DIR:-}"; exit 1; fi
N=$(find "$SKY_DIR" -maxdepth 1 -name '*.sky' | wc -l | tr -d ' ')
echo "[audit] $N workflow(s) in $SKY_DIR"
if [ "$N" -eq 0 ]; then echo "[audit] nothing to lint"; fi
