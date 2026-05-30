#!/usr/bin/env bash
# preflight.sh — validate prerequisites and print resolved configuration.
set -euo pipefail

# ── resolve vars ──────────────────────────────────────────────────────────────
VENDOR="${SKY_VENDOR:-}"
VENDOR_NAME="${SKY_VENDOR_NAME:-}"
REPO="${SKY_REPO:-}"
ORG="${SKY_ORG:-}"
DESCRIPTION="${SKY_DESCRIPTION:-}"

# ── vendor is required ────────────────────────────────────────────────────────
if [ -z "$VENDOR" ]; then
  echo "ERROR: --var vendor=<slug> is required" >&2
  echo "  Example: sky run create-workflow-collection --var vendor=acme-corp --var repo=acme-workflows" >&2
  exit 1
fi

# ── gh installed ─────────────────────────────────────────────────────────────
if ! command -v gh &>/dev/null; then
  echo "ERROR: gh CLI is not installed." >&2
  echo "  Install: https://cli.github.com" >&2
  exit 1
fi

# ── gh authenticated ─────────────────────────────────────────────────────────
if ! gh auth status &>/dev/null; then
  echo "ERROR: gh is not authenticated. Run: gh auth login" >&2
  exit 1
fi

# ── resolve defaults ──────────────────────────────────────────────────────────
[ -z "$ORG" ]          && ORG="$(gh api user --jq '.login' 2>/dev/null || echo "")"
[ -z "$REPO" ]         && REPO="${VENDOR}-workflows"
[ -z "$VENDOR_NAME" ]  && VENDOR_NAME="$VENDOR"
[ -z "$DESCRIPTION" ]  && DESCRIPTION="A collection of .sky workflows by ${VENDOR_NAME}"

if [ -z "$ORG" ]; then
  echo "ERROR: could not resolve GitHub org — pass --var org=<org>" >&2
  exit 1
fi

echo "[preflight] resolved configuration:"
echo "  vendor      : $VENDOR"
echo "  vendor-name : $VENDOR_NAME"
echo "  org         : $ORG"
echo "  repo        : $REPO  →  github.com/$ORG/$REPO"
echo "  description : $DESCRIPTION"
echo "[preflight] OK"
