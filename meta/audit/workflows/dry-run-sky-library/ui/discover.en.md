---
short_description: Globs the target directory and emits one name/path row per .sky file.
long_description: Lists every .sky file under the directory passed via --var dir, one tab-separated row each. Exits 2 when the directory is missing, not a directory, or contains no .sky files.
---
Reads the target directory from `"$SKY_DIR"`.
