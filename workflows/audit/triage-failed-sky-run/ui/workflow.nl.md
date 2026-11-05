---
short_description: Leest de logs van een gefaalde run, wijst de falende node en de oorzaak aan, en stelt een fix-diff voor zonder iets toe te passen.
long_description: Gebruik dit nadat een skyway-run faalt en de oorzaak niet duidelijk is. Het haalt de run-logs en de workflow-broncode op, laat sonnet de falende node en de oorzaak benoemen met een betrouwbaarheidsnotitie, en produceert daarna een controleerbare unified diff plus het exacte update-sky-workflow-commando om hem toe te passen. Niets wordt automatisch toegepast; budget-begrensd op $2,00.
---
Drie stappen: `fetch` (bash) bevestigt dat het .sky-bestand bestaat en legt `skyway logs <run>` plus de broncode vast, `diagnose` (sonnet) identificeert de falende node-id en de concrete oorzaak, en `propose` (sonnet, hervat de diagnose-sessie via chain_from) levert een `diff -u`-patch en het apply-commando op één regel.

Als de faal omgevingsgebonden is (ontbrekende run-id, daemon down, tijdelijk) in plaats van een fout in de broncode, zegt propose dat expliciet en slaat de diff over.

| Variable | Betekenis |
|----------|-----------|
| `dir` | Map met het `.sky`-bestand. |
| `name` | Workflow-bestandsnaam zonder `.sky`. |
| `run` | De gefaalde run-id (verplicht; fetch eindigt niet-nul zonder). |
