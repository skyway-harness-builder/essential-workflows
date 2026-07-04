---
short_description: Oefent de skill zoals geschreven uit tegen elke gesynthetiseerde eval-case.
long_description: Claude (sonnet). Produceert per eval-case het antwoord dat een model met deze skill geladen zou geven, met uitsluitend de geïnjecteerde SKILL.md-tekst en gebundelde scripts — geen externe kennis — zodat de judge de skill zoals geschreven kan scoren, inclusief de gaten.
---
Legt één transcript per case vast, met het antwoord en welke skill-secties of scripts zijn gebruikt. Het scoort zichzelf nooit en bewerkt geen bestanden.
