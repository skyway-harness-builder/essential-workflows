---
short_description: Dry-runt elke gevonden workflow en classificeert hem als PASS, FAIL of SKIP.
long_description: Draait `skyway run --dry-run` per workflow — eerst via pad, met cd-plus-naam als terugval — en vangt bij falen de eerste diagnostische regel op. SKIP is een heuristiek voor workflows die variabelen nodig hebben die de audit niet kan leveren.
---
Draait na `discover`. De terugval op naam vereist dat het `name`-veld van de workflow overeenkomt met de bestandsnaam.
