---
short_description: Manual approval before the file is moved.
long_description: Pauses the run until a human confirms the move. The prompt spells out the consequences — archiving neutralizes the trigger, restore returns the file as manual-only — and shows the paths resolved by the find step. Times out after one hour.
---

Manual wait channel with a 1h timeout. Nothing is touched until this gate is approved.
