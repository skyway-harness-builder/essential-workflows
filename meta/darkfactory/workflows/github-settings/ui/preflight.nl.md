---
short_description: Bepaalt het doel, normaliseert scope en tier, en berekent de gating-booleans.
long_description: Deterministische bash + `gh`, geen LLM. Bepaalt repo/owner/org, normaliseert `scope` en `tier`, leest zichtbaarheid, viewer-permissie en de default branch, en detecteert org versus persoonlijk account. Fail-closed — vereist repo-ADMIN (voor repo-scope) en org-OWNER (voor general-scope) of breekt af met een duidelijke reden.
---
Geeft één JSON-object uit met `do_repo`, `do_general`, `advanced` en `repo_advanced` — de booleans waar elke volgende `when`-conditie op gate.
