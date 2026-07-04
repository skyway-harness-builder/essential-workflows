---
short_description: Lint elk .sky-bestand in een map en draait daarna een Claude-fixlus op de falende bestanden totdat de hele bibliotheek schoon is.
long_description: De auto-fix-tweeling van audit-sky-library; in plaats van lintfouten alleen te rapporteren, geeft hij de falende bestanden aan een sonnet-node die ze ter plekke bewerkt totdat `skyway lint` overal slaagt. Budget-begrensd op $3,00 omdat de fix-node veel bestanden kan raken. Gebruik de audit-workflow als je alleen een rapport wilt.
---
Drie stappen: `scan` lint elk bestand en eindigt niet-nul als er één faalt, `fix` draait alleen bij die faal en repareert elk bestand volgens zijn SKY-WF-* foutcodes, en `verify` herhaalt (max 6 pogingen) totdat de hele map schoon lint, anders faalt de run.

Waarschuwing: deze workflow bewerkt `.sky`-bestanden ter plekke. Als alles al schoon lint, wordt de fix-node volledig overgeslagen en worden er geen tokens verbruikt.

| Variable | Betekenis |
|----------|-----------|
| `dir` | Map met de te linten en te repareren `.sky`-bestanden (bijv. `.sky/workflows`). |
