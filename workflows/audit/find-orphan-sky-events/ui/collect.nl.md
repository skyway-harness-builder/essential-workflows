---
short_description: Grept listener- en emitter-eventnamen uit elk .sky-bestand naar werklijsten.
long_description: Haalt trigger.sky_event.event-namen en elke emit-naam uit bestanden onder $SKY_DIR, voor alle drie de emit-vormen (`emit = "x"`, `emit.name = "x"`, inline table). Schrijft twee werklijsten naar /tmp voor de match-stap.
---
De emit-detectie is woord-verankerd zodat de meta-sleutel `name =` nooit matcht.
