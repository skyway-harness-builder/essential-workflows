---
short_description: "Gezaghebbende lint-gate na de fix-loop — geeft {\"clean\":\"true|false\"} uit."
long_description: Deterministische bash, geen LLM. De eigen lint van de loop is slechts zijn stopconditie; dit knooppunt is wat de gate vertrouwt. Draait `skyway lint --format json` en geeft één schone JSON-regel uit zodat de volgende `when` altijd parset; rauwe diagnostiekcodes gaan naar stderr voor het runlog.
---
Fail-closed: alleen een expliciet lege `[]` van de linter levert `clean=true` op.
