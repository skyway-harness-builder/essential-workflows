---
short_description: Resolves the target, normalizes scope and tier, and computes the gating booleans.
long_description: Deterministic bash + `gh`, no LLM. Resolves repo/owner/org, normalizes `scope` and `tier`, reads visibility, viewer permission, and default branch, and detects org versus personal account. Fail-closed — it requires repo ADMIN (for repo scope) and org OWNER (for general scope) or aborts with a clear reason.
---
Emits one JSON object with `do_repo`, `do_general`, `advanced`, and `repo_advanced` — the booleans every downstream `when` condition gates on.
