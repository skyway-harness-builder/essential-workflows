---
short_description: Schrijft het nieuwe workflow-bestand op basis van de opdracht in gewone taal.
long_description: Gebruikt de sky-workflow-authoring skill om een opdracht in gewone taal te vertalen naar een geldige .sky-workflowfile op het gevraagde pad. Schrijft het bestand maar lint het niet — dat doet de lint-node in de volgende stap.
---

Leest `{{request}}` en schrijft `{{dir}}/{{name}}/workflow.sky` in het volledige `.sky`-formaat:
vier delimiter-blokken, precies één trigger, een logische node-DAG en machinegerichte
promptteksten gecombineerd met leesbare `※※`-commentaarblokken.
