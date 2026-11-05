---
short_description: Parseert de node-graaf en hertekent het ASCII-diagram in de header.
long_description: Een haiku-node leest het bestand, noteert elke depends_on-, chain_from- en when-edge en bouwt een ASCII-DAG die alleen de echte edges weerspiegelt. Daarna vervangt hij enkel de diagramsectie van de bovenste losse commentaar-header, met behoud van titel, run-commando en var-documentatie - per-stap-commentaarblokken worden nooit aangeraakt.
---

Bewerkt in situ met de Edit-tool. Conventies: `->` voor een dependency-edge, `=chain=>` voor `chain_from`, `(when ...)` naast bewaakte nodes.
