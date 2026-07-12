#!/bin/bash
set -euo pipefail
OWNER=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.owner // empty')
REPO=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.repo // empty')
PROJECT=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.project // empty')
OUT=$(gh project link "$PROJECT" --owner "$OWNER" --repo "$REPO" 2>&1) && echo "link: project $PROJECT linked to $REPO" || echo "link: note ($OUT) — an already-linked project is fine"