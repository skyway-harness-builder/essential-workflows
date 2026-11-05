---
short_description: Hernoemt een .sky-workflow atomair - git mv, meta-naam fixen en referenties herschrijven - achter een handmatige gate.
long_description: Een workflow hernoemen raakt drie dingen tegelijk - de bestandsnaam, het meta-naamveld en elke skyway run-referentie in de library - en één missen breekt aanroepers. Deze workflow doet alle drie achter een handmatige goedkeuringsgate, lint daarna het resultaat en markeert achtergebleven referenties naar de oude naam. Puur bash, geen LLM-tokens.
---

Draait in vier stappen: **find** (lost het bestand op, weigert als de doelnaam al bestaat, toont `skyway run <old>`-hits), **confirm** (handmatige gate, timeout 1u), **apply** (`git mv` + `name =` fixen + referenties tekstueel vervangen), **verify** (`skyway lint` op het hernoemde bestand, waarschuwt bij restjes).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin de workflow staat (bijv. `.sky/workflows`) |
| `name` | Huidige kebab-case bestandsnaam (zonder `.sky`) |
| `new-name` | Nieuwe kebab-case bestandsnaam + workflow-naam (zonder `.sky`) |
