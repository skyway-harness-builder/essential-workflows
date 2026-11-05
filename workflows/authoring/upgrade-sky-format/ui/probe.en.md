---
short_description: Lints the file and exits with lint's own status.
long_description: The cost gate of the workflow - exits 0 when the file lints clean, so the fix node is skipped and no tokens are spent; exits non-zero when lint reports problems, which is exactly what triggers the fix node. A missing file is a hard error with a clear message.
---

Pure bash: `skyway lint "$SKY_DIR/$SKY_NAME.sky"`, exit code passed through.
