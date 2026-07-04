---
short_description: Dupliceert een .sky-workflow als nieuw handmatig sjabloon, met geneutraliseerde gekopieerde trigger.
long_description: Kloont een bestaande workflow onder een nieuwe naam zonder het dubbel-afvuren-risico - een naïeve kopie behoudt de trigger van de bron en start twee runs per event. Deze workflow stript elke trigger-regel uit de kloon (waardoor die standaard handmatig wordt), hernoemt de meta-naam en lint-fixt restjes zodat de kloon schoon oplevert.
---

Draait in vier stappen: **copy** (overschrijft nooit een bestaand bestand), **rewrite** (`name` hernoemen, `trigger.*`-regels strippen), **lint** (sonnet-loop tot `skyway lint` slaagt, max 6), **describe** (best-effort `skyway describe`-samenvatting).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin beide bestanden staan (bijv. `.sky/workflows`) |
| `name` | Bestaande kebab-case bestandsnaam om te klonen (zonder `.sky`) |
| `new-name` | Nieuwe bestandsnaam + workflow-naam voor de kloon (zonder `.sky`) |
