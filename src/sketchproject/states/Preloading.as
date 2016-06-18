package sketchproject.states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.DataManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.loading.AssetsLoader;
	import sketchproject.objects.loading.GameLoader;
	import sketchproject.objects.loading.TransitionScreen;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Loading game and retrieve data from server.
	 *
	 * @author Angga
	 */
	public class Preloading extends Sprite implements IState
	{
		private var game:Game;

		private var developerLogo:Image;
		private var gamePreload:GameLoader;
		private var assetsPreload:AssetsLoader;
		private var readySessionServer:TransitionScreen;

		private var gameLoading:Boolean;
		private var assetsLoading:Boolean;

		/**
		 * Default constructor of Preloading.
		 * 
		 * @param game root
		 */
		public function Preloading(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		/**
		 * Init component when added to stage.
		 *
		 * @params event passing added to stage event
		 * @return void
		 */
		private function init(event:Event):void
		{
			trace("[STATE] PRELOADING");
			initialize();
		}

		/**
		 * Initializing current state component.
		 *
		 * @return void
		 */
		public function initialize():void
		{
			gameLoading = false;
			assetsLoading = false;

			// [SPRITE] loading step 1 : show game developer logo
			developerLogo = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dev_logo"));
			developerLogo.pivotX = developerLogo.width * 0.5;
			developerLogo.pivotY = developerLogo.height * 0.5;
			developerLogo.alpha = 0;
			developerLogo.scaleX = 0.3;
			developerLogo.scaleY = 0.3;
			developerLogo.x = stage.stageWidth * 0.5;
			developerLogo.y = stage.stageHeight * 0.5;
			addChild(developerLogo);

			// [SPRITE] preload step 2 : show game loading
			gamePreload = new GameLoader();
			gamePreload.x = stage.stageWidth * 0.5;
			gamePreload.y = 100;
			gamePreload.alpha = 0;
			gamePreload.scaleX = 0.3;
			gamePreload.scaleY = 0.3;
			addChild(gamePreload);

			// [SPRITE] preload step 3 : show assets loading
			assetsPreload = new AssetsLoader();
			assetsPreload.alpha = 0;
			addChild(assetsPreload);

			// [SPRITE] preload step 4 : show player session
			readySessionServer = new TransitionScreen(TransitionScreen.SERVER_PROGRESS, "SERVER COMMUNICATION", "[Server Check, Please Wait]");
			readySessionServer.y = -readySessionServer.height;
			addChild(readySessionServer);

			// START HERE
			TweenMax.to(
				developerLogo, 
				0.3, 
				{
					scaleX: 0.5, 
					scaleY: 0.5, 
					alpha: 1, 
					ease: Linear.easeNone, 
					delay: 1, 
					onComplete: logoSlideUp
				}
			);
		}

		/**
		 * Logo game dev show up
		 * @return void
		 */
		private function logoSlideUp():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			TweenMax.to(
				developerLogo, 
				0.6, 
				{
					scaleX: 1, 
					scaleY: 1, 
					ease: Bounce.easeOut, 
					onComplete: logoSlideDown
				}
			);
		}

		/**
		 * Logo game dev hide after 1 seconds delay
		 * @return void
		 */
		private function logoSlideDown():void
		{
			TweenMax.to(
				developerLogo, 
				0.5, 
				{
					scaleX: 0, 
					scaleY: 0, 
					alpha: 0, 
					ease: Back.easeIn, 
					delay: 1, 
					onComplete: gameLoadingSlideUp
				}
			);
		}

		/**
		 * Game loading sprite show up
		 * @return void
		 */
		private function gameLoadingSlideUp():void
		{
			TweenMax.to(
				gamePreload, 
				1.8, 
				{
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					ease: Elastic.easeOut, 
					delay: 0.5, 
					onComplete: function():void {
						gameLoading = true;
					}
				}
			);
		}

		/**
		 * Game loading sprite hide after game loading progress complete
		 * @return void
		 */
		private function gameLoadingSlideDown():void
		{
			TweenMax.to(
				gamePreload, 
				1, 
				{
					scaleX: 0.3, 
					scaleY: 0.3, 
					alpha: 0, 
					ease: Elastic.easeIn, 
					delay: 0.5, 
					onComplete: assetsLoadingSlideUp
				}
			);
		}

		/**
		 * Assets loading sprite show up after game loading complete hiding
		 * @return void
		 */
		private function assetsLoadingSlideUp():void
		{
			TweenMax.to(
				assetsPreload, 
				0.3, 
				{
					alpha: 1, 
					ease: Linear.easeIn, 
					onComplete: function():void 
					{
						assetsLoading = true;
						assetsPreload.openTransition();
					}
				}
			);
			Assets.playBgm(Assets.BGM_TITLE);
		}

		/**
		 * Assets loading sprite hide after assets loading progress complete
		 * @return void
		 */
		private function assetsLoadingSlideDown():void
		{
			TweenMax.to(
				assetsPreload, 
				1, 
				{
					alpha: 0, 
					ease: Linear.easeOut, 
					onComplete: checkSessionSlideUp
				}
			);
		}

		/**
		 * Server checker sprite show up, prepare connect to server
		 * @return void
		 */
		private function checkSessionSlideUp():void
		{
			assetsPreload.destroy();

			TweenMax.to(
				readySessionServer, 
				1, 
				{
					y: 0, 
					ease: Bounce.easeOut, 
					onComplete: checkSession
				}
			);
		}

		/**
		 * Game try to check player session for playing the 
		 * game and making communication to the server.
		 * 
		 * @return void
		 */
		private function checkSession():void
		{
			var playerObject:Object = new Object();
			playerObject.gameaccess = "businesscareer";

			var gameServer:ServerManager = new ServerManager("gameserver", playerObject);
			gameServer.addEventListener(ServerManager.READY, complete);
			gameServer.addEventListener(ServerManager.ERROR, error);
			gameServer.sendRequest();

			function complete(event:Object):void
			{
				var result:String = gameServer.received.result_var;
				if (result == "ready_session")
				{
					var player:Object = JSON.parse(gameServer.received.player_var as String);
					Data.id = player["ply_id"];
					Data.key = player["ply_key"];
					Data.username = player["ply_email"];
					Data.name = player["ply_name"];
					Data.nickname = player["ply_name"].toString().split(" ")[0];

					readySessionServer.updateInfo("SESSION READY", "[Welcome " + player["ply_name"] + "]");

					var isFirstPlay:String = gameServer.received.game_status;
					if (isFirstPlay == "load")
					{
						Config.firstPlay = false;
					}
					else if (isFirstPlay == "setup")
					{
						Config.firstPlay = true;
					}

					TweenMax.to(readySessionServer, 0.5, {delay: 2, onComplete: function():void
					{
						readySessionServer.updateInfo("PLEASE WAIT", "[LOAD MEMORY CARD]");
						var loadGame:DataManager = new DataManager();
						loadGame.addEventListener(ServerManager.READY, function(event:Object):void
						{
							TweenMax.to(
								readySessionServer, 
								0.5, 
								{
									y: -readySessionServer.height - 50, 
									delay: 2, 
									ease: Cubic.easeOut, 
									onComplete: function():void {
										game.changeState(Game.MENU_STATE);
									}
								}
							);
						});
						loadGame.addEventListener(ServerManager.PROGRESS, function(event:Object):void {
							readySessionServer.updateInfo("PLEASE WAIT", "[LOAD MEMORY CARD 100%]");
						});
						loadGame.addEventListener(ServerManager.ERROR, function(event:Object):void {
							readySessionServer.updateInfo("SERVER ERROR", "[TRY AGAIN OR CONTACT OUR ADMINISTRATOR]");
						});
						loadGame.loadGameData();
					}});
				}
				else
				{
					var noSessionServer:TransitionScreen = new TransitionScreen(TransitionScreen.SERVER_EXCLAMATION, "RETRIEVE FAILED", "[No Session Ready, Please Login First]");
					noSessionServer.y = -noSessionServer.height;
					addChild(noSessionServer);

					TweenMax.to(noSessionServer, 1, {y: 0, ease: Bounce.easeOut});
				}
			}

			function error(event:Object):void
			{
				trace("[ERROR] " + gameServer.error);
				var errorSessionServer:TransitionScreen = new TransitionScreen(TransitionScreen.SERVER_EXCLAMATION, "COMMUNICATION DATA ERROR", "[Connection Error Occurred, Try Again or Contact Our Administrator]");
				errorSessionServer.y = -errorSessionServer.height;
				addChild(errorSessionServer);

				TweenMax.to(errorSessionServer, 1, {y: 0, ease: Bounce.easeOut});
			}
		}

		/**
		 * Update current state.
		 * 
		 * @return void
		 */
		public function update():void
		{
			if (gameLoading)
			{
				gamePreload.updateProgress();
				if (gamePreload.isLoaded())
				{
					gameLoading = false;
					gameLoadingSlideDown();
				}
			}
			else if (assetsLoading)
			{
				assetsPreload.update();
				if (assetsPreload.isLoaded && assetsPreload.isClosed)
				{
					assetsLoading = false;
					assetsLoadingSlideDown();
				}
			}
		}

		/**
		 * Garbage collector destroy all compenent and reset variable.
		 * 
		 * @return void
		 */
		public function destroy():void
		{
			developerLogo.removeFromParent(true);
			gamePreload.removeFromParent(true);
			assetsPreload.removeFromParent(true);
			readySessionServer.removeFromParent(true);
			removeFromParent(true);
		}

		/**
		 * Print preloading state.
		 *
		 * @return string
		 */
		public function toString():String
		{
			return "sketchproject.states.Preloading";
		}
	}
}
