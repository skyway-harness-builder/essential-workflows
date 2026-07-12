#!/bin/bash
set -euo pipefail
DIR="$SKY_DIR"
SKY_BIN="${SKY_CLI:-sky}"
printf '%s\n' "$SKY_OUTPUT_DISCOVER" | while IFS='	' read -r name path; do
  [ -n "$name" ] || continue
  case "$name" in discovered\ *) continue ;; esac
  out="$("$SKY_BIN" run "$path" --dry-run 2>&1)" && code=0 || code=$?
  if [ "$code" -ne 0 ] && printf '%s\n' "$out" | grep -qiE 'unknown flag|unknown.*dry-run|--dry-run'; then
    out="$(cd "$DIR" && "$SKY_BIN" run "$name" --dry-run 2>&1)" && code=0 || code=$?
  fi
  firsterr="$(printf '%s\n' "$out" | grep -iE 'error|fail|missing|required|undefined|unresolved' | head -n 1 || true)"
  [ -n "$firsterr" ] || firsterr="$(printf '%s\n' "$out" | head -n 1)"
  if [ "$code" -eq 0 ]; then
    status='PASS'
  elif printf '%s\n' "$out" | grep -qiE 'required var|missing var|--vars|undefined var|unresolved var|template var'; then
    status='SKIP'
  else
    status='FAIL'
  fi
  printf '%s\t%s\t%s\n' "$status" "$name" "$firsterr"
done
