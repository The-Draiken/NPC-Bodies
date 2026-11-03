EXTEND_BOTTOM ~__PRIEST__~ 0
	// Offered whenever this companion has died at least once (EJdead flag
	// set) and is not currently a normal dead-in-party member reachable
	// through the native Raise Dead/Resurrection store -- i.e. they were
	// dismissed from the party at some point after dying.
	//
	// The priest directly casts Raise Dead or Resurrection on her while she
	// is still a harmless, non-party NPC standing nearby, and only calls
	// JoinParty() once she is genuinely alive -- the same well-supported
	// path used the first time she ever joined the party (confirmed working,
	// no crash, via live testing).
	//
	// BUGFIX (chunked/permadeath revival): the first action in both DO
	// blocks below is ChangeGeneral("__DV__",DEAD). The real Resurrection
	// spell only applies its raising sub-spell -- the one Stratagems edits
	// so its Raise Dead effect (opcode 32) restores the creature
	// animation, which is what turns a chunked companion back into a whole
	// body -- to a target whose GENERAL is DEAD. This mod's scripts used to
	// relabel a dead companion's GENERAL as the custom EJNOBOD whenever
	// the party held no body item for her (a chunked companion never has
	// one), so that sub-spell was skipped. Setting it back to DEAD here,
	// before the spell is cast, lets Stratagems' own logic run unchanged.
	// Confirmed by a pure-Stratagems test install, which reconstructs a
	// chunked companion correctly with an ordinary Resurrection cast.
	//
	// The actual revival SPELL cast still doesn't happen here in the DO
	// block -- it can't, since a DO block is a flat action list with no
	// conditionals, and Component 200's CON-loss / temple-immune
	// max-HP-loss penalty effects need the correct spell (Raise Dead vs.
	// Resurrection) to actually be cast, which depends on which reply the
	// player picked. This DO block sets EJRevSpell__INDEX__ (1 = Raise
	// Dead, 2 = Resurrection) and hands off to the EJRJN__INDEX__ watcher
	// (below), which casts the requested spell via ReallyForceSpellDead
	// (the correct action for casting on a currently-dead target, per
	// action.ids) once she's no longer chunked -- by which point Polymorph
	// has already run, so this now works the same regardless of whether she
	// was chunked or just normally dead. See npc-bodies.tp2's
	// EJRJN%ind%.baf generation (Component 600) for the watcher's own
	// history of attempts at this.
	//
	// Relocation uses MakeGlobal()+MoveGlobal(), NOT LeaveAreaLUA -- per the
	// Wild Mage Editions source (wm_disp.baf line 191: "For party members,
	// uses LeaveAreaLUA; for NPCs, uses MoveGlobal with MakeGlobal"), this
	// is the correct pair now that she is genuinely a non-party object at
	// the moment of relocation (LeaveAreaLUA is for actual party members).
	//
	// JOIN-AFTER-REVIVAL IS NO LONGER A FIXED Wait()+JoinParty() HERE.
	// Live testing showed that's a real race: ReallyForceSpellDead's actual
	// "clear STATE_DEAD" effect isn't guaranteed to have finished applying
	// within a fixed couple of seconds, and calling JoinParty() before it
	// has reproduces the ORIGINAL null-pointer crash this component was
	// built to avoid (JoinParty on a still-dead creature) -- or, short of a
	// crash, she'd join for an instant and then get kicked back out, or
	// simply not join at all. Rather than guess a longer fixed wait (same
	// race, just less likely), a tiny dedicated watcher creature
	// (EJRJN__INDEX__, set up once per companion in npc-bodies.tp2's
	// Component 600) is spawned right after the revive cast; its own
	// script polls every round, indefinitely, until Dead("__DV__") is
	// genuinely false, THEN joins her and destroys itself. Same "spawn a
	// script-driven watcher that polls, then acts" pattern this mod already
	// uses for EJdro%ind% elsewhere, just as its own dedicated creature so
	// none of EJdro's unrelated item-pickup/decay logic can interfere.
	//
	// Two options, gated on whether the fresh (non-decayed) body item is in
	// the party's inventory:
	//   - Raise Dead: requires EJB__INDEX__a (fresh body). Costs
	//     __RAISE_COST__ gold (companion's level x 1000gp, matching
	//     Component 300's RAISDEAD.2DA scale).
	//   - Resurrection: offered whenever the fresh body is NOT held --
	//     whether the decayed body (EJB__INDEX__b) is held instead, or no
	//     remains exist at all (fully dismissed/permadeath-recoverable
	//     case). Costs __RES_COST__ gold (double the Raise Dead rate).

	// --- Raise Dead: fresh body held, enough gold ---
	IF ~Global("EJdead__INDEX__","GLOBAL",1)
	    Global("EJjoined__INDEX__","GLOBAL",1)
	    !InPartyAllowDead("__DV__")
	    !StateCheck("__DV__",STATE_PERMANENT_DEATH)
	    PartyHasItem("EJB__INDEX__a")
	    PartyGoldGT(__RAISE_COST_M1__)~ THEN REPLY ~I once traveled with a companion who died and is no longer in my party. I still have their body -- please, raise them from death. (Raise Dead, __RAISE_COST__ gold)~
		DO ~ChangeGeneral("__DV__",DEAD)
		   TakePartyItem("EJB__INDEX__a")
		   DestroyItem("EJB__INDEX__a")
		   TakePartyGold(__RAISE_COST__)
		   ActionOverride("__DV__",MakeGlobal())
		   ActionOverride("__DV__",MoveGlobal(__MOVEGLOBAL_ARGS__))
		   Wait(1)
		   SetGlobal("EJRevSpell__INDEX__","GLOBAL",1)
		   SetGlobal("EJRejoinPending__INDEX__","GLOBAL",1)
		   CreateCreatureObject("EJRJN__INDEX__",Myself,0,0,0)
		~
		EXIT

	// --- Raise Dead: fresh body held, not enough gold ---
	IF ~Global("EJdead__INDEX__","GLOBAL",1)
	    Global("EJjoined__INDEX__","GLOBAL",1)
	    !InPartyAllowDead("__DV__")
	    !StateCheck("__DV__",STATE_PERMANENT_DEATH)
	    PartyHasItem("EJB__INDEX__a")
	    !PartyGoldGT(__RAISE_COST_M1__)~ THEN REPLY ~I once traveled with a companion who died and is no longer in my party. I still have their body, but I cannot yet afford to have them raised. (Raise Dead costs __RAISE_COST__ gold)~
		EXIT

	// --- Resurrection: fresh body NOT held (decayed body, no remains, or
	// permanently dead/chunked -- true Resurrection is meant to bring back
	// anyone regardless of how thoroughly the body was destroyed, so
	// STATE_PERMANENT_DEATH is deliberately NOT excluded here, only on the
	// Raise Dead branches above), enough gold ---
	IF ~Global("EJdead__INDEX__","GLOBAL",1)
	    Global("EJjoined__INDEX__","GLOBAL",1)
	    !InPartyAllowDead("__DV__")
	    !PartyHasItem("EJB__INDEX__a")
	    PartyGoldGT(__RES_COST_M1__)~ THEN REPLY ~I once traveled with a companion who died and is no longer in my party. Their remains have decayed too far to be raised, or are lost entirely -- I ask instead for a Resurrection. (__RES_COST__ gold)~
		DO ~ChangeGeneral("__DV__",DEAD)
		   TakePartyItem("EJB__INDEX__b")
		   DestroyItem("EJB__INDEX__b")
		   TakePartyGold(__RES_COST__)
		   ActionOverride("__DV__",MakeGlobal())
		   ActionOverride("__DV__",MoveGlobal(__MOVEGLOBAL_ARGS__))
		   Wait(1)
		   SetGlobal("EJRevSpell__INDEX__","GLOBAL",2)
		   SetGlobal("EJRejoinPending__INDEX__","GLOBAL",1)
		   CreateCreatureObject("EJRJN__INDEX__",Myself,0,0,0)
		~
		EXIT

	// --- Resurrection: fresh body NOT held (including permanently
	// dead/chunked), not enough gold ---
	IF ~Global("EJdead__INDEX__","GLOBAL",1)
	    Global("EJjoined__INDEX__","GLOBAL",1)
	    !InPartyAllowDead("__DV__")
	    !PartyHasItem("EJB__INDEX__a")
	    !PartyGoldGT(__RES_COST_M1__)~ THEN REPLY ~I once traveled with a companion who died and is no longer in my party. Their remains have decayed too far to be raised, or are lost entirely, but I cannot yet afford a Resurrection. (Resurrection costs __RES_COST__ gold)~
		EXIT
END
