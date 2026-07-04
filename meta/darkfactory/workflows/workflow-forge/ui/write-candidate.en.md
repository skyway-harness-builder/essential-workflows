---
short_description: Writes the authored candidate verbatim to the two paths the gates need.
long_description: Deterministic bash, no LLM. Persists the author's whole stdout to `.sky/workflows/forge-candidate.sky` (so `skyway run forge-candidate --dry-run` resolves it by name) and to a stable `$RUNTMP` copy for lint and later inspection.
---
No templating and no shell splicing of model output into commands — the untrusted output only ever lands in a file. Prints a greppable path block the downstream gates read.
