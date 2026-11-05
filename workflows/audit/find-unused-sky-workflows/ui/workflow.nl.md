---
short_description: Vergelijkt elk .sky-bestand in een map met de run-historie en toont nooit-gedraaide bestanden als adviserende verwijderkandidaten.
long_description: Gebruik dit wanneer een .sky-workflowbibliotheek is gegroeid en je dood gewicht vermoedt. Het grept `skyway logs` op elke workflow-bestandsnaam en markeert de namen die nergens voorkomen, met kant-en-klare verwijdercommando's. Puur bash, geen Claude-kosten, en het verwijdert zelf niets.
---
Drie bash-stappen draaien na elkaar: `list` somt elk `.sky`-bestand in de doelmap op, `runs` legt de huidige `skyway logs`-uitvoer vast, en `report` markeert elk bestand als SEEN-IN-LOGS of NEVER. Elk NEVER-bestand krijgt een voorgesteld `skyway run delete-sky-workflow`-commando.

Het NEVER-oordeel is adviserend: opgeschoonde logs, hernoemde workflows of gloednieuwe bestanden geven allemaal valse positieven. Controleer voordat je iets verwijdert.

| Variable | Betekenis |
|----------|-----------|
| `dir` | Absoluut pad naar de map met de te scannen `.sky`-bestanden. |
