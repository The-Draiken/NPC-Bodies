EXTEND_BOTTOM ~__PRIEST__~ 0
  IF ~__BODY_CHECK_A__ PartyGoldGT(4999)~ THEN REPLY @601
    DO ~TakePartyGold(5000)
       __TAKE_A__
    ~
    EXIT
  IF ~__BODY_CHECK_B__ PartyGoldGT(9999)~ THEN REPLY @602
    DO ~TakePartyGold(10000)
       __TAKE_B__
    ~
    EXIT
END
