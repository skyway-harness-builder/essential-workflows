#!/bin/bash
set -u
P="$SKY_OUTPUT_READ_SKILL"
DIR=$(printf '%s' "$P" | sed -n 's/^skill_dir=//p' | head -1)
if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then echo 'lint-scripts: skill_dir unresolved — deferring all checks to CI'; exit 0; fi
echo '=== static-script-checks ==='
FOUND=0
while IFS= read -r f; do
  FOUND=1
  case "$f" in
    *.sh) if bash -n "$f" 2>/tmp/sky-forge-lint.err; then echo "OK   bash -n $f"; else echo "FAIL bash -n $f"; cat /tmp/sky-forge-lint.err; fi ;;
    *.js|*.mjs|*.cjs) if command -v node >/dev/null 2>&1; then if node --check "$f" 2>/tmp/sky-forge-lint.err; then echo "OK   node --check $f"; else echo "FAIL node --check $f"; cat /tmp/sky-forge-lint.err; fi; else echo "DEFER no node toolchain: $f (CI checks it)"; fi ;;
    *.go) echo "DEFER no Go toolchain in container: $f (CI checks it)" ;;
    *) echo "DEFER no in-container static check: $f (CI checks it)" ;;
  esac
done <<EOF
$(cd "$DIR" && find . -type f ! -name 'SKILL.md' | sed "s@^\.@$DIR@")
EOF
if [ "$FOUND" = 0 ]; then echo 'no bundled scripts — SKILL.md only'; fi
echo '=== end static-script-checks ==='
