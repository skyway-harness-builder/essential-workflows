---
short_description: Authors a .sky workflow from a plain-English intent, gated by sky's own lint and dry-run, then stages a PR.
long_description: "Meta-workflow that dogfoods sky on sky: it generates a candidate workflow from your intent, loops fixes until `skyway lint` is clean, validates the DAG with `skyway run --dry-run`, has an opus judge check intent alignment, and only on a fail-closed gate opens a staged PR. v1 never executes the generated workflow for real — it proves structural soundness and intent alignment, not runtime behavior."
---
The pipeline: **parse** (haiku) sketches an authoring plan, **author** (opus) emits the full candidate under the fixed sentinel name `forge-candidate`, **write-candidate** persists it to disk, **fix-loop** (opus, max 3 passes) rewrites it until lint is clean, **lint** and **dry-run** are the authoritative bash gates, **judge** (opus) checks the candidate against the intent, **gate** (bash, fail-closed) requires all three to pass, **finalize** renames the candidate and opens a staged PR under worktree isolation, and **cleanup** removes the scratch file. Bounded by `max_budget_usd = 8.00` and `loop.max = 3`.

| Variable | Meaning |
|----------|---------|
| `intent` | Plain-English description of the workflow to author |
