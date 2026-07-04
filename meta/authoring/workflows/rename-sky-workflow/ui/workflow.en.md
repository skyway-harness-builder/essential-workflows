---
short_description: Atomically rename a .sky workflow - git mv, fix its meta name, and rewrite references - behind a manual gate.
long_description: Renaming a workflow touches three things at once - the filename, the meta name field, and every skyway run reference across the library - and missing one breaks callers. This workflow does all three behind a manual approval gate, then lints the result and flags any leftover old-name references. Pure bash, no LLM tokens.
---

Runs in four steps: **find** (resolve the file, refuse if the target name exists, preview `skyway run <old>` hits), **confirm** (manual gate, 1h timeout), **apply** (`git mv` + fix `name =` + text-replace references), **verify** (`skyway lint` the renamed file, warn on leftovers).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory the workflow lives in (e.g. `.sky/workflows`) |
| `name` | Current kebab-case filename (no `.sky` extension) |
| `new-name` | New kebab-case filename + workflow name (no `.sky` extension) |
