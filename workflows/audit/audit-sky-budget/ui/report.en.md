---
short_description: Ranks workflows by rough cost risk and lists every uncapped Claude workflow with a suggested cap.
long_description: "A haiku node that reads the scan's TSV output and produces three sections: workflows missing a max_budget_usd cap (with suggested caps), an approximate cost-risk ranking, and summary counts. Runs only if the scan succeeds."
---
Operates only on `SKY_OUTPUT_SCAN` — no tools, no file reads. Suggested caps come from a coarse heuristic based on node count and model tier (opus x4, sonnet x2, haiku x1), not real token accounting.
