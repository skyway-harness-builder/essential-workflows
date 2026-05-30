#!/bin/bash
set -u
NAME="${SKY_SKILL_NAME:-}"
REPO="${SKY_SKILL_REPO:-$PWD}"
REL=".claude/skills/$NAME"
DIR="$REPO/$REL"
if [ -z "$NAME" ] || [ ! -d "$DIR" ]; then echo "SKILL_FORGE_FAILED: skill_dir $DIR missing" >&2; exit 1; fi
cd "$REPO" || { echo 'SKILL_FORGE_FAILED: cd repo' >&2; exit 1; }
if git diff --quiet -- "$REL" && git diff --cached --quiet -- "$REL"; then echo 'already passing — no changes under skill_dir, no PR'; exit 0; fi
STAGED=$(git status --porcelain -- "$REL" | awk '{print $2}')
for p in $STAGED; do
  case "$p" in
    MISSION.md|FACTORY_RULES.md|.github/*|.sky/*|.claude/skills/*/learnings/*|*/learnings/*) echo "SKILL_FORGE_FAILED: protected path staged: $p" >&2; exit 1 ;;
  esac
done
BR="skill-forge/$NAME-$(date -u +%Y%m%d-%H%M%S)"
git checkout -b "$BR" || { echo 'SKILL_FORGE_FAILED: branch' >&2; exit 1; }
git add -- "$REL" || { echo 'SKILL_FORGE_FAILED: add' >&2; exit 1; }
git commit -m "skill-forge: improve $NAME skill toward eval bar" -m 'Staged by skill-forge meta-workflow. CI is the quality gate; human merge required.' || { echo 'SKILL_FORGE_FAILED: commit' >&2; exit 1; }
git push -u origin "$BR" || { echo 'SKILL_FORGE_FAILED: push' >&2; exit 1; }
URL=$(gh pr create --title "skill-forge: improve $NAME skill" --body "Automated skill-forge pass on the \`$NAME\` skill. All edits scoped to \`$REL\`. Static script checks ran in-container (bash -n / node --check); other languages defer to CI. CI IS THE QUALITY GATE — review + merge by a human. Protected files (MISSION.md, FACTORY_RULES.md, .github/, .sky/, learnings) were guarded and never staged." 2>&1) && echo "PR: $URL" || echo "pr-create note: $URL"
