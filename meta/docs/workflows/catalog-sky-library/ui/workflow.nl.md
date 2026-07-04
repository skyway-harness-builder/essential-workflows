---
short_description: Regenereert een doorbladerbare INDEX.md voor een .sky-map, met een dekkingscontrole dat elk bestand vermeld staat.
long_description: Houdt de kaart van een library actueel - één tabelrij per workflow met naam, trigger, vars, node-DAG-schets en budget. Een goedkope haiku-node doet de opmaak, bash de rest, en een verify-stap laat de run falen wanneer een workflow in de index ontbreekt. Draai op elk moment opnieuw om te verversen.
---

Draait in drie stappen: **scan** (telt `*.sky` in de map, stopt netjes bij leeg), **index** (haiku leest elk bestand en schrijft `<dir>/INDEX.md`), **verify** (controleert dat INDEX.md niet leeg is en elke workflow vermeldt).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map met `.sky`-bestanden om te indexeren (bijv. `.sky/workflows`) |
