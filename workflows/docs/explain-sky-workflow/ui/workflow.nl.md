---
short_description: Leest één .sky-bestand en geeft een walkthrough in gewone taal van triggers, DAG, invoer en edges.
long_description: Voor iedereen die een workflow wil begrijpen zonder het Unicode-delimiterformaat te ontleden - een goedkope haiku-node leest het bestand en schrijft een prozawalkthrough over de trigger, de node-DAG in volgorde, elke --var-invoer en wat elke edge in gewone taal betekent. Het bestand wordt nooit gewijzigd.
---

Draait in twee stappen: **resolve** (controleert dat het bestand bestaat, best-effort `skyway describe` voor context) en daarna **explain** (haiku schrijft de walkthrough). Volledig alleen-lezen.

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met het `.sky`-bestand (zonder slash aan het einde) |
| `name` | Workflow-naam zonder de `.sky`-extensie |
