---
short_description: Voegt inline rationale-commentaar toe vóór elke node in een .sky-bestand en lint daarna tot alles schoon is.
long_description: Documenteert een workflow van binnenuit - voegt vóór elke node-config een ※id※-commentaarblok toe dat het doel uitlegt en wat de depends_on-, trigger_rule-, chain_from- en when-edges betekenen. Vooral geschikt voor complexe workflows met niet-vanzelfsprekende edges; een klein bondig bestand heeft de extra regels misschien niet nodig.
---

Draait in drie stappen: **read** (controleert of het doelbestand bestaat), **annotate** (sonnet voegt de `※<id>※`-blokken in situ toe, met behoud van al het overige), **lint** (loopt `skyway lint` tot exit 0, max 6 passes).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met de doel-`.sky` (bijv. `.sky/workflows`) |
| `name` | Workflow-bestandsnaam zonder de `.sky`-extensie |
