#!/bin/bash
set -euo pipefail
FILE="$SKY_NAME.sky"
if [ ! -f "$SKY_DIR/$FILE" ]; then echo "error: $SKY_DIR/$FILE not found" >&2; exit 1; fi
if ! git -C "$SKY_DIR" rev-parse --git-dir >/dev/null 2>&1; then echo "error: $SKY_DIR is not a git working tree" >&2; exit 1; fi
DIFF=$(git -C "$SKY_DIR" diff HEAD -- "$FILE" 2>/dev/null || true)
if [ -z "$DIFF" ]; then echo "NO_UNCOMMITTED_CHANGES"; else printf '%s\n' "$DIFF"; fi
