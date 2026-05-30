#!/bin/bash
set -u
F=".sky/workflows/forge-candidate.sky"
OUT=$(sky lint "$F" --format json 2>/dev/null)
echo "lint-codes:" >&2
printf '%s\n' "$OUT" | grep -oE 'SKY-(WF|CFG)-[0-9]+' >&2 || echo '(none)' >&2
if [ "$OUT" = '[]' ]; then echo '{"clean":"true"}'; else echo '{"clean":"false"}'; fi
