---
short_description: Zoekt een .sky-workflow op naam en verwijdert die achter een handmatige goedkeuringsgate.
long_description: Veilig verwijderen van een workflowbestand - de run stopt als het bestand niet gevonden wordt, en daarna moet een mens goedkeuren voordat er iets wordt verwijderd. Puur bash plus een wait-node, dus geen LLM-tokens.
---

Draait in drie stappen: **find** (lost `<dir>/<name>.sky` op, toont de map en stopt bij ontbreken), **confirm** (handmatige goedkeuringsgate, timeout 1u - afwijzen behoudt het bestand), **remove** (`rm` van het bestand na goedkeuring).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin de workflow staat (bijv. `.sky/workflows`) |
| `name` | kebab-case bestandsnaam om te verwijderen (zonder `.sky`) |
