#!/bin/bash
set -euo pipefail
OWNER=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.owner // empty')
PROJECT=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.project // empty')
FL=$(gh project field-list "$PROJECT" --owner "$OWNER" --format json 2>/dev/null || echo '{}')
MISSF=''
for f in Status Priority Size 'Idea Stage' 'Bug Stage'; do echo "$FL" | grep -q "$f" || MISSF="$MISSF $f;"; done
MISSS=''
for s in Icebox Backlog Ready 'Agent Running' 'Awaiting Review' 'Revisions Requested' Done; do echo "$FL" | grep -q "$s" || MISSS="$MISSS $s;"; done
echo "fields_missing: ${MISSF:-none}"
echo "status_options_missing: ${MISSS:-none}"