---
short_description: Koppelt het GitHub Project aan de repo zodat het bord zijn items kan ophalen.
long_description: Deterministische bash + `gh`, geen LLM. Voert `gh project link` uit met de owner, repo en het projectnummer uit preflight. In effect idempotent — een al gekoppeld project wordt gemeld, niet als fout behandeld.
---
Verbindt het projectbord met de repository; zonder deze koppeling hebben de auto-add-workflow en de Kanban-weergave niets om uit te putten.
