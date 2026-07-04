---
short_description: "Authoritative lint gate after the fix loop — emits {\"clean\":\"true|false\"}."
long_description: Deterministic bash, no LLM. The loop's own lint is just its stop condition; this node is what the gate trusts. Runs `skyway lint --format json` and emits one clean JSON line so the downstream `when` always parses; raw diagnostic codes go to stderr for the run log.
---
Fail-closed: only an explicit empty `[]` from the linter yields `clean=true`.
