package
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class Main extends MovieClip
	{

		public var BGSCodeObj:Object;
		private const DEFRAG_SOUND:uint = 0;

		// Options
		public var OptionExit_tf:TextField;
		public var OptionTesting_tf:TextField;

		// Data
		public var SkillEntry_mc:MovieClip;
		private const DataToken:String = "DataToken";

		// Test
		private var TestPending:Boolean = false;


		public function Main()
		{
			super();
			this.BGSCodeObj = new Object();
			addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		}


		public function InitProgram() : *
		{
			stage.focus = this;
			this.BGSCodeObj.registerSound("UIGamePipboyDefragHardDriveSpinLPM");
			this.BGSCodeObj.playRegisteredSound(this.DEFRAG_SOUND);

			GetData();
			SendData();
		}


		private function onKeyDown(e:KeyboardEvent) : *
		{
			if(e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.NUMPAD_ENTER)
			{
				if(TestPending == false)
				{
					TestPending = true;
					OptionTesting_tf.textColor = 0x939393;
					OptionTesting_tf.text = "A Lilac test is pending..";
					this.BGSCodeObj.executeCommand("StartQuest Character_Testing");
					this.BGSCodeObj.notifyScripts(OptionTesting_tf.text);
				}
			}
		}


		public function GetData() : *
		{
			// get text replacement token from game/papyrus
			SkillEntry_mc.TokenID_tf.text = this.BGSCodeObj.getTextReplaceID(DataToken);
			SkillEntry_mc.TokenValue_tf.text = this.BGSCodeObj.getTextReplaceValue(DataToken);
		}


		public function SendData() : *
		{
			// Sends a message to papyrus via holotape chatter
			// -This only seems to work when holotape played from a pipboy!
			// -I cannot figure out how to send numeric chatters
			this.BGSCodeObj.notifyScripts("HelloWorld");
		}


	}
}
