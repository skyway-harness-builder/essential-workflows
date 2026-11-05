---
short_description: Archive a .sky workflow into _archive/ with its trigger neutralized; reversible via restore mode.
long_description: Moves a workflow out of the active load path into an _archive/ subdirectory, stripping every trigger line first so the file can never auto-fire again. A manual gate guards the move and restore mode brings the file back as a manual-only workflow. Pure bash, no LLM cost.
---

Runs in four steps: **find** (resolve source/dest paths), **gate** (manual approval, 1h timeout), **move** (strip trigger lines + `git mv`), **verify** (`skyway lint` at the new path). Restore moves the file back but leaves the trigger neutralized — re-add a trigger line to reactivate.

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory holding the workflow (e.g. `.sky/workflows`) |
| `name` | Workflow filename without `.sky` (e.g. `old-flow`) |
| `mode` | `archive` (default) or `restore` |
