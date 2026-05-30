#!/bin/bash
set -u
OUT=$(sky run forge-candidate --dry-run --format json 2>/dev/null)
RC=$?
echo "dry-run-rc=$RC" >&2
printf '%s\n' "$OUT" | head -c 400 >&2
if [ "$RC" -eq 0 ] && printf '%s' "$OUT" | grep -q '"id"'; then echo '{"dry_ok":"true"}'; else echo '{"dry_ok":"false"}'; fi
