# Resurrection Base Spells

These spell files are used by the local SCS resurrection component compatibility patch.

When Spell Revisions component 0 is installed, `stratagems/gameplay/resurrection.tpa` copies these base spell resources into `override` before SCS applies its permanent-death, massive-damage, and diamond-requirement edits. The copy is guarded by `FILE_EXISTS_IN_GAME`, so SCS only replaces spells that already exist in the current game/install.

NPC Bodies should be installed after SCS so it patches the final SCS-modified versions.
