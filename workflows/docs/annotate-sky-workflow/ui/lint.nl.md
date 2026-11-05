---
short_description: Draait skyway lint in een loop op het geannoteerde bestand en herstelt wat het meldt.
long_description: Elke pass draait skyway lint en herstelt alleen de problemen die lint noemt - waarschijnlijk een misvormd commentaarblok uit de annotate-stap, zoals een opener die niet alleen op zijn regel staat. Verwijdert nooit een node, trigger, edge of prompt-body om de linter tevreden te stellen. Loopt tot schoon, max 6 passes.
---

Sonnet-node; `loop.until.bash` bewaakt de loop met `skyway lint "{{dir}}/{{name}}.sky"`.
