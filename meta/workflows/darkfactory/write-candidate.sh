#!/bin/bash
set -u
RUNTMP=$(mktemp -d)
REPO_WF=".sky/workflows"
mkdir -p "$REPO_WF"
TMP_FILE="$RUNTMP/forge-candidate.sky"
REPO_FILE="$REPO_WF/forge-candidate.sky"
printf '%s' "$SKY_OUTPUT_AUTHOR" > "$TMP_FILE"
cp "$TMP_FILE" "$REPO_FILE"
if ! grep -q 'name = "forge-candidate"' "$TMP_FILE"; then echo 'WARN: candidate ⊕meta⊕ name is not forge-candidate — dry-run resolution may fail' >&2; fi
echo '=== candidate ==='
echo "tmp_path=$TMP_FILE"
echo "repo_path=$REPO_FILE"
echo "candidate_name=forge-candidate"
