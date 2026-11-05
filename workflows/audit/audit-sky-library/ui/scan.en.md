---
short_description: Lists the .sky files in the target directory.
long_description: Globs the directory passed via --var dir and hands the file list to the lint step. Finding no .sky files is not a failure — the run notes it and stops cleanly.
---
Reads the target directory from `$SKY_DIR` and exits 0 when nothing is found.
