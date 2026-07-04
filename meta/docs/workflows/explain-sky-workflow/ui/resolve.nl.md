---
short_description: Controleert dat het doelbestand bestaat en verzamelt describe-context.
long_description: Controleert dat het workflowbestand bestaat en eindigt met een duidelijke melding wanneer dat niet zo is, zodat de explain-stap nooit op een ontbrekend bestand draait. Draait ook best-effort skyway describe om de explain-stap extra context te geven. Alleen-lezen - geen mutatie.
---

Puur bash. Controleert `"$SKY_DIR/$SKY_NAME.sky"`; de output voedt `$SKY_OUTPUT_RESOLVE`.
