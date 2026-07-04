---
short_description: Haalt de triggersignatuur van elke workflow op en rapporteert botsingen.
long_description: Bouwt een signatuur-naar-bestand-tabel in een /tmp-werkbestand (zodat cron-schema's met spaties intact blijven), groepeert die met awk en print elke signatuur die door meer dan één workflow geclaimd wordt. Stopt met exitcode 1 bij een conflict.
---
Elk bestand levert hoogstens één signatuur per triggersoort; handmatige triggers worden overgeslagen.
