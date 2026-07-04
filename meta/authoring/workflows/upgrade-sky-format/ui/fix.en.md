---
short_description: Applies minimal format fixes, only when the probe failed.
long_description: Fires only on a failed probe (trigger_rule one_failure), so a clean file costs zero tokens. Reads the file, applies the smallest fix for each reported SKY-WF-* or SKY-CFG-* code, and re-lints inside its own turn until skyway lint passes - preserving triggers, node ids, edges, and behavior.
---

Sonnet node with the `sky-workflow-authoring` skill, capped by `max_budget_usd`. Surgical edits only; never rewrites a node wholesale.
