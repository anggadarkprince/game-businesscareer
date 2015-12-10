package sketchproject.core
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	import sketchproject.interfaces.IState;
	import sketchproject.modules.EventFactory;
	import sketchproject.objects.Tooltips;
	import sketchproject.objects.dialog.LoadingDialog;
	import sketchproject.states.Business;
	import sketchproject.states.GameOver;
	import sketchproject.states.Gameworld;
	import sketchproject.states.LoadingTransition;
	import sketchproject.states.MainMenu;
	import sketchproject.states.Play;
	import sketchproject.states.Preloading;
	import sketchproject.states.Startup;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	public class Game extends Sprite
	{		
		/** game state constant */
		public static const PRELOADING_STATE:int = 0;
		public static const MENU_STATE:int = 1;
		public static const CONFIGURATION_STATE:int = 2;
		public static const PLAY_STATE:int = 3;
		public static const BUSINESS_STATE:int = 4;
		public static const WORLD_STATE:int = 5;
		public static const GAME_OVER_STATE:int = 6;
		public static const TRANSITION_STATE:int = 7;
				
		/** current state which iterate execution */
		private var currentState:IState;
		
		/** game layer, first, gameStage as main stage for currentState, second, overlayStage for particle */
		public static var gameStage:Sprite;
		public static var overlayStage:Sprite;
		public static var cursorStage:Sprite;
		public static var cursor:Image;
		public static var loadingScreen:LoadingDialog;
		private var showTips:Tooltips;
		private var data:DataLoader;
		
		/** x, y position for custom cursor sprite */
		private var xPos:Number = 0;
		private var yPos:Number = 0;
				
		/**
		 * Game constructor
		 */
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			Starling.current.stage.addEventListener(ResizeEvent.RESIZE, onResize);
		}
		
		/**
		 * Initializing game stage
		 * @params $event passing Added to Stage event
		 * @return void
		 */
		private function init(event:Event):void {			
			gameStage = new Sprite();
			addChild(gameStage);
			
			overlayStage = new Sprite();
			addChild(overlayStage);
			
			cursorStage = new Sprite();
			addChild(cursorStage);
						
			Mouse.hide();
			
			showTips = new Tooltips();
			showTips.name = "tooltips";
			showTips.tipsDirection(Tooltips.TIPS_LEFT);
			Game.overlayStage.addChild(showTips);
			
			loadingScreen = new LoadingDialog();
			loadingScreen.x = Starling.current.stage.stageWidth * 0.5;
			loadingScreen.y = Starling.current.stage.stageHeight* 0.5;
			cursorStage.addChild(loadingScreen);
			
			cursor = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("cursor"));
			cursor.x = Starling.current.stage.stageWidth * 0.5;
			cursor.y = Starling.current.stage.stageHeight* 0.5;
			cursor.scaleX = 0.9;
			cursor.scaleY = 0.9;
			cursorStage.addChild(cursor);
			
			data = new DataLoader();
			data.addEventListener(DataLoader.DATA_LOADED, onGameDataLoaded);
			data.loadMapData();						
			data.loadAdvertisementData();						
			data.loadDistrict();						
			data.loadEventData();
			data.loadResearchData();
			data.loadTipsData();
			data.loadTransactionData();
			data.loadWeatherData();
			data.loadData();
		}
		
		private function onGameDataLoaded(event:Event):void
		{
			Assets.init();
			//testing();
			changeState(PRELOADING_STATE);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Resize game screen when fullscreen state or window state triggered
		 * @params $event passing touch event
		 * @params $size passing stage dimension on resize
		 * @return void
		 */
		private function onResize(event:ResizeEvent, size:Point):void {
			RectangleUtil.fit(
				new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.SHOW_ALL, false,
				Starling.current.viewPort
			);
			trace("[RESIZE] Game Dimension : "+size.x+"   "+size.y);
		}
		
		/**
		 * Game state manager, switch between state to another state
		 * @params $state passing current state
		 * @return void
		 */
		public function changeState(state:int):void {
			if(currentState != null) {
				currentState.destroy();
				currentState = null;
			}
			
			switch(state) {
				case PRELOADING_STATE:
					currentState = new Preloading(this);
					break;
				
				case MENU_STATE:
					currentState = new MainMenu(this);
					break;
				
				case CONFIGURATION_STATE:
					Assets.playBgm(Assets.BGM_FESTIVAL);
					currentState = new Startup(this);
					break;
				
				case PLAY_STATE:
					Assets.playBgm(Assets.BGM_SUMMER);
					currentState = new Play(this);
					break;
				
				case BUSINESS_STATE:
					Assets.playBgm(Assets.BGM_TOWN);
					currentState = new Business(this);
					break;
				
				case WORLD_STATE:
					currentState = new Gameworld(this);
					break;
				
				case GAME_OVER_STATE:
					Assets.playBgm(Assets.BGM_FALL);
					currentState = new GameOver(this);
					break;
				
				case TRANSITION_STATE:
					currentState = new LoadingTransition(this);
					break;
			}
			
			gameStage.addChild(Sprite(currentState));			
		}
		
		/**
		 * Update game frame, 
		 * Update cursor sprite position follow mouse and arraging by game screen
		 * @params $event passing Enter Frame event
		 * @return void
		 */
		private function update(event:Event):void {
			currentState.update();				
			cursor.x = Starling.current.nativeOverlay.mouseX + 2;
			cursor.y = Starling.current.nativeOverlay.mouseY + 2;	
			
			loadingScreen.update();
			showTips.update();
		}
		
		public function testing():void
		{
			Data.tasks.shift();
			Data.tasks.shift();
			var taskLength:int = Data.tasks.length;
			if(Data.tasks.length < 4){
				if(Math.random() < 0.5){
					var totalGenerate:int = Math.ceil(Math.random() * (4 - taskLength));
					trace("generate new", totalGenerate);
					for(var i:int = 0; i < totalGenerate; i++){
						var newTask:Array = EventFactory.generateTask();
						if(newTask.length != 0)
						{
							trace(newTask);
						}						
					}
				}
				else{
					trace("skip generate task");
				}
			}
			else{
				trace("task allready 4");	
			}			
		}
	}
}