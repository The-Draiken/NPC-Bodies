EXTEND_BOTTOM ~__WISHDLG__~ 0
	// Offered for every companion who has died at least once (EJdead flag
	// set) and is not currently a normal party member reachable through the
	// native Raise Dead/Resurrection store -- i.e. dismissed from the party
	// at some point after dying. Unlike the temple-priest version of this
	// same idea (ejtemple-single.d), there is deliberately:
	//   - no gold cost
	//   - no CON penalty on the revived companion
	//   - no STATE_PERMANENT_DEATH exclusion (chunked/permadeath included)
	//   - no fresh-body/decayed-body distinction at all
	// per the user's explicit design: Wish is meant to supersede Raise
	// Dead/Resurrection entirely, bringing anyone back regardless of how
	// they died or whether their remains still exist.
	//
	// __WISHDLG__ is WISH01's (or WISH02's) OWN real dialogue resref, read
	// dynamically at install time in npc-bodies.tp2's Component 600 genie
	// setup -- not a dialogue this mod owns. This reply is simply appended
	// to whatever vanilla Wish's genie already says, the same way this
	// mod's other dialogue additions extend real NPCs' own DLG files.
	//
	// CLERIC_RESURRECTION is used rather than CLERIC_RAISE_DEAD specifically
	// because, per Component 200, only Raise Dead carries the -1 CON
	// penalty on its target -- Resurrection never did. So simply always
	// using Resurrection here already gives a fully penalty-free revival
	// with no extra "cancel the penalty" machinery needed. Resurrection's
	// OWN penalty (-8 max HP, opcode 18) lands on the CASTER of record,
	// which here is WISH01/WISH02 itself -- a vanilla, disposable summon.
	//
	// BUGFIX (chunked/permadeath revival): the first action in the DO block
	// below is ChangeGeneral("__DV__",DEAD). The real Resurrection spell
	// only applies its raising sub-spell -- the one Stratagems edits so its
	// Raise Dead effect (opcode 32) restores the creature animation, which
	// is what turns a chunked companion back into a whole body -- to a
	// target whose GENERAL is DEAD. This mod's scripts used to relabel a
	// dead companion's GENERAL as the custom EJNOBOD whenever the party
	// held no body item for her (a chunked companion never has one), so
	// that sub-spell was skipped. Setting it back to DEAD here, before the
	// spell is cast, lets Stratagems' own logic run unchanged. Confirmed
	// by a pure-Stratagems test install, which reconstructs a chunked
	// companion correctly with an ordinary Resurrection cast.
	//
	// As with the temple-priest path, the actual revival SPELL cast doesn't
	// happen in this DO block -- it can't, since a DO block has no
	// conditionals. This DO block sets EJRevSpell__INDEX__=2 (Resurrection)
	// and hands off to the shared EJRJN__INDEX__ watcher, which casts it via
	// ReallyForceSpellDead and then waits for her to be alive before
	// rejoining her. See npc-bodies.tp2's EJRJN%ind%.baf generation.
	//
	// BUGFIX: this originally assumed WISH01/WISH02 would despawn on their
	// own via their native script/dialogue once the conversation ended, so
	// no DestroySelf() was issued here. Live testing showed that's wrong --
	// whatever native cleanup they have is apparently tied to reaching one
	// of the ORIGINAL dialogue's own end states, not just "any reply exits
	// the conversation," so a genie summoned purely to reach OUR appended
	// reply never got cleaned up. DestroySelf() is called explicitly below
	// instead, once it's already done its job (relocating her and spawning
	// the join-watcher) -- safe, since the watcher (EJRJN__INDEX__) doesn't
	// depend on the genie object still existing.
	//
	// MoveGlobalObject(Object,Target) -- confirmed present in this game's
	// own action.ids and proven working (via the user-supplied Dimension
	// Gate mod's _!ptgt0i.BAF) -- moves the dismissed companion straight to
	// wherever the genie currently stands, entirely at runtime, with no
	// literal area string needed. This is what makes the genie able to
	// pull this off from ANY area, unlike the temple-priest system (which
	// needs a precomputed per-priest area since it uses the older
	// MakeGlobal+MoveGlobal pair). MakeGlobal() is still applied first as a
	// defensive measure, matching the one other place in this mod that
	// relocates a non-party NPC object.
	//
	// JOIN-AFTER-REVIVAL IS NOT a fixed Wait()+JoinParty() here, for the
	// same reason as the temple-priest version (see ejtemple-single.d):
	// live testing showed ReallyForceSpellDead's revive effect isn't
	// guaranteed to finish within a fixed couple of seconds, and calling
	// JoinParty() before it has reproduces the original null-pointer crash,
	// or joins her only to have her immediately kicked back out, or fails
	// outright. The same EJRJN__INDEX__ watcher creature used by the
	// temple-priest path (set up once per companion in npc-bodies.tp2's
	// Component 600, shared by both paths) is spawned here too; it polls
	// every round until she's genuinely alive, then joins her.
	IF ~Global("EJdead__INDEX__","GLOBAL",1)
		Global("EJjoined__INDEX__","GLOBAL",1)
		!InPartyAllowDead("__DV__")~ THEN REPLY ~Bring back __NAME__, a companion of mine who fell long ago. (Free -- a wish supersedes even death itself)~
		DO ~ChangeGeneral("__DV__",DEAD)
		   ActionOverride("__DV__",MakeGlobal())
		   MoveGlobalObject("__DV__",Myself)
		   Wait(1)
		   SetGlobal("EJRevSpell__INDEX__","GLOBAL",2)
		   SetGlobal("EJRejoinPending__INDEX__","GLOBAL",1)
		   CreateCreatureObject("EJRJN__INDEX__",Myself,0,0,0)
		   DestroySelf()
		~
		EXIT
END
