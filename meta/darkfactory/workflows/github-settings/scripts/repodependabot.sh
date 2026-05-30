#!/bin/bash
set -u
REPO=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.repo // empty')
gh api -X PUT "repos/$REPO/vulnerability-alerts" >/dev/null 2>&1 && echo "  ok Dependabot vulnerability alerts" || echo "  warn vulnerability alerts"
gh api -X PUT "repos/$REPO/automated-security-fixes" >/dev/null 2>&1 && echo "  ok Dependabot automated security fixes" || echo "  warn automated security fixes"
echo "repodependabot: Dependabot enabled on $REPO"
