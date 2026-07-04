---
short_description: Past een wijziging toe op een bestaande .sky-workflow en lint tot alles schoon is.
long_description: Neemt een wijzigingsverzoek in gewone taal en past het toe op een bestaand workflowbestand, met behoud van alles wat het verzoek niet raakt, en loopt daarna skyway lint tot elke fout is opgelost. De tegenhanger van scaffold-sky-workflow voor bewerkingen in plaats van nieuwe bestanden.
---

Draait in twee stappen: **update** (past `{{request}}` toe via de sky-workflow-authoring-skill) en daarna **lint** (loopt tot `skyway lint` slaagt, max 6 passes).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin de workflow staat (bijv. `.sky/workflows`) |
| `name` | kebab-case bestandsnaam van de bestaande workflow (zonder `.sky`) |
| `request` | De toe te passen wijziging, in gewone taal (elke taal werkt) |
