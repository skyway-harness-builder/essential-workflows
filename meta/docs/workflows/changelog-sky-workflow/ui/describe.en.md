---
short_description: Turns the diff into one reviewable changelog bullet.
long_description: A haiku node reads the diff and writes exactly one markdown bullet describing what changed in reviewable terms - node additions and removals, edge rewiring, trigger, budget, model, and prompt or bash edits. Outputs "- no changes" when the diff is empty.
---

Reads `$SKY_OUTPUT_DIFF`; never quotes raw diff lines, no headings or extra text.
