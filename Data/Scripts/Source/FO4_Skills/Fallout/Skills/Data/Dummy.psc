Scriptname Fallout:Skills:Data:Dummy Extends Fallout:Skills:Client
import Fallout:Skills
import Papyrus:Log


UserLog Log


; Custom Skill
;---------------------------------------------

Function OnInitialize()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Context.Title
EndFunction


Client:CustomSkill Function Create(CustomSkill skill)
	WriteLine(Log, "Create")
	skill.Name = "Dummy"
	skill.Description = "The dummys skill in sitting upon furniture, the ground, and all things."
	skill.Level = 7
	skill.Experience = 104
	return skill
EndFunction


Function OnSystemStartup()
	RegisterForRemoteEvent(Player, "OnSit")
EndFunction


Function OnSystemReset()
EndFunction


Function OnSystemShutdown()
	UnregisterForRemoteEvent(Player, "OnSit")
EndFunction


; Experience
;---------------------------------------------

Event Actor.OnSit(Actor akSender, ObjectReference akFurniture)
	; you have popped a squat
	AdvanceSkill(100)
EndEvent
