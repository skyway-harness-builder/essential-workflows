---
short_description: Gathers the three health signals per workflow into TSV rows.
long_description: For each file it records `skyway lint` pass/fail, whether a claude node lacks a max_budget_usd cap, and best-effort last-run recency from `skyway logs`. Emits one tab-separated row per workflow for the render step to grade.
---
TSV columns: workflow, lint, llm_uncapped, last_run. The recency check is a text grep over run history, so "never" is best-effort.
