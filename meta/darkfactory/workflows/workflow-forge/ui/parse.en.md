---
short_description: "Cheap haiku orientation: classifies the intent and sketches the authoring plan."
long_description: Claude (haiku), no file IO. Reads `{{intent}}` and decides new-versus-improve, picks the single trigger the intent implies, sketches the node DAG, and flags lint traps the author must avoid.
---
Outputs a compact bullet plan the author step follows: mode, trigger, node shape, and risks such as bareword `when` values or `{{var}}` inside bash.
