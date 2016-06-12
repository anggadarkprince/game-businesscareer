package sketchproject.states
{
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.objects.loading.TransitionScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LoadingTransition extends Sprite implements IState
	{
		private var game:Game;
		private var delay:int;
		private var loading:TransitionScreen;
		public static var destination:int;
		
		public function LoadingTransition(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void
		{
			initialize();
			trace("[STATE] LOADING TRANSITION");
		}
		
		public function initialize():void
		{
			delay = 0;
			loading = new TransitionScreen(TransitionScreen.SERVER_PROGRESS,"STATE CHANGED","PLEASE WAIT");
			addChild(loading);
		}
		
		public function update():void
		{
			delay++;
			if(delay == 80)
			{
				game.changeState(LoadingTransition.destination);
			}
		}
		
		public function destroy():void
		{
			removeFromParent(true);
		}
		
		public function toString() : String 
		{
			return "sketchproject.states.LoadingTransitionState";
		}
	}
}