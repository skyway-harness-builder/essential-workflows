#!/usr/bin/env bash
set -euo pipefail

while IFS= read -r f; do
  if ! grep -qE '※[[:alnum:]_-]+※' "$f"; then
    dirname "$f"
  fi
done < <(find "$SKY_DIR" -name "workflow.sky" | sort)
