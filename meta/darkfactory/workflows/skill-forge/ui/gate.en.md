---
short_description: Fail-closed gate that turns the judge's sentinel into clean JSON.
long_description: "Deterministic bash, no LLM. Greps the judge output for the `SKY_FORGE delivers=...` sentinel and emits one clean JSON line `{\"delivers\":\"true|false\"}` so the downstream `when` condition always parses. A missing or garbled sentinel yields false."
---
Fail-closed by design: a false "delivers=true" would ship a broken skill via PR, while a false "delivers=false" just runs a bounded improve loop — the costlier mistake is gated against.
