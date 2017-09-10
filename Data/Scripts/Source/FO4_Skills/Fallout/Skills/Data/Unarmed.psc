Scriptname Fallout:Skills:Data:Unarmed Extends Fallout:Skills:Client
import Fallout:Skills
import Papyrus:Diagnostics:Log


UserLog Log

string EmptyState = "" const
string UnarmedState = "UnarmedState" const

int AwardAmountMinor = 5 const
int AwardAmountModerate = 25 const
int AwardAmountMajor = 50 const

Weapon CurrentItem = none

Group Keywords
	Keyword Property WeaponTypeUnarmed Auto Const Mandatory
	Keyword Property WeaponTypeHandToHand Auto Const Mandatory
EndGroup


; Custom Skill
;---------------------------------------------

Function OnInitialize()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Context.Title
	CurrentItem = none
EndFunction


Client:CustomSkill Function Create(CustomSkill skill)
	WriteLine(Log, "Create")
	skill.Name = "Hand to Hand"
	skill.Description = "Combat with your hands and feet. This includes the unarmed martial arts, boxing, wrestling, and other hand-to-hand combat."
	return skill
EndFunction


Function OnSystemStartup()
	WriteLine(Log, "OnSystemStartup")
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnPlayerFireWeapon")
	RegisterForRemoteEvent(Player, "OnRaceSwitchComplete")

	; are we already "unarmed" ?

	RegisterAnimations()
EndFunction


Function OnSystemShutdown()
	WriteLine(Log, "OnSystemShutdown")
	UnregisterForAllRemoteEvents()
	UnregisterAnimations()
EndFunction


; Experience
;---------------------------------------------

Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject is Weapon)
		If (HasFilter(akBaseObject))
			GotoState(UnarmedState)
		Else
			GotoState(EmptyState)
		EndIf
	EndIf
EndEvent


Event Actor.OnPlayerFireWeapon(Actor akSender, Form akBaseObject)
	If (akBaseObject is Weapon)
		If (HasFilter(akBaseObject))
			AdvanceSkill(AwardAmountMinor)
		EndIf
	EndIf
EndEvent


State UnarmedState
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		WriteNotification(Log, "We got the " + asEventName + " animation event from " + akSource)

		If (asEventName == AnimMeleeAttackStart)
			WriteLine(Log, "I swing my fist!")
			AdvanceSkill(AwardAmountMinor)

		ElseIf (asEventName == AnimMeleeAttackStartPower)
			WriteLine(Log, "I swing my fist VERY hard!")
			AdvanceSkill(AwardAmountMajor)

		Else
			WriteLine(Log, "Undefined animation event received for " + asEventName)
		EndIf
	EndEvent
EndState


Event Actor.OnRaceSwitchComplete(Actor akSender)
	RegisterAnimations()
EndEvent

Event OnAnimationEventUnregistered(ObjectReference akSource, string asEventName)
	WriteLine(Log, "We got unregistered for the "+asEventName+"'s event from "+akSource+". Re-registering for "+asEventName)
	RegisterForAnimationEvent(Player, asEventName)
EndEvent


; Filter
;---------------------------------------------

bool Function HasFilter(Form akBaseObject)
	If (akBaseObject.HasKeyword(WeaponTypeUnarmed))
		WriteLine(Log, "Form has keyword " + WeaponTypeUnarmed)
		return true
	ElseIf (akBaseObject.HasKeyword(WeaponTypeHandToHand))
		WriteLine(Log, "Form has keyword " + WeaponTypeHandToHand)
		return true
	Else
		return false
	EndIf
EndFunction


; Animations
;---------------------------------------------

Function RegisterAnimations()
	RegisterForAnimationEvent(Player, AnimMeleeAttackBackStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackBashStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackBayonet)
	RegisterForAnimationEvent(Player, AnimMeleeAttackBehindStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackForwardStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackGun)
	RegisterForAnimationEvent(Player, AnimMeleeAttackGunSynth)
	RegisterForAnimationEvent(Player, AnimMeleeAttackLeftStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackParalyzingStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerBackStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerForwardShortStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerForwardStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerGun)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerLeftStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerRightStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerSneakStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackPowerStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackRightStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackSneakStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackSprintStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackStart)
	RegisterForAnimationEvent(Player, AnimMeleeAttackStartPower)
	RegisterForAnimationEvent(Player, AnimMeleeAttackStartStagger)
	RegisterForAnimationEvent(Player, AnimMeleeAttackBaseState)
EndFunction


Function UnregisterAnimations()
	UnregisterForAnimationEvent(Player, AnimMeleeAttackBackStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackBashStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackBayonet)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackBehindStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackForwardStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackGun)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackGunSynth)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackLeftStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackParalyzingStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerBackStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerForwardShortStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerForwardStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerGun)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerLeftStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerRightStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerSneakStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackPowerStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackRightStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackSneakStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackSprintStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackStart)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackStartPower)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackStartStagger)
	UnregisterForAnimationEvent(Player, AnimMeleeAttackBaseState)
EndFunction


; H2H Animation Events
string AnimMeleeAttackBackStart = "meleeattackBackStart" Const
string AnimMeleeAttackBashStart = "meleeAttackBashStart" Const
string AnimMeleeAttackBayonet = "meleeAttackBayonet" Const
string AnimMeleeAttackBehindStart = "meleeattackBehindStart" Const
string AnimMeleeAttackForwardStart = "meleeattackForwardStart" Const
string AnimMeleeAttackGun = "meleeAttackGun" Const
string AnimMeleeAttackGunSynth = "meleeAttackGunSynth" Const
string AnimMeleeAttackLeftStart = "meleeattackLeftStart" Const
string AnimMeleeAttackParalyzingStart = "meleeattackParalyzingStart" Const
string AnimMeleeAttackPowerBackStart = "meleeattackPowerBackStart" Const
string AnimMeleeAttackPowerForwardShortStart = "meleeAttackPowerForwardShortStart" Const
string AnimMeleeAttackPowerForwardStart = "meleeAttackPowerForwardStart" Const
string AnimMeleeAttackPowerGun = "meleeAttackPowerGun" Const
string AnimMeleeAttackPowerLeftStart = "meleeattackPowerLeftStart" Const
string AnimMeleeAttackPowerRightStart = "meleeattackPowerRightStart" Const
string AnimMeleeAttackPowerSneakStart = "meleeattackPowerSneakStart" Const
string AnimMeleeAttackPowerStart = "meleeattackPowerStart" Const
string AnimMeleeAttackRightStart = "meleeattackRightStart" Const
string AnimMeleeAttackSneakStart = "meleeattackSneakStart" Const
string AnimMeleeAttackSprintStart = "meleeattackSprintStart" Const
string AnimMeleeAttackStart = "meleeattackStart" Const
string AnimMeleeAttackStartPower = "meleeattackStartPower" Const
string AnimMeleeAttackStartStagger = "meleeAttackStartStagger" Const
string AnimMeleeAttackBaseState = "MeleeBaseState to BerserkEnter.hkt" Const
