#!/bin/bash
set -u
NAME="${SKY_SKILL_NAME:-}"
if [ -z "$NAME" ]; then echo 'SKILL_FORGE_FAILED: skill_name var is required (sky run skill-forge --var skill_name=<name>)' >&2; exit 1; fi
REPO="${SKY_SKILL_REPO:-$PWD}"
if [ ! -d "$REPO/.git" ]; then echo "SKILL_FORGE_FAILED: $REPO is not a git checkout" >&2; exit 1; fi
DIR="$REPO/.claude/skills/$NAME"
if [ ! -f "$DIR/SKILL.md" ]; then echo "SKILL_FORGE_FAILED: no SKILL.md at $DIR" >&2; exit 1; fi
echo '=== skill-source ==='
echo "skill_name=$NAME"
echo "skill_repo=$REPO"
echo "skill_dir=$DIR"
echo '--- inventory ---'
( cd "$DIR" && find . -type f | sort )
echo '--- SKILL.md ---'
cat "$DIR/SKILL.md"
for f in $(cd "$DIR" && find . -type f ! -name 'SKILL.md' | sort); do
  REL="${f#./}"
  echo "--- script: $REL ---"
  cat "$DIR/$REL"
done
echo '=== end skill-source ==='
