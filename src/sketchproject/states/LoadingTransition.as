package sketchproject.states
{
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.objects.loading.TransitionScreen;

	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Loading transition between two states.
	 * 
	 * @author Angga
	 */
	public class LoadingTransition extends Sprite implements IState
	{
		private var game:Game;
		private var delay:int;
		private var loading:TransitionScreen;
		public static var destination:int;

		/**
		 * Default constructor of LoadingTransition.
		 * 
		 * @param game root
		 */
		public function LoadingTransition(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		/**
		 * Init component when this sprite added to stage.
		 */
		public function init():void
		{
			trace("[STATE] LOADING TRANSITION");
			initialize();
		}

		/**
		 * Initializing loading transition content.
		 */
		public function initialize():void
		{
			delay = 0;
			loading = new TransitionScreen(TransitionScreen.SERVER_PROGRESS, "CHANGE STATE", "PLEASE WAIT");
			addChild(loading);
		}

		/**
		 * Wait for a moment to take next action.
		 */
		public function update():void
		{
			delay++;
			if (delay == 80)
			{
				game.changeState(LoadingTransition.destination);
			}
		}

		/**
		 * Destroy all resources.
		 */
		public function destroy():void
		{
			removeFromParent(true);
		}

		/**
		 * Print current loading state.
		 * 
		 * @return 
		 */
		public function toString():String
		{
			return "sketchproject.states.LoadingTransition";
		}
	}
}
