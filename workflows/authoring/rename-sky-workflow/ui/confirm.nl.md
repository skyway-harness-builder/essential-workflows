---
short_description: Handmatige goedkeuring van de rename en referentie-herschrijving.
long_description: Pauzeert de run totdat een mens de rename plus de door de find-stap getoonde skyway run-referentie-herschrijving goedkeurt. Afwijzen stopt de workflow zonder wijzigingen; de gate verloopt na één uur.
---

Handmatig wait-kanaal. De prompt noemt de exacte wijziging: `{{name}}` -> `{{new-name}}` in `{{dir}}`.
