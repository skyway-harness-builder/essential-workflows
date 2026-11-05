---
short_description: Scans each .sky file for undeclared secret-shaped env-var references.
long_description: Extracts environment-variable names from bash/http lines, keeps only the credential-looking ones, subtracts what the workflow declares in secrets[], and reports the rest. Exits non-zero when any file has an undeclared reference.
---
Ordinary shell locals are ignored to keep noise down; silence a real finding by declaring it in `secrets = [...]`.
