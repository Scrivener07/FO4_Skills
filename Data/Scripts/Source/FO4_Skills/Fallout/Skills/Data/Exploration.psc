Scriptname Fallout:Skills:Data:Exploration extends Fallout:Skills:Client
import Fallout:Skills
import Fallout:Skills:Context
import Papyrus:Log
; http://www.creationkit.com/fallout4/index.php?title=OnLocationChange_-_Actor
; http://www.creationkit.com/fallout4/index.php?title=List_Of_Tracked_Stats


UserLog Log
string StatDiscovered = "Locations Discovered" const
string StatCleared = "Dungeons Cleared" const




; Custom Skill
;---------------------------------------------

Function OnInitialize()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Context.Title
EndFunction


Client:CustomSkill Function Create(CustomSkill skill)
	WriteLine(Log, "Create")
	skill.Name = "Exploration"
	skill.Description = "Your skill in exploration and discovery."
	return skill
EndFunction


Function OnSystemStartup()
	WriteLine(Log, "OnSystemStartup")
	RegisterForTrackedStatsEvent(StatDiscovered, 0)
	RegisterForTrackedStatsEvent(StatCleared, 0)
EndFunction


Function OnSystemShutdown()
	WriteLine(Log, "OnSystemShutdown")
	UnregisterForTrackedStatsEvent(StatDiscovered)
	UnregisterForTrackedStatsEvent(StatCleared)
EndFunction




; Experience
;---------------------------------------------

Event Actor.OnLocationChange(Actor akSender, Location akOldLoc, Location akNewLoc)
	; exp for returning to certain locations?
EndEvent


Event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)
	If (asStatFilter == StatDiscovered)
		WriteLine(Log, "Player has discovered " + aiStatValue + " locations.")
		int reward = GetExperience(aiStatValue, 100, 0.5)
		AdvanceSkill(reward)
	ElseIf (asStatFilter == StatCleared)
		WriteLine(Log, "Player has cleared " + aiStatValue + " locations.")
		int reward = GetExperience(aiStatValue, 500, 1.25)
		AdvanceSkill(reward)
	Else
		return
	Endif
	aiStatValue +=1
	RegisterForTrackedStatsEvent(asStatFilter, aiStatValue)
EndEvent


int Function GetExperience(int locations, int value, float multi)
	return Math.Floor(value + (locations * multi))
EndFunction
