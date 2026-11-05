---
short_description: Manual approval of the planned rename before any edit.
long_description: Pauses the run so a human can review the scan preview. The regex rewrite is fragile - short or common tokens can false-match unrelated text - so nothing is edited until this gate is approved. Rejecting stops the workflow with nothing changed; times out after one hour.
---

Manual wait channel showing the planned `{{old}}` -> `{{new}}` edit, 1h timeout.
