Scriptname Fallout:Skills:Data:Blade extends Fallout:Skills:Client
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
	skill.Name = "Blade"
	skill.Description = "Using bladed weapons in melee combat such as knives and sharpened tools."
	return skill
EndFunction


; Experience
;---------------------------------------------
