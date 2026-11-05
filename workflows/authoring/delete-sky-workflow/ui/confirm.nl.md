---
short_description: Handmatige goedkeuring voordat het bestand wordt verwijderd.
long_description: Pauzeert de run totdat een mens de onomkeerbare verwijdering bevestigt. Afwijzen stopt de workflow met behoud van het bestand; zonder antwoord verloopt de gate na een uur.
---

Handmatig wait-kanaal; de prompt noemt het exacte bestand: `{{dir}}/{{name}}.sky`.
