---
short_description: Lints every .sky file in a directory in one pass and reports pass/fail grouped by file.
long_description: The steward's pre-flight before sharing a workflow library or wiring it into CI. Pure bash, no LLM tokens. Exits non-zero if any workflow fails lint, so it can gate a pipeline.
---
A `scan` node lists the `.sky` files in the target directory (an empty directory is a clean exit, not a failure), then `lint` runs `skyway lint` on each file, tallies OK/FAIL with error codes, and exits non-zero on any failure.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory of `.sky` files to lint (e.g. `.sky/workflows`) |
