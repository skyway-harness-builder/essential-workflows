---
short_description: Author a new .sky workflow from a plain-English brief and lint it clean.
long_description: Bridges the gap between "I want a workflow that does X" and a lint-passing .sky file on disk. Takes a plain-English request, writes the workflow using the sky-workflow-authoring skill, then loops sky lint until every error is resolved — so the output is always a valid, ready-to-run workflow.
changelog:
  - version: "1.1.0"
    date: "2026-05-31"
    note: "Added workflow-level ui card and ui/workflow.en.md generation to the author prompt."
  - version: "1.0.0"
    note: "Initial release."
---

Runs in two steps: **author** (writes the file) then **lint** (loops until clean, max 6 passes).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory the file is written to (e.g. `.sky/workflows`) |
| `name` | kebab-case workflow name; generates `<dir>/<name>/workflow.sky` |
| `request` | Plain-English description of what the workflow should do |
