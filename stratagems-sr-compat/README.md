# Stratagems + Spell Revisions compatibility patch (component 4130)

An unofficial, small patch for **Stratagems (SCS)** component 4130, "Revised handling
of death effects". It is not a fork or replacement of Stratagems. It changes two files
and adds one folder. All credit for Stratagems belongs to its author, Stratagems' author (the `dw` resource prefix is Dave Wilson's; confirm the credit line against the Stratagems readme before posting).

## Why

Stock Stratagems refuses to install 4130 when Spell Revisions is installed
(`FORBID_COMPONENT "spell_rev/setup-spell_rev.tp2"`). This patch lets 4130 install on top
of Spell Revisions. It first resets the few Spell Revisions resurrection spells to their
base versions, then applies Stratagems' normal edits (permanent-death handling,
massive-damage block, diamond requirement, and restoring a chunked body on Resurrection).

NPC Bodies component 600 (temple/Wish resurrection of dismissed companions) requires 4130.

## Install order

Spell Revisions, then Stratagems (with this patch applied, component 4130), then NPC Bodies.

## What to change in your Stratagems folder

1. `setup-stratagems.tp2`: in component `BEGIN @3401 DESIGNATED 4130`, delete this line
   (the one directly under `REQUIRE_PREDICATE (GAME_IS ~bgee bg2ee eet~) @2002`):

   ```
   FORBID_COMPONENT "spell_rev/setup-spell_rev.tp2" 0 @234
   ```

   Do not touch the other `FORBID_COMPONENT ... @234` / `@230` lines in other components.
   `apply-patch.ps1` does this for you.

2. Replace `stratagems/gameplay/resurrection.tpa` with the patched one in this folder
   (`gameplay/resurrection.tpa`). Differences from stock:
   - a block at the top of `resurrection` that, when Spell Revisions is installed, copies
     the spells in `resurrection_base/` into `override` first;
   - `overwrite:i=1` on the `dw#p1pet` and `dw#gnpet` `spl.make` calls, since Spell
     Revisions can already ship spells with those names.

3. Add the `resurrection_base/` folder next to `gameplay/`, inside `stratagems/`.

## Files in the base folder

`resurrection_base/*.spl` are copies of unmodified game spells (SPPR504, SPPR550,
SPPR729, SPJA01, SPPR712, SPPR712A, BHAAL4A, BHAAL4AA, SPWISH10). They are game data,
so check redistribution terms before uploading them publicly. A safer option is to
extract them from a clean install yourself and tell users to do the same.

## Uninstall / support

Uninstall in reverse order. Report problems with this patch to its maintainer, not to
the Stratagems author.
