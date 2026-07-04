---
short_description: Summarizes the run and prints the two manual UI steps the API cannot do.
long_description: Deterministic bash, no LLM. The single leaf node — it depends on labels, link, and fields with `trigger_rule = all_done`, so it always produces a summary even when an upstream step failed.
---
Echoes each upstream node's output, then prints the two GitHub Projects UI steps that have no public API: enabling the Auto-add workflow filtered to this repo, and wiring the label-to-Status column automation.
