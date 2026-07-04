---
short_description: Read one .sky file and emit a plain-English walkthrough of its triggers, DAG, inputs, and edges.
long_description: For anyone who wants to understand a workflow without parsing the Unicode delimiter format - a cheap haiku node reads the file and writes a prose walkthrough covering the trigger, the node DAG in order, every --var input, and what each edge means in plain language. The file is never modified.
---

Runs in two steps: **resolve** (verify the file exists, best-effort `skyway describe` for context) then **explain** (haiku writes the walkthrough). Read-only throughout.

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory containing the `.sky` file (no trailing slash) |
| `name` | Workflow name without the `.sky` extension |
