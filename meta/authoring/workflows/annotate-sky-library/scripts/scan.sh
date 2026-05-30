#!/usr/bin/env bash
set -euo pipefail

DIR="${SKY_DIR:?var dir is required}"

if [ ! -d "$DIR" ]; then
  echo "error: directory not found: $DIR" >&2
  exit 1
fi

found=0
while IFS= read -r -d '' f; do
  if ! grep -qE '※[[:alnum:]_]+※' "$f"; then
    dirname "$f"
    found=1
  fi
done < <(find "$DIR" -name "workflow.sky" -print0 | sort -z)

if [ "$found" -eq 0 ]; then
  echo "NONE"
fi
