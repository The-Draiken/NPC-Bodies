// Temple Resurrection Dialogue Extension
// This file adds new states to priest DLG files for the resurrection service.
// It handles the first 15 joinable NPCs from the NPC Bodies mod.
// Additional NPCs can be added by extending this file.
//
// The dialogue flow:
// 1. Player talks to priest -> priest detects body items (WEIGHT -1 entry state)
// 2. If non-decayed body found -> Raise Dead option (level x 1000 gp)
// 3. If decayed body found -> Resurrection option (10,000 gp)
// 4. Priest takes body and gold, spawns NPC
// 5. Player talks to NPC to rejoin
//
// NOTE: This file is loaded via EXTEND_BOTTOM in the TP2.
// Do NOT use APPEND/END - EXTEND_BOTTOM handles the appending.

// Entry state - priest detects body items
// WEIGHT -1 ensures this state is evaluated before the priest's normal state 0
IF WEIGHT -1 ~OR(30)
  PartyHasItem("EJB1a") PartyHasItem("EJB1b")
  PartyHasItem("EJB2a") PartyHasItem("EJB2b")
  PartyHasItem("EJB3a") PartyHasItem("EJB3b")
  PartyHasItem("EJB4a") PartyHasItem("EJB4b")
  PartyHasItem("EJB5a") PartyHasItem("EJB5b")
  PartyHasItem("EJB6a") PartyHasItem("EJB6b")
  PartyHasItem("EJB7a") PartyHasItem("EJB7b")
  PartyHasItem("EJB8a") PartyHasItem("EJB8b")
  PartyHasItem("EJB9a") PartyHasItem("EJB9b")
  PartyHasItem("EJB10a") PartyHasItem("EJB10b")
  PartyHasItem("EJB11a") PartyHasItem("EJB11b")
  PartyHasItem("EJB12a") PartyHasItem("EJB12b")
  PartyHasItem("EJB13a") PartyHasItem("EJB13b")
  PartyHasItem("EJB14a") PartyHasItem("EJB14b")
  PartyHasItem("EJB15a") PartyHasItem("EJB15b")
~ THEN BEGIN ejtemple_detect
  SAY @601
  IF ~PartyHasItem("EJB1a")~ THEN REPLY @602 GOTO ejtemple_raise1
  IF ~PartyHasItem("EJB2a")~ THEN REPLY @602 GOTO ejtemple_raise2
  IF ~PartyHasItem("EJB3a")~ THEN REPLY @602 GOTO ejtemple_raise3
  IF ~PartyHasItem("EJB4a")~ THEN REPLY @602 GOTO ejtemple_raise4
  IF ~PartyHasItem("EJB5a")~ THEN REPLY @602 GOTO ejtemple_raise5
  IF ~PartyHasItem("EJB6a")~ THEN REPLY @602 GOTO ejtemple_raise6
  IF ~PartyHasItem("EJB7a")~ THEN REPLY @602 GOTO ejtemple_raise7
  IF ~PartyHasItem("EJB8a")~ THEN REPLY @602 GOTO ejtemple_raise8
  IF ~PartyHasItem("EJB9a")~ THEN REPLY @602 GOTO ejtemple_raise9
  IF ~PartyHasItem("EJB10a")~ THEN REPLY @602 GOTO ejtemple_raise10
  IF ~PartyHasItem("EJB11a")~ THEN REPLY @602 GOTO ejtemple_raise11
  IF ~PartyHasItem("EJB12a")~ THEN REPLY @602 GOTO ejtemple_raise12
  IF ~PartyHasItem("EJB13a")~ THEN REPLY @602 GOTO ejtemple_raise13
  IF ~PartyHasItem("EJB14a")~ THEN REPLY @602 GOTO ejtemple_raise14
  IF ~PartyHasItem("EJB15a")~ THEN REPLY @602 GOTO ejtemple_raise15
  IF ~PartyHasItem("EJB1b")~ THEN REPLY @605 GOTO ejtemple_resurrect1
  IF ~PartyHasItem("EJB2b")~ THEN REPLY @605 GOTO ejtemple_resurrect2
  IF ~PartyHasItem("EJB3b")~ THEN REPLY @605 GOTO ejtemple_resurrect3
  IF ~PartyHasItem("EJB4b")~ THEN REPLY @605 GOTO ejtemple_resurrect4
  IF ~PartyHasItem("EJB5b")~ THEN REPLY @605 GOTO ejtemple_resurrect5
  IF ~PartyHasItem("EJB6b")~ THEN REPLY @605 GOTO ejtemple_resurrect6
  IF ~PartyHasItem("EJB7b")~ THEN REPLY @605 GOTO ejtemple_resurrect7
  IF ~PartyHasItem("EJB8b")~ THEN REPLY @605 GOTO ejtemple_resurrect8
  IF ~PartyHasItem("EJB9b")~ THEN REPLY @605 GOTO ejtemple_resurrect9
  IF ~PartyHasItem("EJB10b")~ THEN REPLY @605 GOTO ejtemple_resurrect10
  IF ~PartyHasItem("EJB11b")~ THEN REPLY @605 GOTO ejtemple_resurrect11
  IF ~PartyHasItem("EJB12b")~ THEN REPLY @605 GOTO ejtemple_resurrect12
  IF ~PartyHasItem("EJB13b")~ THEN REPLY @605 GOTO ejtemple_resurrect13
  IF ~PartyHasItem("EJB14b")~ THEN REPLY @605 GOTO ejtemple_resurrect14
  IF ~PartyHasItem("EJB15b")~ THEN REPLY @605 GOTO ejtemple_resurrect15
  IF ~~ THEN REPLY @609 EXIT
