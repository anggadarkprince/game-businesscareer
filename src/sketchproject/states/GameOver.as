package sketchproject.states
{
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends Sprite implements IState
	{
		private var game:Game;
		
		public function GameOver(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			initialize();
			trace("[STATE] GAMEOVER");
		}
		
		public function initialize():void
		{
		}
		
		public function update():void
		{
		}
		
		public function destroy():void
		{
		}
		
		public function toString() : String 
		{
			return "sketchproject.states.GameoverState";
		}
	}
}