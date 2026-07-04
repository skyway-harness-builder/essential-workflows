---
short_description: Scan a library directory for unannotated workflow.sky files and annotate each one in sequence.
long_description: Batch driver for annotate-sky-workflow. Walks a library directory, finds every workflow.sky that carries no ※id※ annotation blocks, and runs the annotator on each one sequentially. Useful after importing or bulk-editing a set of workflows.
---

Runs in two steps: **scan** (finds unannotated workflows) then **annotate-all** (invokes `annotate-sky-workflow` once per hit, one run at a time). Exits cleanly when everything is already annotated.

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Root of the library to scan (e.g. `meta/authoring/workflows`) |
