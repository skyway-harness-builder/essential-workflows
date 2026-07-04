---
short_description: Difft een .sky met de laatst gecommitte versie en voegt een changelog-regel in gewone taal toe aan CHANGELOG.md.
long_description: Zet niet-gecommitte bewerkingen aan een workflowbestand om in een gedateerde, beoordeelbare changelog-bullet. Difft de working tree tegen HEAD, laat een goedkope haiku-node de wijziging in één regel beschrijven en voegt die toe aan CHANGELOG.md naast het bestand. Alleen-lezen op de .sky zelf; een bestand zonder wijzigingen noteert "no changes" in plaats van te falen.
---

Draait in drie stappen: **diff** (`git diff HEAD` voor het bestand), **describe** (haiku schrijft één changelog-bullet), **emit** (toevoegen onder een gedateerde kop in `CHANGELOG.md`). Gaat ervan uit dat `dir` in een git working tree staat.

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met de `.sky` en zijn `CHANGELOG.md`; moet een git working tree zijn |
| `name` | Workflow-bestandsnaam zonder de `.sky`-extensie |
