---
short_description: Rendert de uitgelijnde PLAN/WORKFLOW/DIAGNOSTIC-tabel met samenvattende tellingen.
long_description: Verzamelt de classificaties per workflow in één uitgelijnde matrix met totalen. Stopt met exitcode 1 als een workflow niet kon plannen, zodat de run geschikt is als CI-gate.
---
Per workflow wordt alleen de eerste diagnostische regel getoond; draai `skyway run <wf> --dry-run` handmatig voor de volledige fout.
