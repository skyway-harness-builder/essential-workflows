---
short_description: Hernoemt de kloon en stript elke trigger-regel.
long_description: Twee portable temp-file sed-bewerkingen op de bestemming - de meta-naam omzetten naar de nieuwe naam, en daarna elke regel die met trigger. begint verwijderen zodat de kloon nooit samen met de bron dubbel afvuurt. Zonder trigger-blok is de kloon standaard handmatig, precies wat een vers sjabloon hoort te zijn.
---

Puur bash, geen `sed -i` (BSD en GNU verschillen). De trigger-strip is de kern van deze workflow.
