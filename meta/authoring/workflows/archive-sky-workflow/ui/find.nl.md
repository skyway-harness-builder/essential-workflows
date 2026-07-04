---
short_description: Bepaalt bron- en doelpad op basis van de archive/restore-modus.
long_description: Berekent waar het workflow-bestand nu staat en waar het naartoe moet, op basis van de mode-variabele. Faalt direct als de bron ontbreekt of het doel al bestaat, zodat de gate altijd een geldige verplaatsing toont die niets overschrijft.
---

Puur bash. Leest `$SKY_MODE` (`archive` of `restore`), print beide paden en eindigt met een foutcode wanneer de verplaatsing ongeldig zou zijn.
