---
short_description: "Fail-closed acceptance gate: lint clean AND dry-run ok AND judge says true."
long_description: "Deterministic bash, no LLM. Emits `{\"delivers\":\"true|false\"}` — true only when all three upstream signals hold: lint clean, dry_ok, and a valid judge sentinel saying true. A missing or garbled sentinel, a skipped dry-run, or a dirty lint all yield false."
---
Fail-closed because a spurious "delivers" would ship broken generated code as a PR; a false negative only costs another loop.
