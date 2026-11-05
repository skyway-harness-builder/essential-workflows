---
short_description: Reads every .sky and writes the INDEX.md table.
long_description: A haiku node reads each workflow file, extracts its name, trigger type, expected vars, a one-line DAG sketch, and budget, and writes them as a sorted Markdown table to INDEX.md. Reads only - it never modifies a .sky file.
---

Writes `{{dir}}/INDEX.md` with a `| Workflow | Trigger | Vars | Flow | Budget |` table, one row per workflow.
