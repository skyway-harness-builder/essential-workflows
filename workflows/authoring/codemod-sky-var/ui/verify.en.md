---
short_description: Re-lints every .sky in the directory after the rewrite.
long_description: Runs skyway lint over every .sky file in the directory and exits non-zero if any fails, so a bad codemod surfaces immediately. The fragile rewrite is only trusted once this passes - review git diff regardless.
---

Pure bash gate. A touched file with a broken reference is exactly the failure this step exists to catch.
