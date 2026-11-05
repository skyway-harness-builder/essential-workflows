---
short_description: Rewrites all three token forms in every affected file.
long_description: For each file the scan flagged, a portable temp-file sed rewrites the template form, the bash env form (word-boundary guarded), the node-id form with its matching prompt-block opener, and the quoted id refs in depends_on and chain_from. Only files that actually contain a form are touched.
---

Pure bash, no `sed -i`. Rewrites `{{old}}` -> `{{new}}`, `$SKY_<UPPER_OLD>` -> `$SKY_<UPPER_NEW>`, `§old§`/`∆old∆` -> `§new§`/`∆new∆`, and quoted `"old"` id refs.
