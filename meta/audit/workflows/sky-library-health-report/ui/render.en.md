---
short_description: Haiku grades each workflow red/amber/green and writes HEALTH.md.
long_description: "Reads the TSV rows from the checks step and applies fixed grading rules: red when lint fails, amber when lint passes but the workflow has an uncapped LLM node or never ran, green otherwise. Writes a one-screen HEALTH.md (rollup line, graded table, short legend) into the library directory, overwriting any previous report."
---
A single haiku node; the workflow's `max_budget_usd = 0.5` caps its spend. Output lands at `{{dir}}/HEALTH.md`.
