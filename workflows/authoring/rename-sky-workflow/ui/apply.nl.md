---
short_description: Voert de rename uit - git mv, meta-naam-fix, referentie-herschrijving.
long_description: Verplaatst het bestand met git mv, werkt het meta-naamveld bij naar de nieuwe naam, en vervangt met sed elke skyway run-referentie naar de oude naam in de map. Alle drie bewerkingen gebeuren in één stap zodat de library nooit een half-hernoemde staat ziet.
---

Puur bash. De referentie-herschrijving is een platte tekstvervanging van `skyway run <old>` -> `skyway run <new>`.
