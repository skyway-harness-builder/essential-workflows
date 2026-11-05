---
short_description: Convert a shell script, Makefile target, or cron line into an equivalent .sky workflow.
long_description: Reads an existing automation source and authors a matching .sky workflow, then lint-loops it clean and does a best-effort dry-run. The translation is best-effort - template vars, isolation, secrets, and exit-code semantics all differ from plain shell - so review the generated file before trusting it in production.
---

Runs in four steps: **read** (cat the source, fail if missing), **author** (sonnet maps the source to `{{dir}}/{{name}}.sky`), **lint** (loop until `skyway lint` exits 0, max 6), **dryrun** (`skyway run <name> --dry-run`, never fails the run).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory to write the new `.sky` into (e.g. `.sky/workflows`) |
| `name` | Workflow name and filename stem, kebab-case |
| `source` | Path to the script / Makefile / cron line to convert |
