Scriptname Fallout:Skills:Data:Blunt extends Fallout:Skills:Client
import Fallout:Skills
import Papyrus:Diagnostics:Log

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
	skill.Name = "Blunt"
	skill.Description = "Using blunted weapons in melee combat such as crowbars, hammers, pipes, clubs and so on."
	return skill
EndFunction

; Experience
;---------------------------------------------
