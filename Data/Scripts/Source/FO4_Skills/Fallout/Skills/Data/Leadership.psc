Scriptname Fallout:Skills:Data:Leadership extends Fallout:Skills:Client
import Fallout:Skills
import Papyrus:Log


UserLog Log
int ExperienceMinor = 5 const
int ExperienceModerate = 25 const
int ExperienceMajor = 50 const

Group Followers
	; Quest: Followers
	ReferenceAlias Property Companion Auto Const
	ReferenceAlias Property DogmeatCompanion Auto Const
EndGroup

Group Commands
	int Property CommandNone = 0 Auto Const Hidden
	int Property CommandCall = 1 Auto Const Hidden
	int Property CommandFollow = 2 Auto Const Hidden
	int Property CommandMove = 3 Auto Const Hidden
	int Property CommandAttack = 4 Auto Const Hidden
	int Property CommandInspect = 5 Auto Const Hidden
	int Property CommandRetrieve = 6 Auto Const Hidden
	int Property CommandStay = 7 Auto Const Hidden
	int Property CommandRelease = 8 Auto Const Hidden
	int Property CommandHeal = 9 Auto Const Hidden
	int Property CommandWorkshopAssign = 10 Auto Const Hidden
	int Property CommandRideVertibird = 11 Auto Const Hidden
	int Property CommandEnterPowerArmor = 12 Auto Const Hidden
EndGroup


; Custom Skill
;---------------------------------------------

Function OnInitialize()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Context.Title
EndFunction


Client:CustomSkill Function Create(CustomSkill skill)
	WriteLine(Log, "Create")
	skill.Name = "Leadership"
	skill.Description = "Your ability to command followers and companions."
	return skill
EndFunction


Function OnSystemStartup()
	WriteLine(Log, "OnSystemStartup")
	RegisterForRemoteEvent(Companion, "OnCommandModeGiveCommand")
	RegisterForRemoteEvent(Companion, "OnCommandModeCompleteCommand")
	RegisterForRemoteEvent(DogmeatCompanion, "OnCommandModeGiveCommand")
	RegisterForRemoteEvent(DogmeatCompanion, "OnCommandModeCompleteCommand")
EndFunction


Function OnSystemShutdown()
	WriteLine(Log, "OnSystemShutdown")
	UnregisterForRemoteEvent(Companion, "OnCommandModeGiveCommand")
	UnregisterForRemoteEvent(Companion, "OnCommandModeCompleteCommand")
	UnregisterForRemoteEvent(DogmeatCompanion, "OnCommandModeGiveCommand")
	UnregisterForRemoteEvent(DogmeatCompanion, "OnCommandModeCompleteCommand")
EndFunction


; Experience
;---------------------------------------------

Event ReferenceAlias.OnCommandModeGiveCommand(ReferenceAlias akSender, int aeCommandType, ObjectReference akTarget)
	string commandName = GetCommandName(aeCommandType)

	If (aeCommandType == CommandInspect || \
		aeCommandType == CommandRetrieve || \
		aeCommandType == CommandEnterPowerArmor || \
		aeCommandType == CommandAttack || \
		aeCommandType == CommandHeal || \
		aeCommandType == CommandWorkshopAssign)
		AdvanceSkill(ExperienceMinor)
		WriteNotification(Log, "A follower has completed the " + commandName + " command for " + ExperienceMinor + " experience")
	EndIf
EndEvent


Event ReferenceAlias.OnCommandModeCompleteCommand(ReferenceAlias akSender, int aeCommandType, ObjectReference akTarget)
	string commandName = GetCommandName(aeCommandType)

	If (aeCommandType == CommandInspect || \
		aeCommandType == CommandRetrieve || \
		aeCommandType == CommandEnterPowerArmor)
		AdvanceSkill(ExperienceModerate)
		WriteNotification(Log, "A follower has completed the " + commandName + " command for " + ExperienceMajor + " experience")
	ElseIf (aeCommandType == CommandAttack || \
			aeCommandType == CommandHeal || \
			aeCommandType == CommandWorkshopAssign)
		AdvanceSkill(ExperienceMajor)
		WriteNotification(Log, "A follower has completed the " + commandName + " command.")
	EndIf
EndEvent




string Function GetCommandName(int aiCommandType)
	If (aiCommandType == CommandNone)
		return "None"
	ElseIf (aiCommandType == CommandCall)
		return "Call"
	ElseIf (aiCommandType == CommandFollow)
		return "Follow"
	ElseIf (aiCommandType == CommandMove)
		return "Move"
	ElseIf (aiCommandType == CommandAttack)
		return "Attack"
	ElseIf (aiCommandType == CommandInspect)
		return "Inspect"
	ElseIf (aiCommandType == CommandRetrieve)
		return "Retrieve"
	ElseIf (aiCommandType == CommandStay)
		return "Stay"
	ElseIf (aiCommandType == CommandRelease)
		return "Release"
	ElseIf (aiCommandType == CommandHeal)
		return "Heal"
	ElseIf (aiCommandType == CommandWorkshopAssign)
		return "Workshop Assign"
	ElseIf (aiCommandType == CommandRideVertibird)
		return "Ride Vertibird"
	ElseIf (aiCommandType == CommandEnterPowerArmor)
		return "Enter Power Armor"
	Else
		return "Unknown"
	EndIf
EndFunction
