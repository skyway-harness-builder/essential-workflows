---
short_description: Lists the candidate .sky files in the source directory.
long_description: Enumerates every .sky file in the source folder and fails fast if either directory is missing or no candidates exist. Nothing downstream runs on an empty or misconfigured source.
---
Reads `$SKY_SOURCE` and `$SKY_DIR` and prints the candidate list for the validate step.
