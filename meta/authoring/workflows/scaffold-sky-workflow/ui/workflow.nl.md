---
short_description: Schrijft een nieuwe .sky-workflow op basis van een opdracht in gewone taal en lint hem tot hij schoon is.
long_description: Overbrugt de kloof tussen "ik wil een workflow die X doet" en een lint-schone .sky-file op schijf. Neemt een opdracht in gewone taal, schrijft de workflow met de sky-workflow-authoring skill en herhaalt daarna skyway lint tot elke fout is opgelost — de output is dus altijd een geldige, direct uitvoerbare workflow.
---

Draait in twee stappen: **author** (schrijft het bestand) en daarna **lint** (herhaalt tot schoon, max 6 rondes).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin het bestand wordt geschreven (bijv. `.sky/workflows`) |
| `name` | kebab-case workflow-naam; genereert `<dir>/<name>/workflow.sky` |
| `request` | Beschrijving in gewone taal van wat de workflow moet doen |
