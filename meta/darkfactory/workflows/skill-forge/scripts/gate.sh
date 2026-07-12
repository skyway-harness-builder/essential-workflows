#!/bin/bash
set -euo pipefail
CLEAN=$(printf '%s' "${SKY_OUTPUT_LINT:-}" | grep -oE '"clean":"(true|false)"' | grep -oE '(true|false)' | tail -1 || true)
DRY=$(printf '%s' "${SKY_OUTPUT_DRY_RUN:-}" | grep -oE '"dry_ok":"(true|false)"' | grep -oE '(true|false)' | tail -1 || true)
VERDICT=$(printf '%s' "${SKY_OUTPUT_JUDGE:-}" | grep -oE 'SKY_FORGE delivers=(true|false)' | tail -1 | grep -oE '(true|false)$' || true)
echo "gate: clean=${CLEAN:-missing} dry_ok=${DRY:-missing} judge=${VERDICT:-missing}" >&2
if [ "$CLEAN" = 'true' ] && [ "$DRY" = 'true' ] && [ "$VERDICT" = 'true' ]; then echo '{"delivers":"true"}'; else echo '{"delivers":"false"}'; fi
