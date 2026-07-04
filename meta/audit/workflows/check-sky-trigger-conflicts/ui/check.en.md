---
short_description: Extracts each workflow's trigger signature and reports collisions.
long_description: Builds a signature-to-file table in a /tmp scratch file (so cron schedules containing spaces survive intact), groups it with awk, and prints every signature claimed by more than one workflow. Exits 1 on any conflict.
---
Each file contributes at most one signature per trigger kind; manual triggers are skipped.
