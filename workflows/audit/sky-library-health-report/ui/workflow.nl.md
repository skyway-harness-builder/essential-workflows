---
short_description: Voegt lintstatus, run-recentheid en budget-cap-signalen samen tot een gegradeerde HEALTH.md van één scherm voor een hele .sky-bibliotheek.
long_description: Draai dit voor een snel rood/amber/groen overzicht van een workflowbibliotheek; rood betekent falende lint, amber een LLM-node zonder budgetcap of een workflow die nooit draaide, groen schoon en gebruikt. Het is een dashboard dat bestaande signalen samenvat, geen diepe audit — gebruik audit-sky-library en verwanten voor detail per probleem.
---
Vier stappen: `inventory` lijst de .sky-bestanden op, `checks` produceert een TSV-rij per workflow (lint pass/fail, detectie van LLM zonder cap, laatste-run-recentheid), `render` laat haiku elke rij graderen en `HEALTH.md` in dezelfde map schrijven, en `verify` controleert dat het bestand bestaat en niet leeg is.

Het `last_run`-signaal grept `skyway logs` en kan een vals "never" melden als logs zijn opgeschoond — zie amber als een duwtje, niet als een oordeel.

| Variable | Betekenis |
|----------|-----------|
| `dir` | Map met de te graderen `.sky`-bestanden; `HEALTH.md` wordt hier ook geschreven. |