END

// Raise Dead path - for non-decayed bodies (level x 1000gp, min 1000)
IF ~PartyHasItem("EJB1a")~ THEN BEGIN ejtemple_raise1
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB1a")
    DestroyItem("EJB1a")
    TakePartyGold(1000)
    SetGlobal("EJdead1","GLOBAL",0)
    CreateCreatureObject("IMOEN","imoen",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB2a")~ THEN BEGIN ejtemple_raise2
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB2a")
    DestroyItem("EJB2a")
    TakePartyGold(1000)
    SetGlobal("EJdead2","GLOBAL",0)
    CreateCreatureObject("AJANTIS","ajantis",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB3a")~ THEN BEGIN ejtemple_raise3
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB3a")
    DestroyItem("EJB3a")
    TakePartyGold(1000)
    SetGlobal("EJdead3","GLOBAL",0)
    CreateCreatureObject("ALORA","alora",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB4a")~ THEN BEGIN ejtemple_raise4
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB4a")
    DestroyItem("EJB4a")
    TakePartyGold(1000)
    SetGlobal("EJdead4","GLOBAL",0)
    CreateCreatureObject("BRANWEN","branwen",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB5a")~ THEN BEGIN ejtemple_raise5
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB5a")
    DestroyItem("EJB5a")
    TakePartyGold(1000)
    SetGlobal("EJdead5","GLOBAL",0)
    CreateCreatureObject("CORAN","coran",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB6a")~ THEN BEGIN ejtemple_raise6
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB6a")
    DestroyItem("EJB6a")
    TakePartyGold(1000)
    SetGlobal("EJdead6","GLOBAL",0)
    CreateCreatureObject("DORN","dorn",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB7a")~ THEN BEGIN ejtemple_raise7
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB7a")
    DestroyItem("EJB7a")
    TakePartyGold(1000)
    SetGlobal("EJdead7","GLOBAL",0)
    CreateCreatureObject("DYNAHEIR","dynaheir",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB8a")~ THEN BEGIN ejtemple_raise8
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB8a")
    DestroyItem("EJB8a")
    TakePartyGold(1000)
    SetGlobal("EJdead8","GLOBAL",0)
    CreateCreatureObject("EDWIN","edwin",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB9a")~ THEN BEGIN ejtemple_raise9
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB9a")
    DestroyItem("EJB9a")
    TakePartyGold(1000)
    SetGlobal("EJdead9","GLOBAL",0)
    CreateCreatureObject("ELDOTH","eldoth",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB10a")~ THEN BEGIN ejtemple_raise10
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB10a")
    DestroyItem("EJB10a")
    TakePartyGold(1000)
    SetGlobal("EJdead10","GLOBAL",0)
    CreateCreatureObject("FALDORN","faldorn",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB11a")~ THEN BEGIN ejtemple_raise11
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB11a")
    DestroyItem("EJB11a")
    TakePartyGold(1000)
    SetGlobal("EJdead11","GLOBAL",0)
    CreateCreatureObject("GARRICK","garrick",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB12a")~ THEN BEGIN ejtemple_raise12
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB12a")
    DestroyItem("EJB12a")
    TakePartyGold(1000)
    SetGlobal("EJdead12","GLOBAL",0)
    CreateCreatureObject("IMOEN2","imoen2",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB13a")~ THEN BEGIN ejtemple_raise13
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB13a")
    DestroyItem("EJB13a")
    TakePartyGold(1000)
    SetGlobal("EJdead13","GLOBAL",0)
    CreateCreatureObject("JAHEIRA","jaheira",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB14a")~ THEN BEGIN ejtemple_raise14
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB14a")
    DestroyItem("EJB14a")
    TakePartyGold(1000)
    SetGlobal("EJdead14","GLOBAL",0)
    CreateCreatureObject("KAGAIN","kagain",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB15a")~ THEN BEGIN ejtemple_raise15
  SAY @602
  IF ~PartyGoldGT(999)~ THEN REPLY @601 DO ~
    TakePartyItem("EJB15a")
    DestroyItem("EJB15a")
    TakePartyGold(1000)
    SetGlobal("EJdead15","GLOBAL",0)
    CreateCreatureObject("KHALID","khalid",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

// Resurrection path - for decayed bodies (10,000gp)
IF ~PartyHasItem("EJB1b")~ THEN BEGIN ejtemple_resurrect1
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB1b")
    DestroyItem("EJB1b")
    TakePartyGold(10000)
    SetGlobal("EJdead1","GLOBAL",0)
    CreateCreatureObject("IMOEN","imoen",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB2b")~ THEN BEGIN ejtemple_resurrect2
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB2b")
    DestroyItem("EJB2b")
    TakePartyGold(10000)
    SetGlobal("EJdead2","GLOBAL",0)
    CreateCreatureObject("AJANTIS","ajantis",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB3b")~ THEN BEGIN ejtemple_resurrect3
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB3b")
    DestroyItem("EJB3b")
    TakePartyGold(10000)
    SetGlobal("EJdead3","GLOBAL",0)
    CreateCreatureObject("ALORA","alora",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB4b")~ THEN BEGIN ejtemple_resurrect4
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB4b")
    DestroyItem("EJB4b")
    TakePartyGold(10000)
    SetGlobal("EJdead4","GLOBAL",0)
    CreateCreatureObject("BRANWEN","branwen",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB5b")~ THEN BEGIN ejtemple_resurrect5
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB5b")
    DestroyItem("EJB5b")
    TakePartyGold(10000)
    SetGlobal("EJdead5","GLOBAL",0)
    CreateCreatureObject("CORAN","coran",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB6b")~ THEN BEGIN ejtemple_resurrect6
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB6b")
    DestroyItem("EJB6b")
    TakePartyGold(10000)
    SetGlobal("EJdead6","GLOBAL",0)
    CreateCreatureObject("DORN","dorn",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB7b")~ THEN BEGIN ejtemple_resurrect7
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB7b")
    DestroyItem("EJB7b")
    TakePartyGold(10000)
    SetGlobal("EJdead7","GLOBAL",0)
    CreateCreatureObject("DYNAHEIR","dynaheir",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB8b")~ THEN BEGIN ejtemple_resurrect8
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB8b")
    DestroyItem("EJB8b")
    TakePartyGold(10000)
    SetGlobal("EJdead8","GLOBAL",0)
    CreateCreatureObject("EDWIN","edwin",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB9b")~ THEN BEGIN ejtemple_resurrect9
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB9b")
    DestroyItem("EJB9b")
    TakePartyGold(10000)
    SetGlobal("EJdead9","GLOBAL",0)
    CreateCreatureObject("ELDOTH","eldoth",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB10b")~ THEN BEGIN ejtemple_resurrect10
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB10b")
    DestroyItem("EJB10b")
    TakePartyGold(10000)
    SetGlobal("EJdead10","GLOBAL",0)
    CreateCreatureObject("FALDORN","faldorn",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB11b")~ THEN BEGIN ejtemple_resurrect11
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB11b")
    DestroyItem("EJB11b")
    TakePartyGold(10000)
    SetGlobal("EJdead11","GLOBAL",0)
    CreateCreatureObject("GARRICK","garrick",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB12b")~ THEN BEGIN ejtemple_resurrect12
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB12b")
    DestroyItem("EJB12b")
    TakePartyGold(10000)
    SetGlobal("EJdead12","GLOBAL",0)
    CreateCreatureObject("IMOEN2","imoen2",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB13b")~ THEN BEGIN ejtemple_resurrect13
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB13b")
    DestroyItem("EJB13b")
    TakePartyGold(10000)
    SetGlobal("EJdead13","GLOBAL",0)
    CreateCreatureObject("JAHEIRA","jaheira",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB14b")~ THEN BEGIN ejtemple_resurrect14
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB14b")
    DestroyItem("EJB14b")
    TakePartyGold(10000)
    SetGlobal("EJdead14","GLOBAL",0)
    CreateCreatureObject("KAGAIN","kagain",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

IF ~PartyHasItem("EJB15b")~ THEN BEGIN ejtemple_resurrect15
  SAY @605
  IF ~PartyGoldGT(9999)~ THEN REPLY @602 DO ~
    TakePartyItem("EJB15b")
    DestroyItem("EJB15b")
    TakePartyGold(10000)
    SetGlobal("EJdead15","GLOBAL",0)
    CreateCreatureObject("KHALID","khalid",0,0,0)
  ~ GOTO ejtemple_done
  IF ~~ THEN REPLY @607 GOTO ejtemple_no_gold
END

// Resurrection complete
IF ~~ THEN BEGIN ejtemple_done
  SAY @608
  IF ~~ THEN EXIT
END

// Cannot afford
IF ~~ THEN BEGIN ejtemple_no_gold
  SAY @607
  IF ~~ THEN EXIT
END
