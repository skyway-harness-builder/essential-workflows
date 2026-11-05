---
short_description: Configures the fresh clone and pushes the first commit.
long_description: Clones the new repo into a temp directory, applies the vendor token replacements, renames the workflows/__vendor__/ directory to the real vendor slug, strips the delete-blocks from the README, then commits and pushes. The temp directory is cleaned up on exit.
---

Pure bash with `python3` for the token replacements (vendor, author, date).
