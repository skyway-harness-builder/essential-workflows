---
short_description: Lint elk .sky-bestand en verzamelt de fouten.
long_description: Globt `$SKY_DIR/*.sky` en draait `skyway lint` op elk bestand, met verzameling van falende paden plus hun SKY-WF-* foutcodes. Eindigt met exit 1 als er iets faalde — die niet-nul exit is de poort die de fix-node activeert.
---
Eindigt met 0 wanneer de hele bibliotheek al schoon is (de fix-node wordt dan overgeslagen) en met 2 wanneer de map ontbreekt, leeg is of geen `.sky`-bestanden bevat.
