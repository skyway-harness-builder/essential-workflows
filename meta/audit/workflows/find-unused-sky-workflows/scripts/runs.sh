#!/bin/bash
set -euo pipefail
LOG="$(mktemp /tmp/sky-runlog.XXXXXX)"
# 'skyway logs' format is not contractually stable; capture defensively and never let a nonzero exit kill discovery.
if ! skyway logs > "$LOG" 2>/dev/null; then
  echo 'WARN: skyway logs returned nonzero or is unavailable; treating history as empty' >&2
  : > "$LOG"
fi
LINES="$(wc -l < "$LOG" | tr -d ' ')"
if [ "$LINES" = "0" ]; then
  echo 'WARN: no run history parsed; every workflow will be reported as NEVER (advisory only)' >&2
fi
cat "$LOG"
rm "$LOG"
echo "---" >&2
echo "captured $LINES line(s) of run history" >&2