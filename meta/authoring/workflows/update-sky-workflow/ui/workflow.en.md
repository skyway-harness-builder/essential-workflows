---
short_description: Apply a change to an existing .sky workflow and lint it until clean.
long_description: Takes a plain-English change request and applies it to an existing workflow file, preserving everything the request does not touch, then loops skyway lint until every error is resolved. The companion to scaffold-sky-workflow for edits instead of new files.
---

Runs in two steps: **update** (applies `{{request}}` via the sky-workflow-authoring skill) then **lint** (loops until `skyway lint` passes, max 6 passes).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory the workflow lives in (e.g. `.sky/workflows`) |
| `name` | kebab-case filename of the existing workflow (no `.sky` extension) |
| `request` | The change to apply, in plain English (any language works) |
