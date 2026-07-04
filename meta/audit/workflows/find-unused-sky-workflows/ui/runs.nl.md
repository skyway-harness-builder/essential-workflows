---
short_description: Legt de huidige skyway run-historie vast.
long_description: Draait `skyway logs` en print de ruwe uitvoer waar de report-stap tegenaan grept. Tolereert een lege of onbereikbare log zodat de scan hier nooit crasht; in dat geval rapporteert elk bestand later NEVER.
---
Schrijft de `skyway logs`-uitvoer naar een tijdelijk bestand, print die als `$SKY_OUTPUT_RUNS`, en ruimt het tijdelijke bestand op. Draait nadat `list` klaar is.
