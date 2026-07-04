---
short_description: Controleert dat elke workflow in de index terechtkwam.
long_description: Bash-dekkingscontrole - INDEX.md moet bestaan, niet leeg zijn en elk .sky-bestand in de map vermelden. Eindigt met een foutcode wanneer de index verouderd of onvolledig is, zodat een slechte regeneratie nooit onopgemerkt blijft.
---

Puur bash. Vergelijkt de `.sky`-lijst van de map met de rijen in `INDEX.md`.
