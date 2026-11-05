---
short_description: Draait skyway lint in een loop en herstelt delimiter-schade van het hertekenen.
long_description: Elke pass leest het bestand opnieuw, draait skyway lint en past de minimale fix toe voor wat lint noemt - meestal een commentaar-opener of -sluiter die niet meer alleen op zijn regel staat, of een verdwaald delimiter-teken in de diagramtekst. Houdt het geregenereerde diagram intact; loopt tot schoon, max 6 passes.
---

Haiku-node; `loop.until.bash` bewaakt de loop met `skyway lint "{{dir}}/{{name}}.sky"`.
