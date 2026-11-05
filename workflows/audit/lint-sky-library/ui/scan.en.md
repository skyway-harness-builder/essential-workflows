---
short_description: Lints every .sky file and collects the failures.
long_description: Globs `$SKY_DIR/*.sky` and runs `skyway lint` on each file, collecting failing paths plus their SKY-WF-* error codes. Exits 1 if anything failed — that nonzero exit is the gate that triggers the fix node.
---
Exits 0 when the whole library is already clean (the fix node is then skipped) and 2 when the directory is missing, empty, or has no `.sky` files.
