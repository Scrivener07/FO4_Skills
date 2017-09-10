Scriptname Fallout:Skills:Data:Barter extends Fallout:Skills:Client
import Fallout:Skills
import Papyrus:Diagnostics:Log
; http://www.creationkit.com/fallout4/index.php?title=OnSell_-_ObjectReference
; http://www.creationkit.com/fallout4/index.php?title=OnPlayerDialogueTarget_-_ObjectReference


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
	skill.Name = "Barter"
	skill.Description = "Trading and trade-related tasks. The ability to get better prices for items you sell, and lower prices for items you buy."
	return skill
EndFunction



; Experience
;---------------------------------------------
