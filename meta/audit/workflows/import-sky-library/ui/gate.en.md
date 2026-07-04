---
short_description: Manual approval gate before any file is copied.
long_description: Pauses the run and shows the PASS (will import), FAIL (rejected), and SKIP (already exists) sets. Nothing mutates the target directory until you approve. Times out after 1 hour if unanswered.
---
Waits on the manual channel. Approve to let `finalize` copy the staged PASS files into the target.
