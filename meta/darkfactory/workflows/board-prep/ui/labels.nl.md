---
short_description: Maakt de 9 repo-gebonden lifecycle-labels aan waar de laddertreden op draaien.
long_description: Deterministische bash + `gh`, geen LLM. Maakt de lifecycle-labels uit `data/labels.yaml` aan op de doelrepo — het ene dat geen enkel projecttemplate kan leveren, omdat labels bij de repository horen en niet bij het project.
---
Gebruikt `gh label create --force`, een idempotente upsert: elk label wordt aangemaakt, of kleur/beschrijving wordt overschreven als het al bestaat. Herhaalde runs zijn dus veilig.
