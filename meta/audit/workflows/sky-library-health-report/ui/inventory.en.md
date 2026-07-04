---
short_description: Enumerates the .sky files to grade.
long_description: Lists every .sky file in the target directory and fails fast if the directory is missing or empty, so no downstream step runs on a misconfigured input.
---
Reads `$SKY_DIR` and prints the file list the checks step will grade.
