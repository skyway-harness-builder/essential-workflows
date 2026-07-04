---
short_description: Composes lint status, run-recency, and budget-cap signals into a one-screen graded HEALTH.md for a whole .sky library.
long_description: "Run this for a quick red/amber/green overview of a workflow library: red means lint is failing, amber means an uncapped LLM node or a workflow that never ran, green means clean and exercised. It is a dashboard that rolls up existing signals, not a deep audit — use audit-sky-library and friends for per-issue detail."
---
Four steps: `inventory` lists the .sky files, `checks` emits a TSV row per workflow (lint pass/fail, uncapped-LLM detection, last-run recency), `render` has haiku grade each row and write `HEALTH.md` into the same directory, and `verify` asserts the file exists and is non-empty.

The `last_run` signal greps `skyway logs` and can report a false "never" if logs were pruned — treat amber as a nudge, not a verdict.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the `.sky` files to grade; `HEALTH.md` is written here too. |
