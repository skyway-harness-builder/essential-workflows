#!/bin/bash
set -u
REPO=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.repo // empty')
DEF=$(echo "${SKY_OUTPUT_PREFLIGHT:-}" | jq -r '.default_branch // empty')
[ -n "$DEF" ] || DEF=main
BODY=$(jq -n '{required_status_checks:null,enforce_admins:false,required_pull_request_reviews:{required_approving_review_count:1,dismiss_stale_reviews:true,require_code_owner_reviews:false},restrictions:null,required_linear_history:true,allow_force_pushes:false,allow_deletions:false,required_conversation_resolution:true}')
echo "$BODY" | gh api -X PUT "repos/$REPO/branches/$DEF/protection" --input - >/dev/null 2>&1 \
  && echo "repoprotection: applied on $DEF (>=1 PR review, dismiss stale, linear history, no force-push, conversation resolution)" \
  || echo "repoprotection: WARN not applied — needs admin + a PAID plan on PRIVATE repos (public is free). Re-run with --var tier=paid after upgrading."
