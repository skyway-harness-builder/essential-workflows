---
short_description: Handmatige goedkeuring van de geplande rename vóór enige bewerking.
long_description: Pauzeert de run zodat een mens het scan-overzicht kan beoordelen. De regex-rewrite is fragiel - korte of veelvoorkomende tokens kunnen onbedoeld matchen - dus er wordt niets bewerkt totdat deze gate is goedgekeurd. Afwijzen stopt de workflow zonder wijzigingen; verloopt na één uur.
---

Handmatig wait-kanaal dat de geplande `{{old}}` -> `{{new}}`-bewerking toont, timeout 1u.
