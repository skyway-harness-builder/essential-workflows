---
short_description: Zet een nieuwe community-workflowcollectie op vanuit het GitHub-skelettemplate en pusht de eerste commit.
long_description: Maakt een GitHub-repo aan vanuit het skylence-be/community-workflow-collection-skeleton-template, configureert die niet-interactief met de opgegeven vendor-gegevens (token-vervangingen, maphernoeming, README-opschoning) en pusht de eerste commit. Eindigt met de repo-URL en het skyway library add-commando.
---

Draait in vier stappen: **preflight** (controleert `gh`, auth en vars), **create** (`gh repo create --template`), **setup** (clonen, tokens vervangen, `workflows/__vendor__/` hernoemen, commit + push), **report** (URL en vervolgstappen printen).

Invoer via `--var`:

| Variabele | Betekenis |
|-----------|-----------|
| `vendor` | Verplichte kebab-case slug voor paden en manifest-tags |
| `repo` | Naam van de aan te maken GitHub-repo (standaard `<vendor>-workflows`) |
| `org` | GitHub-org of -gebruiker die de repo bezit (standaard: ingelogde gebruiker) |
| `vendor-name` | Weergavenaam van de vendor (standaard gelijk aan vendor) |
| `description` | Eénregelige beschrijving voor de GitHub-repo en README |
