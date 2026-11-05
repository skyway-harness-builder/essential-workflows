---
short_description: Finds every workflow.sky in the library with no ※id※ annotation blocks.
long_description: Walks the directory given in dir recursively for workflow.sky files and filters out the ones that already contain a ※id※ annotation opener. Emits one unannotated workflow directory per line; empty output means the whole library is already annotated.
---

Pure bash. Walks `$SKY_DIR` (sorted), greps each `workflow.sky` for the `※<id>※` opener pattern, and prints the parent directory of every file that lacks one.
