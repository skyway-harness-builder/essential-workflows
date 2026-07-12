#!/bin/bash
set -euo pipefail
# Cross-reference each listed workflow basename against captured run history.
# SEEN-IN-LOGS = name appears (case-insensitively) in the skyway logs text;
# NEVER = it does not, so the file is an advisory deletion candidate.
# Reads $SKY_OUTPUT_LIST (basenames, one per line) and $SKY_OUTPUT_RUNS (log text).
# Reports only: prints ready-to-paste delete commands, deletes nothing, exits 0.
DIR="${SKY_DIR:-}"
LIST="${SKY_OUTPUT_LIST:-}"
RUNS="${SKY_OUTPUT_RUNS:-}"

total=0
never=""

echo "unused-sky-workflow scan for: ${DIR:-<unknown dir>}"
echo
while IFS= read -r name; do
  [ -n "$name" ] || continue
  total=$((total + 1))
  # here-string match (no pipe) so grep -q cannot SIGPIPE a producer and
  # invert the result on a large run history.
  if grep -qiF -- "$name" <<<"$RUNS"; then
    printf '  SEEN-IN-LOGS  %s\n' "$name"
  else
    printf '  NEVER         %s\n' "$name"
    never="${never}${name}
"
  fi
done <<EOF
$LIST
EOF

echo
candidates="$(printf '%s' "$never" | grep -c . || true)"
if [ "$candidates" -eq 0 ]; then
  echo "No never-run workflows across $total file(s)."
else
  echo "$candidates of $total file(s) never appeared in run history. Advisory deletion candidates:"
  echo
  printf '%s' "$never" | while IFS= read -r name; do
    [ -n "$name" ] || continue
    printf '  skyway run delete-sky-workflow --var dir="%s" --var name=%s\n' "$DIR" "$name"
  done
  echo
  echo "NEVER is advisory: log retention or a name/filename mismatch can cause a false positive. Verify before deleting."
fi
exit 0
