Scriptname Fallout:Skills:Display extends ObjectReference
import Fallout
import Papyrus:Diagnostics:Log

UserLog Log

string DataToken = "DataToken" const
ObjectReference LastTerminal


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Context.Title, self)
EndEvent


; Event OnEnable()
; 	RegisterForRemoteEvent(Fallout_Skills_Program, "OnHolotapePlay")
; 	RegisterForRemoteEvent(Fallout_Skills_Program, "OnHolotapeChatter")
; EndEvent


; Event OnDisable()
; 	UnregisterForRemoteEvent(Fallout_Skills_Program, "OnHolotapePlay")
; 	UnregisterForRemoteEvent(Fallout_Skills_Program, "OnHolotapeChatter")
; EndEvent



Event OnHolotapePlay(ObjectReference akTerminalRef)
	Writeline(Log, "OnHolotapePlay(akTerminalRef="+akTerminalRef+")")

	If (akTerminalRef)
		LastTerminal = akTerminalRef
	EndIf

	string data = DataString(Context)

	; I cannot create a string and pass it to AddTextReplacementData. It must use a Form.
	; As a place holder I am using the Message "Fallout_Skills_ProgramMessage" in place of "data"
	LastTerminal.AddTextReplacementData(DataToken, Fallout_Skills_ProgramMessage)
EndEvent


Event OnHolotapeChatter(string asChatter, float afNumericData )
	; Event that occurs when a flash program on a holotape wants to communicate with script.
	Writeline(Log, "________________________")
	Writeline(Log, "| HOLOTAPE LISTENER")
	Writeline(Log, "|   Received Chatter")
	Writeline(Log, "|   Chatter: "+asChatter)
	Writeline(Log, "|   Numeric: "+afNumericData)
	Writeline(Log, "________________________")
EndEvent


; Functions
;---------------------------------------------

string Function DataString(Skills:Context aContext)
	If (aContext == none)
		WriteLine(Log, "Could not get an instance for user modification.")
		return none
	else
		Skills:System:ClientEntry[] entries = Skills.GetEntries()
		string datastring = ""

		int idx = 0
		While (idx < entries.Length)
			Skills:System:ClientEntry entry = entries[idx]
			datastring += entry.Name + "Token|" ; are spaces in name okay?

			idx += 1
		EndWhile

		; Creates a data string of each skill token separated by a pipe '|'
		; example: "DummyToken|BarterToken|LeadershipToken|ExplorationToken|"

		; The menu must know the text replacement token name to get the value.
		; I dont want to hard code all possible skill data tokens into the skill program
		; The skill program will lookup the "DataToken" value which is known by SkillProgram.as
		; The data string can be parsed into a string token array with AS3.
		; With all the token names for skills at hand I can use AS3 to retrieve the values.

		Writeline(Log, "The data string equals '"+datastring+"'.")
		return datastring
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Skills:Context Property Context Auto Const Mandatory
	Skills:System Property Skills Auto Const Mandatory
	Holotape Property Fallout_Skills_Program Auto Const Mandatory
	Message Property Fallout_Skills_ProgramMessage Auto Const Mandatory
EndGroup
