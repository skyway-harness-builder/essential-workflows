#!/bin/bash
set -euo pipefail
REPO=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.repo // empty')
gh repo edit "$REPO" --enable-squash-merge --enable-merge-commit=false --enable-rebase-merge=false --enable-auto-merge --delete-branch-on-merge --allow-update-branch --enable-issues --enable-wiki --enable-projects >/dev/null 2>&1 \
  && echo "repogeneral: merge hygiene + features set on $REPO (squash-only, auto-merge, delete-branch, allow-update-branch, issues/wiki/projects enabled)" \
  || echo "repogeneral: WARN could not edit repo settings — need admin on $REPO"
