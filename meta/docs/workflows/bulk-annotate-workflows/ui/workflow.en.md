---
short_description: Annotate every workflow.sky in the given folders with inline rationale comments, then lint each clean.
long_description: The batch version of annotate-sky-workflow in a single node - finds every workflow.sky under the given folders, inserts a ※id※ rationale block before each undocumented node config, and lints each file after editing. One run documents an entire library.
---

A single sonnet node runs `find {{folders}} -name "workflow.sky"`, annotates each file in place, runs `skyway lint` per file, and prints a final summary. Budget-capped at $30 for large libraries.

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `folders` | Space-separated folders to search for `workflow.sky` files |
