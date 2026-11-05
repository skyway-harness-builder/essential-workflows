---
short_description: Scant elk .sky-bestand op ongedeclareerde secret-achtige env-var-referenties.
long_description: Haalt namen van omgevingsvariabelen uit bash/http-regels, houdt alleen de credential-achtige over, trekt af wat de workflow in secrets[] declareert en rapporteert de rest. Stopt met een foutcode zodra een bestand een ongedeclareerde referentie bevat.
---
Gewone shell-locals worden genegeerd om ruis te beperken; onderdruk een echte bevinding door hem te declareren in `secrets = [...]`.
