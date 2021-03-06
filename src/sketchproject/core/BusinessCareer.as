package sketchproject.core
{
	import flash.display.Sprite;

	import starling.core.Starling;

	[SWF(frameRate = 60, width = "1000", height = "560", backgroundColor = "0x333333")]
	public class BusinessCareer extends Sprite
	{
		/** starling instance for game */
		private var coreGame:Starling;

		/**
		 * Main class constructor
		 * Starling framework start here
		 */
		public function BusinessCareer()
		{
			trace("[INIT] GAME FRAMEWORK START");
			coreGame = new Starling(Game, stage);
			coreGame.antiAliasing = 1;
			coreGame.showStats = true;
			coreGame.start();
		}
	}
}
