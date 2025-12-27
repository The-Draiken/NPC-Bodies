Original Author: [Gunman]((https://forums.beamdog.com/profile/gunman))

Fixed by: [Enigmajazz]((https://www.gibberlings3.net/profile/12873-enigmajazz/))

## Disclaimer
his is a Mod Created by Gunman back in 2016, I had asked Enigmajazz to fix a bunch of Issues with the mod after he sorted out fixing Temnix Animate Dead Now Mod for me personally, 
he coudn't solve all the Issues but did solve Most and then I used ChatGPT (as I've been using it to Mod BG3 code for me recently) to fix up the rest of the Mod. All credit though goes to Enigmajazz for doing this for me and Gunman for originally coming up with the Mod.

## Overview
Okay, so what this mod does is can obviousl be found on the original Page [here](https://forums.beamdog.com/discussion/61786/npc-bodies-a-raise-dead-resurrection-mod) but I'll still go over it and the changes we applied.

First off any party Member that Dies whether base game party member or Mod added Companion will drop a Body with a weight dependent on thier Race and Sex. 
This Body is required to bring an Individual back to life, additionally Enigmajazz has included components that add time limits and the Spell revivify.
So on death the associated party has 1 turn to bring the Party Member back with Revivify or the spell will no longer work

Additionally Raise Dead also requires a Body still to raise te Party Member, Enigmajazz gets all the credit for this though I decided the time limit for raise Dead should be
two ingame days, if not the Body will decay and require a Resurrection spell to bring the Party Member Back.

This is where my or I should say the AI stepped in, The Con Penalty Component works as such, Revivify Applies no Con Penalty.
Raise Dead will Apply a Con penalty to the Raise Individual that cannot be reveresed (besides whatever Con Buffs you find through the Games).
Resurrection then applies a Con penalty to both the person being raised and the Person Casting the Spell. (I got the idea of this from UB Jaheira Line about Khalid)

Note:Enigmajazz was the one who made it compatible with any companion Mod then Ijust sorted out the capacity issue from installing Mods like Vampire World, so you can have as many Companion Mods as you want installed along this one.

Lastly there is a Mod to the Raise dead and Resurrection Prices Progressive in value, starting at 1000 Gold for Level 1 Party Members
and increasing by 1000 Gold for every Subsequent Level, so a Party member that is level 10 will cose 10k Gold to raise at a temple or whatever
higher to resurrect, though no Con penalty to any alive party memeber as the Temple priest will be hanldling it.

## Installation and Compatibility
 This Mod must be Installed after any Mod that adds a Companion to the Game, It is Recommended to be installed alongside the
  Revised handling of death effects like disintegration, petrification and imprisonment (party members who are disintegrated etc can be resurrected; imprisoned or petrified characters rejoin the party automatically; the game doesn't end if the main character is petrified or imprisoned)
  of SCS to make the experience of handling death more comprehensive but should be installd AFTER that component.

  Additionally if Installing Spell Revisions, makesure to not install any raise Dead, resurrections , Recall Spirit or any spells
  that revive a individual.
  To do so you need to enter the main_component.tpa inspell_rev\components and add  /* ... */ to the spells in question as such, eg;

/* COPY ~spell_rev\spwi5##\sppr504.spl~     ~override~  //Raise Dead
  SAY NAME1 @639    SAY UNIDENTIFIED_DESC @158
COPY ~spell_rev\spwi5##\scrl63.itmm~     ~override~
  SAY NAME2 @639    SAY IDENTIFIED_DESC   @158 */

  I stress this as I did thorough testing with this Mod and SR versions of those spells can cause this mod to bug out, so
  even check the Override after manually I would suggest, just to makesure.
  

