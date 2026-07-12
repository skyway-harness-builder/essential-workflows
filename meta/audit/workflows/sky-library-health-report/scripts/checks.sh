#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
printf 'workflow\tlint\tllm_uncapped\tlast_run\n'
for f in "$DIR"/*.sky; do
  [ -e "$f" ] || continue
  BASE=$(basename "$f" .sky)
  if skyway lint "$f" >/dev/null 2>&1; then LINT=pass; else LINT=fail; fi
  HAS_CLAUDE=no
  if grep -Eq '^[[:space:]]*model[[:space:]]*=' "$f"; then HAS_CLAUDE=yes; fi
  HAS_CAP=no
  if grep -Eq '^[[:space:]]*max_budget_usd[[:space:]]*=' "$f"; then HAS_CAP=yes; fi
  if [ "$HAS_CLAUDE" = yes ] && [ "$HAS_CAP" = no ]; then UNCAPPED=yes; else UNCAPPED=no; fi
  LAST=never
  REC=$(skyway logs 2>/dev/null | grep -F "$BASE" | head -n 1 || true)
  if [ -n "$REC" ]; then LAST=seen; fi
  printf '%s\t%s\t%s\t%s\n' "$BASE" "$LINT" "$UNCAPPED" "$LAST"
done
