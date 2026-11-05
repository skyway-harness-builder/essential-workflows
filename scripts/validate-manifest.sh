#!/usr/bin/env bash
# validate-manifest.sh — validate manifest.yaml against the on-disk tree.
#
# Checks:
#   - apiVersion is skylence.be/v1 (canonical) or skylence.io/v1 (legacy)
#   - path values in entries exist on disk
#   - kind values are workflow / skill / command
#   - scripts paths (if declared) exist on disk
#   - no drift: workflow.sky and SKILL.md counts match manifest
#   - no tracked symlinks (the library extractor refuses them; reads the git index)
#
# Zero external dependencies (bash, grep, find, awk; git only for the symlink check).
# Usage: validate-manifest.sh [--symlinks-only]
#   --symlinks-only  run only the tracked-symlink guard (fast; for every commit)
# Exit 0 on success, 1 on any failure, 2 on a bad argument.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST="$REPO_ROOT/manifest.yaml"
ERRORS=0

err() { echo "  ERROR $*" >&2; ERRORS=$((ERRORS + 1)); }

# ── no tracked symlinks (guard) ───────────────────────────────────────────────
# The library extractor (skyway internal/library/extract.go:74) fails the WHOLE
# archive on a symlink or hard link, so none may be tracked. This reads the git
# index (mode 120000), not the disk: an untracked or ignored local helper symlink
# never reaches the tarball and must not fail a local run. Skipped only when
# there is no .git at all (e.g. an unpacked release archive). Fails closed
# otherwise: a .git that git cannot read as a work tree (e.g. "detected dubious
# ownership") must not turn into a silent pass.
check_symlinks() {
  if [ -e "$REPO_ROOT/.git" ]; then
    if ! git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      err "cannot verify tracked symlinks: not a readable git work tree"
    else
      if ! tracked_symlinks=$(git -C "$REPO_ROOT" ls-files -s | awk -F'\t' 'substr($1,1,6)=="120000"{print $2}'); then
        err "cannot verify tracked symlinks: git ls-files failed"
      elif [ -n "$tracked_symlinks" ]; then
        while IFS= read -r sl; do
          err "tracked symlink (library extractor refuses symlinks, internal/library/extract.go:74): $sl"
        done <<< "$tracked_symlinks"
      fi
    fi
  fi
}

# ── arguments ─────────────────────────────────────────────────────────────────
# --symlinks-only: run just the tracked-symlink guard (fast; for every commit).
if [ "$#" -gt 0 ]; then
  if [ "$#" -ne 1 ] || [ "$1" != "--symlinks-only" ]; then
    echo "usage: validate-manifest.sh [--symlinks-only]" >&2
    exit 2
  fi
  check_symlinks
  if [ "$ERRORS" -gt 0 ]; then
    echo ""
    echo "$ERRORS error(s): validation FAILED" >&2
    exit 1
  fi
  echo "OK  no tracked symlinks"
  exit 0
fi

# ── apiVersion ────────────────────────────────────────────────────────────────
if ! grep -q -E "^apiVersion: skylence\.(be|io)/v1$" "$MANIFEST"; then
  err "apiVersion must be 'skylence.be/v1' (or the legacy 'skylence.io/v1')"
fi

# ── path values exist on disk ─────────────────────────────────────────────────
# Paths appear as 4-space-indented "    path: <value>" lines.
while IFS= read -r line; do
  path="${line#*path: }"
  path="${path//\"/}"
  path="$(echo "$path" | tr -d '[:space:]')"
  [ -z "$path" ] && continue
  if [ ! -f "$REPO_ROOT/$path" ]; then
    err "path not found on disk: $path"
  fi
done < <(grep -E "^    path:" "$MANIFEST")

# ── kind values are valid ──────────────────────────────────────────────────────
# Kind appears on the same line as the list marker: "  - kind: <value>"
while IFS= read -r line; do
  kind="${line#*kind: }"
  kind="$(echo "$kind" | tr -d '[:space:]"')"
  [ -z "$kind" ] && continue
  case "$kind" in
    workflow|skill|command) ;;
    *) err "invalid kind: '$kind' (must be workflow, skill, or command)" ;;
  esac
done < <(grep -E "^\s+-\s+kind:" "$MANIFEST")

# ── scripts paths exist on disk ────────────────────────────────────────────────
# scripts: is a key at 4-space indent; its items are at 6-space indent.
in_scripts=0
while IFS= read -r line; do
  if echo "$line" | grep -qE "^    scripts:"; then
    in_scripts=1
    continue
  fi
  if [ "$in_scripts" -eq 1 ]; then
    if echo "$line" | grep -qE "^      -"; then
      script_path="${line#*- }"
      script_path="${script_path//\"/}"
      script_path="$(echo "$script_path" | tr -d '[:space:]')"
      [ -z "$script_path" ] && continue
      if [ ! -f "$REPO_ROOT/$script_path" ]; then
        err "scripts path not found: $script_path"
      fi
    else
      in_scripts=0
    fi
  fi
done < "$MANIFEST"

# ── drift check ───────────────────────────────────────────────────────────────
manifest_workflows=$(grep -c "kind: workflow" "$MANIFEST" || true)
manifest_skills=$(grep -c "kind: skill" "$MANIFEST" || true)

disk_workflows=$(find "$REPO_ROOT" -name "workflow.sky" | wc -l | tr -d ' ')
disk_skills=$(find "$REPO_ROOT" -name "SKILL.md" | wc -l | tr -d ' ')

if [ "$manifest_workflows" -ne "$disk_workflows" ]; then
  err "workflow drift: manifest=$manifest_workflows disk=$disk_workflows (workflow.sky files)"
fi
if [ "$manifest_skills" -ne "$disk_skills" ]; then
  err "skill drift: manifest=$manifest_skills disk=$disk_skills (SKILL.md files)"
fi

# ── no tracked symlinks ───────────────────────────────────────────────────────
# Guard defined above (check_symlinks); also the whole of --symlinks-only mode.
check_symlinks

# ── summary ───────────────────────────────────────────────────────────────────
total=$((manifest_workflows + manifest_skills))
echo "manifest.yaml: $total entries ($manifest_workflows workflows, $manifest_skills skills)"

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "$ERRORS error(s) — validation FAILED" >&2
  exit 1
fi

echo "  OK  manifest valid"
