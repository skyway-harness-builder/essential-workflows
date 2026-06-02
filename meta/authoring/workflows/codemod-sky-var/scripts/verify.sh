#!/bin/bash
fail=0
pass=0
for f in "$SKY_DIR"/*.sky; do
  [ -e "$f" ] || continue
  if out=$(skyway lint "$f" 2>&1); then
    pass=$((pass+1))
    echo "OK    $(basename "$f")"
  else
    fail=$((fail+1))
    echo "FAIL  $(basename "$f")"
    printf '%s\n' "$out" | sed 's/^/        /'
  fi
done
rm /tmp/codemod-sky-var.touched 2>/dev/null || true
echo "[codemod] lint: $pass passed, $fail failed"
if [ "$fail" -gt 0 ]; then echo "[codemod] a touched file no longer lints — review git diff and revert if needed"; exit 1; fi
echo "[codemod] all files lint clean after codemod"
