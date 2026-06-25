# NPC Bodies

NPC Bodies makes joinable NPC death depend on the presence and condition of the NPC's body. Raise Dead-style spells require the body, while Resurrection-style magic can restore a character even when the body is missing.

## Compatibility Install Order

When using Spell Revisions, Sword Coast Stratagems, and NPC Bodies together, install them in this order:

1. Spell Revisions
2. Sword Coast Stratagems
3. NPC Bodies

This order is important because Spell Revisions replaces many spell resources, SCS's revised resurrection/permanent-death component restores the resurrection-family spells from `stratagems/resurrection_base`, then SCS patches those restored resources for massive-damage and diamond requirements. NPC Bodies then patches the final SCS-modified spell resources for body requirements.

In this order:

- Spell Revisions supplies its revised spell files.
- SCS component 4130, "Revise perma-death", detects Spell Revisions and replaces the installed resurrection-family spells with the base resources from `stratagems/resurrection_base`.
- SCS component 4130 then adds its permanent-death handling and, when enabled, the diamond requirement for Resurrection.
- NPC Bodies preserves SCS's changes and adds its body-present/body-missing rules on top.

NPC Bodies intentionally does not replace SCS-modified Raise Dead, Recall Spirit, Mass Raise Dead, Harper's Call, or Resurrection spells with fresh Spell Revisions files after SCS component 4130 has been installed. This preserves SCS's `dw#radm` massive-damage checks and `dw#diamo` diamond requirement.

Wish Resurrection is treated as Resurrection-like magic by NPC Bodies and does not require the body to be present.
