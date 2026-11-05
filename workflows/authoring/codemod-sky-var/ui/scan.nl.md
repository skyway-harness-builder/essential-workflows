---
short_description: Grept alle drie tokenvormen door de map en toont elke hit vooraf.
long_description: Berekent de uppercase env-var-vormen van old en new, en doorzoekt daarna elk .sky-bestand op de template-, bash-env- en node-id-vorm van het token. Print een genummerd overzicht van elke hit plus de set geraakte bestanden; faalt wanneer de map of het token ontbreekt of niets matcht.
---

Puur bash. Nul hits is een harde stop (exit 1) - niets om te codemodden betekent niets om goed te keuren.
