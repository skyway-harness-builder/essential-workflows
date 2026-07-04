---
short_description: Verwijdert het scratchbestand forge-candidate zodat de repo-tier schoon achterblijft.
long_description: Deterministische bash, geen LLM, met `trigger_rule = "all_done"` zodat het draait ongeacht of finalize slaagde, werd overgeslagen of faalde. Verwijdert het tijdelijke `.sky/workflows/forge-candidate.sky` dat alleen bestond voor de dry-run-resolver.
---
Best-effort: een ontbrekend bestand is prima. Laat de `.sky/workflows/`-tier exact achter zoals aangetroffen.
