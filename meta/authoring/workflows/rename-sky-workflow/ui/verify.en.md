---
short_description: Lints the renamed file and warns on leftover old-name references.
long_description: Runs skyway lint on the renamed workflow, which catches a name-to-filename mismatch, and scans for any skyway run references to the old name the plain-text rewrite may have missed - for example when one workflow name is a prefix of another.
---

Pure bash. Leftover references are flagged for manual review, not auto-fixed.
