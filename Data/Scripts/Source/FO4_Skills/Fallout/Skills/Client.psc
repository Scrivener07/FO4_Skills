Scriptname Fallout:Skills:Client extends Quest Hidden
import Fallout
import Papyrus:Diagnostics:Log
import Papyrus:StringType

UserLog Log
CustomSkill Skill

Actor PlayerReference = none
bool Registered = false
string NameDefault = "I_Forgot_To_Set_My_Skill_Name" const
string DescriptionDefault = "I_Forgot_To_Set_My_Skill_Description" const


; Methods
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Context.Title

	Registered = false
	PlayerReference = Game.GetPlayer()

	OnInitialize()

	CustomSkill custom = Create(new CustomSkill)
	If (custom)
		If (StringIsNoneOrEmpty(custom.Name))
			WriteLine(Log, "The skill name cannot be none or empty.")
			custom.Name = NameDefault
		EndIf
		If (StringIsNoneOrEmpty(custom.Description))
			WriteLine(Log, "The skill description cannot be none or empty.")
			custom.Description = DescriptionDefault
		EndIf

		If (custom.Level < 1)
			custom.Level = 1
		EndIf
		If (custom.Experience < 0)
			custom.Experience = 0
		EndIf

		Skill = custom
	Else
		WriteLine(Log, "The custom skill provided was none.")
	EndIf

	RegisterForCustomEvent(System, "ReadyEvent")
	RegisterForCustomEvent(System, "ResetEvent")
	RegisterForCustomEvent(System, "ShutdownEvent")
EndEvent


; System Event
;---------------------------------------------

Event Fallout:Skills:System.ReadyEvent(Skills:System akSender, var[] arguments)
	If (akSender.Register(self))
		WriteLine(Log, "The client registered on the skill system.")
		Registered = true
		AdvanceSkill(0)
		OnSystemStartup()
	Else
		WriteLine(Log, "The client could not register on the skill system.")
	EndIf
EndEvent


Event Fallout:Skills:System.ResetEvent(Skills:System akSender, var[] arguments)
	WriteLine(Log, "The client is resetting.")
	OnSystemReset()
EndEvent


Event Fallout:Skills:System.ShutdownEvent(Skills:System akSender, var[] arguments)
	WriteLine(Log, "The client is shutting down.")
	UnregisterForCustomEvent(akSender, "ReadyEvent")
	Registered = !akSender.Unregister(self)
	OnSystemShutdown()
EndEvent


; Skill
;---------------------------------------------

Function AdvanceSkill(int aiExperience)
	aiExperience = Math.ABS(aiExperience) as int
	int iRequiredTotal = GetRequiredCost(Skill.Level, Skill.Experience)

	If (Skill.Experience >= iRequiredTotal) ; has met or exceeded exp required
		Skill.Level += 1
		Skill.Experience += iRequiredTotal - Skill.Experience
		WriteNotification(Log, Skill.Name+" has increased to level "+Skill.Level)
	Else
		Skill.Experience += aiExperience
		WriteNotification(Log, Skill.Name+" gained +"+aiExperience+" experience ("+Skill.Experience+"/"+iRequiredTotal+").")
	EndIf
EndFunction


;____________________________
; 	level 	|	Level Cost 	|
; 	1 		|	200 		|
; 	2		|	275			|
; 	3		|	350			|
; 	4		|	425			|
; 	5		|	500			|
int Function GetLevelCost(int aiLevel) Global
	int iExp = 200 const
	int iExpIncrement = 75 const
	int iLevel = aiLevel - 1 const
	return (iLevel * iExpIncrement) + iExp
EndFunction


int Function GetRequiredCost(int aiLevel, int aiExperience) Global
	return GetLevelCost(aiLevel) - aiExperience
EndFunction


; Implementation
;---------------------------------------------
; The following methods are intended to be overridden in an extending script.
; You must at least implement the Create method and return a valid CustomSkill.
; These functions use event notation but are not true events

Function OnInitialize()
	WriteLine(Log, "The client has not implemented the optional OnInitialize method.")
	; override this function instead on using the OnInit event.
EndFunction


CustomSkill Function Create(CustomSkill aSkill)
	WriteLine(Log, "The client has not implemented the required Create method.")
	return none
EndFunction


Function OnSystemStartup()
	WriteLine(Log, "The client has not implemented the optional OnSystemStartup method.")
EndFunction


Function OnSystemReset()
	WriteLine(Log, "The client has not implemented the optional OnSystemReset method.")
EndFunction


Function OnSystemShutdown()
	WriteLine(Log, "The client has not implemented the optional OnSystemShutdown method.")
EndFunction


; Properties
;---------------------------------------------

Struct CustomSkill
	string Name
	string Description
	int Level = 1
	int Experience = 0
EndStruct


; Group NotImplemented
; 	Message Property NameText Auto Const Mandatory
; 	Message Property DescriptionText Auto Const Mandatory
; EndGroup



Group Properties
	Skills:Context Property Context Auto Const Mandatory
	Skills:System Property System Auto Const Mandatory

	bool Property IsRegistered Hidden
		bool Function Get()
			return Registered
		EndFunction
	EndProperty

	Actor Property Player Hidden
		Actor Function Get()
			return PlayerReference
		EndFunction
	EndProperty

	string Property Name Hidden
		string Function Get()
			return Skill.Name
		EndFunction
	EndProperty

	string Property Description Hidden
		string Function Get()
			return Skill.Description
		EndFunction
	EndProperty

	int Property Level Hidden
		int Function Get()
			return Skill.Level
		EndFunction
	EndProperty

	int Property Experience Hidden
		int Function Get()
			return Skill.Experience
		EndFunction
	EndProperty
EndGroup
