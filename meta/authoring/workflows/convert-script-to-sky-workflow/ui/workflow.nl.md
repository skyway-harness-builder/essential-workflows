---
short_description: Zet een shellscript, Makefile-target of cron-regel om naar een gelijkwaardige .sky-workflow.
long_description: Leest een bestaande automatiseringsbron en schrijft een bijpassende .sky-workflow, lint-loopt die schoon en doet een best-effort dry-run. De vertaling is best-effort - template-vars, isolatie, secrets en exit-code-semantiek verschillen van kale shell - dus beoordeel het gegenereerde bestand voordat je het in productie vertrouwt.
---

Draait in vier stappen: **read** (cat de bron, faalt als die ontbreekt), **author** (sonnet vertaalt de bron naar `{{dir}}/{{name}}.sky`), **lint** (loop tot `skyway lint` met 0 eindigt, max 6), **dryrun** (`skyway run <name> --dry-run`, laat de run nooit falen).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `dir` | Map waarin de nieuwe `.sky` komt (bijv. `.sky/workflows`) |
| `name` | Workflow-naam en bestandsnaamstam, kebab-case |
| `source` | Pad naar het script / de Makefile / cron-regel om om te zetten |
