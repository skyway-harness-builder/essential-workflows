---
short_description: Runs annotate-sky-workflow for each unannotated workflow found by the scan.
long_description: Reads the scan output line by line and invokes annotate-sky-workflow synchronously for each unannotated workflow directory. Sequential by design — one annotation run finishes before the next starts, so runs never pile up.
---

Reads `$SKY_OUTPUT_SCAN` and runs `skyway run annotate-sky-workflow --vars "dir=<wf_dir>,name=workflow"` per directory. Exits early when the scan found nothing.
