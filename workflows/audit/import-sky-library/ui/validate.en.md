---
short_description: Lints each candidate and sorts it into PASS, FAIL, or SKIP.
long_description: Runs `skyway lint` on every candidate file. Lint-clean files that do not yet exist in the target are staged to a temp list under /tmp; failures are logged with their SKY-* error codes; same-named files already in the target are marked SKIP.
---
Produces the PASS/FAIL/SKIP sets the manual gate will display. Only staged PASS files can ever be imported.
