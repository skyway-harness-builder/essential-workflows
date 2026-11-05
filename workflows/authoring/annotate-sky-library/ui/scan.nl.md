---
short_description: Vindt elke workflow.sky in de library zonder ※id※-annotatieblokken.
long_description: Loopt de map uit dir recursief door op zoek naar workflow.sky-bestanden en filtert de bestanden weg die al een ※id※-annotatie-opener bevatten. Print één ongeannoteerde workflow-map per regel; lege output betekent dat de hele library al geannoteerd is.
---

Puur bash. Loopt `$SKY_DIR` door (gesorteerd), grept elke `workflow.sky` op het `※<id>※`-openerpatroon en print de bovenliggende map van elk bestand dat er geen heeft.
