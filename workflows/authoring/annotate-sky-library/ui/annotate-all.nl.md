---
short_description: Draait annotate-sky-workflow voor elke ongeannoteerde workflow die de scan vond.
long_description: Leest de scan-output regel voor regel en start annotate-sky-workflow synchroon voor elke ongeannoteerde workflow-map. Bewust sequentieel — één annotatierun is klaar voordat de volgende start, zodat runs zich nooit opstapelen.
---

Leest `$SKY_OUTPUT_SCAN` en draait `skyway run annotate-sky-workflow --vars "dir=<wf_dir>,name=workflow"` per map. Stopt vroeg wanneer de scan niets vond.
