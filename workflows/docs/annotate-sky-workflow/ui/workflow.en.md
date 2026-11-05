---
short_description: Insert inline rationale comments before each node in a .sky file, then lint until clean.
long_description: Documents a workflow from the inside - adds a ※id※ comment block before every node config explaining its purpose and what its depends_on, trigger_rule, chain_from, and when edges mean. Best for complex workflows whose edges are non-obvious; a small terse file may not want the extra line count.
---

Runs in three steps: **read** (verify the target file exists), **annotate** (sonnet inserts the `※<id>※` blocks in place, preserving everything else), **lint** (loops `skyway lint` until exit 0, max 6 passes).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory holding the target `.sky` (e.g. `.sky/workflows`) |
| `name` | Workflow filename without the `.sky` extension |
