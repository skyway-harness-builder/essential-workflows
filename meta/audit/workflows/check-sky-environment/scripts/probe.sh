#!/bin/bash
set -u
DIR="${SKY_DIR:-}"
FAILS=0
WARNS=0
say() { printf '%s %s: %s\n' "$1" "$2" "$3"; }
ok() { say OK "$1" "$2"; }
warn() { say WARN "$1" "$2"; WARNS=$((WARNS + 1)); }
fail() { say FAIL "$1" "$2"; FAILS=$((FAILS + 1)); }

ok "skyway" "$(skyway --version 2>/dev/null | head -1 || echo present)"

if command -v claude >/dev/null 2>&1; then
  ok "claude CLI" "$(claude --version 2>/dev/null | head -1 || echo present)"
else
  fail "claude CLI" "not on PATH — prompt nodes cannot run"
fi

if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    ok "gh auth" "authenticated"
  else
    fail "gh auth" "gh present but not authenticated — run: gh auth login"
  fi
else
  warn "gh" "not on PATH — GitHub-facing workflows will not work"
fi

if git rev-parse --git-dir >/dev/null 2>&1; then
  if git remote get-url origin >/dev/null 2>&1; then
    if git ls-remote --exit-code origin HEAD >/dev/null 2>&1; then
      ok "git remote" "origin reachable"
    else
      fail "git remote" "origin configured but unreachable (auth or network)"
    fi
  else
    warn "git remote" "no origin remote configured"
  fi
else
  warn "git" "not a git repository"
fi

BASE="${SKY_SERVER_URL:-http://localhost:3090}"
if curl -fsS -m 5 "$BASE/health" >/dev/null 2>&1; then
  ok "daemon" "reachable at $BASE"
else
  warn "daemon" "not reachable at $BASE — schedules and webhooks will not fire (start with: skyway serve)"
fi

if [ -z "$DIR" ]; then
  warn "secrets" "no dir given — skipped secrets check"
elif [ ! -d "$DIR" ]; then
  warn "secrets" "dir not found: $DIR — skipped secrets check"
else
  MISSING=0
  DECLARED=0
  while IFS= read -r name; do
    [ -n "$name" ] || continue
    DECLARED=$((DECLARED + 1))
    if [ -z "${!name:-}" ]; then
      fail "secret $name" "declared in secrets[] under $DIR but not set in the environment"
      MISSING=$((MISSING + 1))
    fi
  done < <(find "$DIR" -name '*.sky' -exec grep -h '^secrets' {} + 2>/dev/null |
    grep -oE '"[A-Za-z_][A-Za-z0-9_]*"' | tr -d '"' | sort -u)
  if [ "$DECLARED" -eq 0 ]; then
    ok "secrets" "no secrets[] declared under $DIR"
  elif [ "$MISSING" -eq 0 ]; then
    ok "secrets" "$DECLARED declared secret(s) under $DIR all set"
  fi
fi

echo "---"
echo "result: fails=$FAILS warns=$WARNS"
if [ "$FAILS" -gt 0 ]; then exit 1; fi
exit 0
