#!/usr/bin/env bash
# create.sh — create the GitHub repo from the workflow-collection-skeleton template.
set -euo pipefail

# ── resolve vars (same logic as preflight) ────────────────────────────────────
VENDOR="${SKY_VENDOR:-}"
VENDOR_NAME="${SKY_VENDOR_NAME:-$VENDOR}"
ORG="${SKY_ORG:-$(gh api user --jq '.login')}"
REPO="${SKY_REPO:-${VENDOR}-workflows}"
DESCRIPTION="${SKY_DESCRIPTION:-A collection of .sky workflows by ${VENDOR_NAME:-$VENDOR}}"

echo "[create] creating github.com/$ORG/$REPO from template..."

if ! gh repo create "$ORG/$REPO" \
  --template "skyway-harness-builder/workflow-collection-skeleton" \
  --public \
  --description "$DESCRIPTION" 2>&1; then
  echo "" >&2
  echo "ERROR: repo creation failed. Does github.com/$ORG/$REPO already exist?" >&2
  exit 1
fi

echo "[create] repo created: https://github.com/$ORG/$REPO"
