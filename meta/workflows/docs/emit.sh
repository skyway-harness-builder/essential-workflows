#!/bin/bash
set -u
BULLET="$SKY_OUTPUT_DESCRIBE"
LOG="$SKY_DIR/CHANGELOG.md"
DATE=$(date +%Y-%m-%d)
if [ ! -f "$LOG" ]; then printf '# Changelog\n' > "$LOG"; fi
printf '%s\n' "$BULLET"
printf '\n## %s - %s\n%s\n' "$DATE" "$SKY_NAME" "$BULLET" >> "$LOG"
echo "appended entry for $SKY_NAME to $LOG"
