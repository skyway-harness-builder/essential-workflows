---
short_description: Herhaalt totdat elk bestand in de map schoon lint.
long_description: "Laatste poort: lint elk .sky-bestand in de map opnieuw, met maximaal 6 pogingen. De lusvoorwaarde slaagt alleen wanneer `skyway lint` op alle bestanden met 0 eindigt; als de fix-node niet alles heeft opgelost, laat deze stap de run falen en benoemt de nog falende bestanden."
---
Draait `skyway lint` over `$SKY_DIR/*.sky` met `loop.max = 6` pogingen.
