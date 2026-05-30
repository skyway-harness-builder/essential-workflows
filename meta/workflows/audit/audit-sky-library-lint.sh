#!/bin/bash
fail=0
pass=0
for f in "$SKY_DIR"/*.sky; do
  [ -e "$f" ] || continue
  if out=$(sky lint "$f" 2>&1); then
    pass=$((pass+1))
    echo "OK    $(basename "$f")"
  else
    fail=$((fail+1))
    echo "FAIL  $(basename "$f")"
    while IFS= read -r line; do echo "        $line"; done <<< "$out"
  fi
done
echo "[audit] $pass passed, $fail failed"
if [ "$fail" -gt 0 ]; then exit 1; fi
