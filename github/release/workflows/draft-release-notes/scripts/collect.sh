#!/bin/bash
set -u
REPO="${SKY_REPO_FULL_NAME:-}"
if [ -z "$REPO" ]; then
  REPO="$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null || true)"
fi
if [ -z "$REPO" ]; then
  echo 'ERROR: cannot resolve repo (no webhook payload; gh repo view failed)' >&2
  exit 2
fi

TAGS="$(gh api "repos/$REPO/releases?per_page=30" --jq '.[] | select(.draft == false) | .tag_name' 2>/dev/null || true)"
TAG="${SKY_TAG:-}"
if [ -z "$TAG" ]; then
  TAG="$(printf '%s\n' "$TAGS" | head -1)"
fi
if [ -z "$TAG" ]; then
  echo "ERROR: no published release found on $REPO and no --var tag given" >&2
  exit 2
fi
PREV="$(printf '%s\n' "$TAGS" | awk -v t="$TAG" 'found { print; exit } $0 == t { found = 1 }')"

echo "repo=$REPO"
echo "tag=$TAG"
echo "prev=${PREV:-<none>}"
echo "--- current release body ---"
gh release view "$TAG" --repo "$REPO" --json body --jq '.body // "<empty>"' 2>/dev/null || echo "<unavailable>"
echo "--- commits ---"
if [ -n "$PREV" ]; then
  gh api "repos/$REPO/compare/$PREV...$TAG" \
    --jq '.commits[] | "* " + .sha[0:7] + " " + (.commit.message | split("\n")[0]) + " (" + (.author.login // .commit.author.name) + ")"' \
    2>/dev/null || echo "<compare unavailable>"
else
  gh api "repos/$REPO/commits?sha=$TAG&per_page=50" \
    --jq '.[] | "* " + .sha[0:7] + " " + (.commit.message | split("\n")[0])' \
    2>/dev/null || echo "<log unavailable>"
fi
exit 0
