---
short_description: Leest het bronbestand dat omgezet wordt.
long_description: Cat het shellscript, de Makefile-target of cron-regel uit source zodat volgende nodes de inhoud uit de node-output kunnen halen. Eindigt met een fout als het bestand ontbreekt of leeg is, zodat de run stopt voordat er tokens worden uitgegeven.
---

Puur bash. De broninhoud komt in `$SKY_OUTPUT_READ` terecht voor de author-stap.
