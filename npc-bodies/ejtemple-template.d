IF ~PartyHasItem("EJB%%INDEX%%a") Global("EJTEMPLE%%INDEX%%","GLOBAL",0)~ THEN BEGIN EJTP_%%INDEX%%_NA
  SAY @601
  RESPONSE #100
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",1)
END
IF ~PartyHasItem("EJB%%INDEX%%b") Global("EJTEMPLE%%INDEX%%","GLOBAL",0)~ THEN BEGIN EJTP_%%INDEX%%_DA
  SAY @605
  RESPONSE #100
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",2)
END
IF ~Global("EJTEMPLE%%INDEX%%","GLOBAL",1) PartyGoldGT(4999)~ THEN BEGIN EJTP_%%INDEX%%_PRD
  SAY @607
  RESPONSE #100
    TakePartyGold(5000)
    TakePartyItem("EJB%%INDEX%%a")
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",3)
END
IF ~Global("EJTEMPLE%%INDEX%%","GLOBAL",1) !PartyGoldGT(4999)~ THEN BEGIN EJTP_%%INDEX%%_NRD
  SAY @607
  RESPONSE #100
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",0)
END
IF ~Global("EJTEMPLE%%INDEX%%","GLOBAL",2) PartyGoldGT(9999)~ THEN BEGIN EJTP_%%INDEX%%_PRZ
  SAY @610
  RESPONSE #100
    TakePartyGold(10000)
    TakePartyItem("EJB%%INDEX%%b")
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",4)
END
IF ~Global("EJTEMPLE%%INDEX%%","GLOBAL",2) !PartyGoldGT(9999)~ THEN BEGIN EJTP_%%INDEX%%_NRZ
  SAY @610
  RESPONSE #100
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",0)
END
IF ~Global("EJTEMPLE%%INDEX%%","GLOBAL",3)~ THEN BEGIN EJTP_%%INDEX%%_DRD
  SAY @608
  RESPONSE #100
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",0)
    CreateCreatureObject("EJdro%%INDEX%%",0,0,0)
    ActionOverride("EJdro%%INDEX%%",DestroySelf())
END
IF ~Global("EJTEMPLE%%INDEX%%","GLOBAL",4)~ THEN BEGIN EJTP_%%INDEX%%_DRZ
  SAY @606
  RESPONSE #100
    SetGlobal("EJTEMPLE%%INDEX%%","GLOBAL",0)
    CreateCreatureObject("EJdro%%INDEX%%",0,0,0)
    ActionOverride("EJdro%%INDEX%%",DestroySelf())
END
