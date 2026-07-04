---
short_description: Detecteert workflows die aan dezelfde niet-handmatige trigger hangen en dus samen zouden afgaan op één event.
long_description: Twee workflows die luisteren op hetzelfde sky_event, hetzelfde cron-schema of dezelfde github event+action+label vuren stilletjes samen af, met dubbele runs en dubbele kosten als gevolg. Deze audit groepeert triggersignaturen over een map en rapporteert elke botsing. Puur bash, stopt met een foutcode bij een conflict.
---
Eén `check`-node haalt per bestand één triggersignatuur op (`sky_event:<name>`, `cron:<sched>` of `github:<ev>:<action>:<label>`), groepeert ze en print elke signatuur die door meer dan één workflow gedeeld wordt. Handmatige triggers worden genegeerd — die kunnen niet botsen.

| Variable | Meaning |
|----------|---------|
| `dir` | Map met `.sky`-bestanden om te controleren (bijv. `.sky/workflows`) |
