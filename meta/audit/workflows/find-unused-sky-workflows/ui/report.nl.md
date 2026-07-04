---
short_description: Classificeert elke workflow als SEEN-IN-LOGS of NEVER en print verwijdersuggesties.
long_description: Vergelijkt de bestandslijst met de vastgelegde run-historie, hoofdletterongevoelig. Elk NEVER-bestand krijgt een kant-en-klaar `skyway run delete-sky-workflow`-commando. Eindigt altijd met exit 0 — deze stap rapporteert, hij verwijdert nooit.
---
Leest `$SKY_OUTPUT_LIST` en `$SKY_OUTPUT_RUNS`, markeert elk bestand, en print één voorgesteld verwijdercommando per nooit-gedraaide workflow. Behandel de uitvoer als startpunt voor menselijke controle.
