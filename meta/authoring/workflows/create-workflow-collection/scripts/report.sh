#!/usr/bin/env bash
# report.sh — print repo URL, install command, and next steps.
set -euo pipefail

VENDOR="${SKY_VENDOR:-}"
ORG="${SKY_ORG:-$(gh api user --jq '.login')}"
REPO="${SKY_REPO:-${VENDOR}-workflows}"

echo ""
echo "✓ https://github.com/$ORG/$REPO"
echo ""
echo "Install locally:"
echo "  skyway library add $ORG/$REPO"
echo ""
echo "Next steps:"
echo "  1. Add workflows under  workflows/$VENDOR/<name>/"
echo "  2. Register each in     manifest.yaml"
echo "  3. Run                  bash scripts/validate-manifest.sh"
echo "  4. Commit + push        git add -A && git commit -m 'feat: add first workflow'"
echo ""
echo "Run your first workflow:"
echo "  skyway run hello-world"
