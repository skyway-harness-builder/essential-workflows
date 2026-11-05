#!/usr/bin/env bash
# setup.sh — clone, configure (token replace + dir rename + README strip), commit, push.
set -euo pipefail

# ── resolve vars ──────────────────────────────────────────────────────────────
VENDOR="${SKY_VENDOR:-}"
VENDOR_NAME="${SKY_VENDOR_NAME:-$VENDOR}"
ORG="${SKY_ORG:-$(gh api user --jq '.login')}"
REPO="${SKY_REPO:-${VENDOR}-workflows}"
DESCRIPTION="${SKY_DESCRIPTION:-A collection of .sky workflows by ${VENDOR_NAME}}"

AUTHOR_NAME="$(git config user.name 2>/dev/null || echo 'Your Name')"
AUTHOR_EMAIL="$(git config user.email 2>/dev/null || echo 'you@example.com')"
AUTHOR_USERNAME="$(gh api user --jq '.login' 2>/dev/null || echo "$ORG")"
TODAY="$(date +%Y-%m-%d)"

# ── temp clone dir ────────────────────────────────────────────────────────────
TMPDIR_BASE="$(mktemp -d)"
CLONE_DIR="$TMPDIR_BASE/$REPO"
trap 'rm -rf "$TMPDIR_BASE"' EXIT

echo "[setup] cloning github.com/$ORG/$REPO..."
gh repo clone "$ORG/$REPO" "$CLONE_DIR" -- --quiet

cd "$CLONE_DIR"

# ── token replacements ────────────────────────────────────────────────────────
echo "[setup] replacing tokens..."

export _SKY_VENDOR="$VENDOR"
export _SKY_VENDOR_NAME="$VENDOR_NAME"
export _SKY_AUTHOR_NAME="$AUTHOR_NAME"
export _SKY_AUTHOR_EMAIL="$AUTHOR_EMAIL"
export _SKY_AUTHOR_USERNAME="$AUTHOR_USERNAME"
export _SKY_REPO="$REPO"
export _SKY_ORG="$ORG"
export _SKY_DESCRIPTION="$DESCRIPTION"
export _SKY_TODAY="$TODAY"

find . -type f \
  -not -path './.git/*' \
  | python3 -c "
import os, sys

tokens = [
  ('__vendor__',              os.environ['_SKY_VENDOR']),
  ('__vendor_name__',         os.environ['_SKY_VENDOR_NAME']),
  ('__author_name__',         os.environ['_SKY_AUTHOR_NAME']),
  ('__author_email__',        os.environ['_SKY_AUTHOR_EMAIL']),
  ('__author_username__',     os.environ['_SKY_AUTHOR_USERNAME']),
  ('__repo_name__',           os.environ['_SKY_REPO']),
  ('__github_org__',          os.environ['_SKY_ORG']),
  ('__package_description__', os.environ['_SKY_DESCRIPTION']),
  ('__today__',               os.environ['_SKY_TODAY']),
]

for line in sys.stdin:
  path = line.rstrip('\n')
  try:
    with open(path, encoding='utf-8', errors='ignore') as fh:
      content = fh.read()
    for old, new in tokens:
      content = content.replace(old, new)
    with open(path, 'w', encoding='utf-8') as fh:
      fh.write(content)
  except (OSError, IOError):
    pass
"

# ── rename placeholder workflow directory ─────────────────────────────────────
if [ -d "workflows/__vendor__" ]; then
  echo "[setup] renaming workflows/__vendor__/ → workflows/$VENDOR/"
  mv "workflows/__vendor__" "workflows/$VENDOR"
fi

# ── strip <!--delete--> block from README ─────────────────────────────────────
echo "[setup] stripping onboarding block from README.md..."
python3 - README.md << 'PYEOF'
import re, sys
path = sys.argv[1]
content = open(path).read()
content = re.sub(r'\n*<!--delete-->.*?<!--/delete-->\n*', '\n\n', content, flags=re.DOTALL)
open(path, 'w').write(content)
PYEOF

# ── commit and push ───────────────────────────────────────────────────────────
echo "[setup] committing..."
git add -A
git commit -m "chore: configure skeleton"
git push --quiet

echo "[setup] done — pushed to github.com/$ORG/$REPO"
