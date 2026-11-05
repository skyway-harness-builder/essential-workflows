---
short_description: Valideert gh, authenticatie en de verplichte vendor-var.
long_description: Controleert dat de gh CLI is geïnstalleerd en ingelogd en dat de vendor-variabele is gezet, en print daarna de opgeloste configuratie (org, repo, vendor, vendor-name). Stopt vroeg zodat er niets wordt aangemaakt wanneer de voorwaarden niet kloppen.
---

Puur bash. Standaardwaarden worden hier bepaald: `repo` valt terug op `<vendor>-workflows`, `org` op de ingelogde gebruiker.
