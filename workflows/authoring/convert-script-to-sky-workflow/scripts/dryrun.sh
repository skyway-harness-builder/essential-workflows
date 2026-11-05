#!/bin/bash
set -euo pipefail
cd "${SKY_DIR:-}" || exit 0
skyway run "${SKY_NAME:-}" --dry-run 2>&1 || true
