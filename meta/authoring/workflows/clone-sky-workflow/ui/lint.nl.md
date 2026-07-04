---
short_description: Draait skyway lint in een loop op de kloon en fixt elk gemeld probleem.
long_description: Elke pass leest de kloon opnieuw, draait skyway lint en herstelt alle gemelde fouten - meestal restjes van de trigger-strip zoals een verweesde secrets- of when-referentie. Loopt tot lint schoon eindigt, maximaal 6 passes.
---

Sonnet-node met de `sky-workflow-authoring`-skill. `loop.until.bash` draait `skyway lint` op de kloon; de kloon blijft een handmatige workflow - er wordt geen trigger teruggezet.
