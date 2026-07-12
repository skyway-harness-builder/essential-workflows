#!/bin/bash
set -euo pipefail
REPO=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.repo // empty')
[ -n "$REPO" ] || { echo 'DF_BOARDPREP_FAILED: no repo from preflight' >&2; exit 1; }
mk() { gh label create "$1" --color "$2" --description "$3" --repo "$REPO" --force >/dev/null 2>&1 && echo "  ok $1" || echo "  warn could not ensure $1"; }
mk triaging fbca04 'Issue is being classified'
mk accepted 0e8a16 'Approved for the factory to attempt'
mk rejected ffffff 'Will not be worked on by the factory'
mk ready-for-sky 1d76db 'Queued for an implementation run'
mk in-progress 0052cc 'Sky is implementing'
mk needs-review e4882a 'PR open, awaiting human spot-check / validator'
mk approved 2ea44f 'Validator + human passed'
mk needs-fix d93f0b 'Validator/human bounced it back'
mk escalated b60205 'Routed to a human (low confidence / high stakes)'
echo "labels: ensured 9 lifecycle labels on $REPO"