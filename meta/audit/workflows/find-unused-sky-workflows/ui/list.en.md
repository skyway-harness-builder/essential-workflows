---
short_description: Enumerates every .sky file in the target directory.
long_description: Prints the basename of each .sky file in the directory passed via `--var dir`, one per line, with no filtering or prior state. Fails the run early if the directory is missing or contains no .sky files.
---
Reads `$SKY_DIR` and lists all `*.sky` basenames for the downstream cross-reference step.
