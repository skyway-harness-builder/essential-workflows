---
short_description: Markeert loshangende sky_event-verbindingen — listeners zonder emitter en emit-signalen zonder listener.
long_description: Scant een .sky-library op event-verbindingen zonder abonnees, dus een trigger.sky_event die niemand emit (dode listener) of een emit-naam waar niemand naar luistert (dood signaal). Het complement van check-sky-trigger-conflicts, dat juist over-abonnering markeert. Puur bash, stopt met exitcode 1 als er een wees bestaat.
---
Drie bash-stappen: `collect` grept listener- en emitter-namen uit elk bestand, `match` vergelijkt de twee lijsten met comm/grep, en `report` print beide wezenlijsten en zet de exitcode.

| Variable | Meaning |
|----------|---------|
| `dir` | Map met de `.sky`-bestanden om te scannen (gelezen als `$SKY_DIR`) |
