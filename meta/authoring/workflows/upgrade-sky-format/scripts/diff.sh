#!/bin/bash
set -euo pipefail
git -C "$SKY_DIR" diff -- "$SKY_NAME.sky" 2>/dev/null || true
