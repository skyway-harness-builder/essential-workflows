---
short_description: Verplaatst de workflow naar _archive/ (of terug) en stript trigger-regels bij archiveren.
long_description: In archive-modus maakt hij de _archive/-map aan, verwijdert elke trigger-regel uit het bestand en verplaatst het met git mv (met mv als fallback). In restore-modus gaat het bestand terug; de trigger blijft geneutraliseerd zodat de workflow als manual-only terugkeert.
---

Puur bash. De trigger-strip (`grep -v '^trigger.'`) garandeert dat een gearchiveerd bestand nooit automatisch kan afgaan, zelfs als de loader `_archive/` scant.
