---
short_description: Find a .sky workflow by name and delete it behind a manual approval gate.
long_description: Safe deletion of a workflow file - the run halts if the file is not found, then a human must approve before anything is removed. Pure bash plus a wait node, so it costs no LLM tokens.
---

Runs in three steps: **find** (resolve `<dir>/<name>.sky`, list the directory and stop if missing), **confirm** (manual approval gate, 1h timeout - reject keeps the file), **remove** (`rm` the file after approval).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory the workflow lives in (e.g. `.sky/workflows`) |
| `name` | kebab-case filename to delete (no `.sky` extension) |
