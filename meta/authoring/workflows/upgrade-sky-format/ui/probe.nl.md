---
short_description: Lint het bestand en eindigt met de exitstatus van lint zelf.
long_description: De kostenpoort van de workflow - eindigt met 0 wanneer het bestand schoon lint, zodat de fix-node wordt overgeslagen en er geen tokens worden uitgegeven; eindigt met een foutcode wanneer lint problemen meldt, wat precies de fix-node activeert. Een ontbrekend bestand is een harde fout met een duidelijke melding.
---

Puur bash: `skyway lint "$SKY_DIR/$SKY_NAME.sky"`, exitcode wordt doorgegeven.
