---
short_description: Reads the source file to convert.
long_description: Cats the shell script, Makefile target, or cron line given in source so downstream nodes can pick it up from the node output. Exits with an error when the file is missing or empty, halting the run before any tokens are spent.
---

Pure bash. The source contents land in `$SKY_OUTPUT_READ` for the author step.
