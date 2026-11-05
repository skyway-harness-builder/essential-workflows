---
short_description: Levert een controleerbare fix-diff plus het commando om hem toe te passen.
long_description: Hervat de diagnose-sessie (chain_from) en produceert precies twee dingen; een unified `diff -u`-patch voor het .sky-bestand die de oorzaak verhelpt, en het `skyway run update-sky-workflow`-commando op één regel dat hem toepast. Alleen uitvoer — het bewerkt, schrijft en draait niets.
---
Wanneer de faal omgevingsgebonden is in plaats van een fout in de broncode, zegt het dat ronduit en slaat de diff over.
