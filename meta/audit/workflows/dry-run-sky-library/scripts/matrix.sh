#!/bin/bash
set -euo pipefail
rows="$SKY_OUTPUT_DRYRUN"
pass=0; fail=0; skip=0
printf '%-6s  %-32s  %s\n' 'PLAN' 'WORKFLOW' 'FIRST DIAGNOSTIC'
printf '%-6s  %-32s  %s\n' '------' '--------------------------------' '----------------'
printf '%s\n' "$rows" | while IFS='	' read -r status name detail; do
  [ -n "$status" ] || continue
  printf '%-6s  %-32s  %s\n' "$status" "$name" "$detail"
done
while IFS='	' read -r status name detail; do
  [ -n "$status" ] || continue
  case "$status" in
    PASS) pass=$((pass + 1)) ;;
    FAIL) fail=$((fail + 1)) ;;
    SKIP) skip=$((skip + 1)) ;;
  esac
done <<EOF
$rows
EOF
total=$((pass + fail + skip))
printf '\nsummary: %d total  %d PASS  %d FAIL  %d SKIP\n' "$total" "$pass" "$fail" "$skip"
if [ "$fail" -gt 0 ]; then
  echo "result: FAIL ($fail workflow(s) failed to plan)" >&2
  exit 1
fi
echo 'result: OK (no FAIL)'
