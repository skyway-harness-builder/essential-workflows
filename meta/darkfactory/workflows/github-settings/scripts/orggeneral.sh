#!/bin/bash
set -u
P="${SKY_OUTPUT_PREFLIGHT:-}"
ORG=$(echo "$P" | jq -r '.org // empty')
TIER=$(echo "$P" | jq -r '.tier // empty')
TFA=$(gh api "orgs/$ORG" --jq '.two_factor_requirement_enabled // "unknown"' 2>/dev/null)
if [ "$TIER" = paid ]; then
  BODY=$(jq -n '{default_repository_permission:"read",web_commit_signoff_required:true,dependabot_alerts_enabled_for_new_repositories:true,dependabot_security_updates_enabled_for_new_repositories:true,advanced_security_enabled_for_new_repositories:true,secret_scanning_enabled_for_new_repositories:true,secret_scanning_push_protection_enabled_for_new_repositories:true}')
else
  BODY=$(jq -n '{default_repository_permission:"read",web_commit_signoff_required:true,dependabot_alerts_enabled_for_new_repositories:true,dependabot_security_updates_enabled_for_new_repositories:true}')
fi
OUT=$(echo "$BODY" | gh api -X PATCH "orgs/$ORG" --input - 2>&1)
if echo "$OUT" | grep -q '"id"'; then
  echo "orggeneral: org defaults applied on $ORG (tier=$TIER)"
  echo "  ok default_repository_permission=read, web_commit_signoff_required=true, dependabot defaults for new repos"
  [ "$TIER" = paid ] && echo "  ok advanced_security/secret_scanning/push_protection enabled for new repos (paid)"
else
  echo "orggeneral: WARN could not PATCH org settings on $ORG — $OUT"
fi
echo "  info two_factor_requirement_enabled=$TFA (read-only in the org PATCH API — enable via org Settings > Security if needed)"
