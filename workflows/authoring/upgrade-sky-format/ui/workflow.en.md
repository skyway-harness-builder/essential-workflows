---
short_description: Lint one .sky file and, only when it reports problems, apply minimal format fixes until clean.
long_description: Brings a workflow file up to the current .sky format without spending tokens on files that are already clean. A bash probe exits with lint's own status; the Claude fix node only fires on failure (trigger_rule one_failure), applies the smallest edits that clear each diagnostic, and a final diff step always shows what changed.
---

Runs in three steps: **probe** (`skyway lint`, exit code gates the rest), **fix** (sonnet, only on lint failure, re-lints until clean), **diff** (`git diff`, always runs - empty when the file was already clean).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the file (a git repo) |
| `name` | Workflow name without `.sky`; the file is `<dir>/<name>.sky` |
