---
short_description: Regenerate a browsable INDEX.md for a .sky directory, with a coverage check that every file is listed.
long_description: Keeps a library's map fresh - one table row per workflow with its name, trigger, vars, node-DAG sketch, and budget. A cheap haiku node does the formatting, bash does the rest, and a verify step fails the run when any workflow is missing from the index. Re-run any time to refresh.
---

Runs in three steps: **scan** (count `*.sky` in the directory, stop cleanly if empty), **index** (haiku reads each file and writes `<dir>/INDEX.md`), **verify** (assert INDEX.md is non-empty and lists every workflow).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory of `.sky` files to index (e.g. `.sky/workflows`) |
