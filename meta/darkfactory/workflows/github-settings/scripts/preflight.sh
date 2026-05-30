#!/bin/bash
set -u
command -v gh >/dev/null 2>&1 || { echo 'DF_BOARDPREP_FAILED: gh not on PATH' >&2; exit 1; }
PROJECT="${SKY_PROJECT:-}"
echo "$PROJECT" | grep -qE '^[0-9]+$' || { echo 'DF_BOARDPREP_FAILED: --var project=<number> required' >&2; exit 1; }
REPO="${SKY_REPO:-}"
[ -n "$REPO" ] || REPO=$(gh repo view --json nameWithOwner -q '.nameWithOwner' 2>/dev/null)
echo "$REPO" | grep -qE '^[^/]+/[^/]+$' || { echo 'DF_BOARDPREP_FAILED: set --var repo=owner/name or run inside a repo' >&2; exit 1; }
OWNER="${SKY_OWNER:-}"
[ -n "$OWNER" ] || OWNER=$(echo "$REPO" | cut -d/ -f1)
gh project view "$PROJECT" --owner "$OWNER" >/dev/null 2>&1 || { echo "DF_BOARDPREP_FAILED: no access to project $PROJECT under $OWNER (need gh project scope)" >&2; exit 1; }
jq -n --arg owner "$OWNER" --arg repo "$REPO" --arg project "$PROJECT" '{owner:$owner,repo:$repo,project:$project}'