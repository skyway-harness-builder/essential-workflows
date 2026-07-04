---
short_description: Vertaalt de bron naar een nieuw .sky-workflowbestand.
long_description: Een sonnet-node met de sky-workflow-authoring-skill vertaalt de bron naar een workflow op het doelpad - shell-body's worden bash-nodes, cron-regels een schedule-trigger, Makefile-recipes bash-nodes, en env-vars gaan de secrets-array in. Schrijft het bestand maar lint het nog niet.
---

Leest de bron uit `$SKY_OUTPUT_READ` (of herleest `{{source}}`) en schrijft `{{dir}}/{{name}}.sky` met precies één trigger.
