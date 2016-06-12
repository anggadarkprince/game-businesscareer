package sketchproject.states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.DataManager;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.modules.EventFactory;
	import sketchproject.objects.Tooltips;
	import sketchproject.objects.startup.StartupConfiguration;
	import sketchproject.objects.startup.StartupFinancial;
	import sketchproject.objects.startup.StartupParameter;
	import sketchproject.objects.startup.StartupTarget;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Startup extends Sprite implements IState
	{
		private var game:Game;
		private var background:Image;
		
		private var configurationScreen:StartupConfiguration;
		private var parameterScreen:StartupParameter;
		private var targetScreen:StartupTarget;
		private var financialScreen:StartupFinancial;
		
		private var setConfigurationDone:Boolean;
		private var setParameterDone:Boolean;
		private var setTargetDone:Boolean;
		private var setFinancialDone:Boolean;
		
		private var startupPage:uint;
		
		private var buttonClose:Button;
		private var buttonPlay:Button;
		
		private var buttonPageActive:Image;
		
		private var buttonBusinessProfile:Button;
		private var buttonGameParameter:Button;
		private var buttonPlanObjective:Button;
		private var buttonSeedFinancial:Button;
		
		private var checkConfigurationDone:Image;
		private var checkParameterDone:Image;
		private var checkTargetDone:Image;
		private var checkFinancialDone:Image;
		
		private var labelConfiguration:Image;
		private var labelParameter:Image;
		private var labelTarget:Image;
		private var labelFinancial:Image;
		
		private var fireworkManager:FireworkManager;
		
		private var showTips:Tooltips;
		
		/**
		 * Parameter state constructor
		 * @params game for parent sprite
		 */
		public function Startup(game:Game)
		{
			super();
			
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Initializing parameter state
		 * @params $event passing Added to Stage event
		 * @return void
		 */
		private function init(event:Event):void
		{
			initialize();	
			openTransition();			
			trace("[STATE] PARAMETER MENU");
		}
		
		/**
		 * Initializing current state component
		 * @return void
		 */
		public function initialize():void
		{			
			fireworkManager = new FireworkManager(Game.overlayStage);

			showTips = new Tooltips();
			showTips.tipsDirection(Tooltips.TIPS_LEFT);
			Game.overlayStage.addChild(showTips);
			
			setConfigurationDone = true;
			setParameterDone = false;
			setTargetDone = false;
			setFinancialDone = false;
			
			startupPage = 1;
			
			background = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("parameter_background"));
			addChild(background);
			
			configurationScreen= new StartupConfiguration();
			configurationScreen.x = 50;
			configurationScreen.y = 100;
			addChild(configurationScreen);
			
			parameterScreen = new StartupParameter();
			parameterScreen.x = 50;
			parameterScreen.y = 100;
			addChild(parameterScreen);
						
			targetScreen = new StartupTarget();
			targetScreen.x = 50;
			targetScreen.y = 100;
			addChild(targetScreen);
			
			financialScreen = new StartupFinancial();
			financialScreen.x = 50;
			financialScreen.y = 100;
			addChild(financialScreen);
			
			
			/** label page top **/
			labelConfiguration = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_startup_configuration"));
			labelConfiguration.x = 50;
			labelConfiguration.y = 18;
			labelConfiguration.visible = false;
			addChild(labelConfiguration);
			
			labelParameter = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_startup_parameter"));
			labelParameter.x = 50;
			labelParameter.y = 18;
			labelParameter.visible = false;
			addChild(labelParameter);
			
			labelTarget = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_startup_target"));
			labelTarget.x = 50;
			labelTarget.y = 18;
			labelTarget.visible = false;
			addChild(labelTarget);
			
			labelFinancial = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_startup_financial"));
			labelFinancial.x = 50;
			labelFinancial.y = 18;
			labelFinancial.visible = false;
			addChild(labelFinancial);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = 950;
			buttonClose.y = 30;
			addChild(buttonClose);
			
			buttonPageActive = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_parameter"));
			buttonPageActive.x = 40;
			buttonPageActive.y = 505;
			addChild(buttonPageActive);
			
			/** button page bottom */
			buttonBusinessProfile = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_business_profile"));
			buttonBusinessProfile.x = 60;
			buttonBusinessProfile.y = 515;
			addChild(buttonBusinessProfile);			
			
			buttonGameParameter = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_game_parameter"));
			buttonGameParameter.x = 280;
			buttonGameParameter.y = 515;
			addChild(buttonGameParameter);
			
			buttonPlanObjective= new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plan_objective"));
			buttonPlanObjective.x = 500;
			buttonPlanObjective.y = 515;
			addChild(buttonPlanObjective);
			
			buttonSeedFinancial = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_seed_financing"));
			buttonSeedFinancial.x = 720;
			buttonSeedFinancial.y = 515;
			addChild(buttonSeedFinancial);
			
			/** label check **/
			checkConfigurationDone = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			checkConfigurationDone.x = 55;
			checkConfigurationDone.y = 505;
			checkConfigurationDone.visible = false;
			addChild(checkConfigurationDone);
			
			checkParameterDone = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			checkParameterDone.x = 275;
			checkParameterDone.y = 505;
			checkParameterDone.visible = false;
			addChild(checkParameterDone);
			
			checkTargetDone = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			checkTargetDone.x = 495;
			checkTargetDone.y = 505;
			checkTargetDone.visible = false;
			addChild(checkTargetDone);
			
			checkFinancialDone = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			checkFinancialDone.x = 715;
			checkFinancialDone.y = 505;
			checkFinancialDone.visible = false;
			addChild(checkFinancialDone);
			
			/** button play **/
			buttonPlay = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_play_unactive"));
			buttonPlay.pivotX = buttonPlay.width * 0.5;
			buttonPlay.pivotY = buttonPlay.height * 0.5;
			buttonPlay.x = 950;
			buttonPlay.y = 522;
			buttonPlay.enabled = false;
			addChild(buttonPlay);			
			
			y = -height;
			
			addEventListener(TouchEvent.TOUCH, onButtonSetupTouched);
		}
		
		
		/**
		 * Event when setup button triggered
		 * @params $touch passing touch event
		 * @return void
		 */
		private function onButtonSetupTouched(touch:TouchEvent):void
		{	
			if (touch.getTouch(buttonBusinessProfile, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Setting up your personal profile";
			}
			else if (touch.getTouch(buttonGameParameter, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Setting up your game parameter";
			}
			else if (touch.getTouch(buttonPlanObjective, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Setting up your objective";
			}
			else if (touch.getTouch(buttonSeedFinancial, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Setting up your seed financing";
			}
			else{
				showTips.hideTips();
			}
			
			if (touch.getTouch(buttonBusinessProfile, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				setConfigurationDone = true;
				startupPage = 1;
				TweenMax.to(
					buttonPageActive,
					0.5,
					{
						x:buttonBusinessProfile.x - 20,
						ease:Bounce.easeOut
					}
				);
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxBusinessProfile.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonGameParameter, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				setParameterDone = true;
				startupPage = 2;
				TweenMax.to(
					buttonPageActive,
					0.5,
					{
						x:buttonGameParameter.x - 20,
						ease:Bounce.easeOut
					}
				);
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxGameParameter.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonPlanObjective, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				setTargetDone = true;
				startupPage = 3;
				TweenMax.to(
					buttonPageActive,
					0.5,
					{
						x:buttonPlanObjective.x - 20,
						ease:Bounce.easeOut
					}
				);
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxObjective.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonSeedFinancial, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				setFinancialDone = true;
				startupPage = 4;
				TweenMax.to(
					buttonPageActive,
					0.5,
					{
						x:buttonSeedFinancial.x - 20,
						ease:Bounce.easeOut
					}
				);
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxSeedFinancing.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonPlay, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxLetsPlay.play(0,0,Assets.sfxTransform);
				
				Game.loadingScreen.show();
								
				var initialEvent:EventFactory = new EventFactory();
				initialEvent.initialTask();
				initialEvent.initialTransaction();
				initialEvent.generateWeather(true);
				initialEvent.generateWeather(true);
				initialEvent.generateWeather(true);
				initialEvent.generateEvent();
				
				if(Data.avatarName == "GameTester")
				{
					trace("[CHEAT] Activated");
					Data.cash = 999999999;
				}
				
				var setup:DataManager = new DataManager();				
				setup.addEventListener(ServerManager.READY,function(event:Object):void{
					loadData();					
				});
				setup.setupGameData();				
				
			}
			
			if (touch.getTouch(buttonClose, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxBackToMenu.play(0,0,Assets.sfxTransform);
				closeTransition(Game.MENU_STATE);
			}
		}
		
		private function loadData():void
		{
			var load:DataManager = new DataManager();				
			load.addEventListener(ServerManager.READY,function(event:Object):void{
				Game.loadingScreen.hide();
				closeTransition(Game.PLAY_STATE);				
			});
			load.loadGameData();			
		}
		
		/**
		 * Parameter open transition
		 * @return void
		 */
		private function openTransition():void
		{
			TweenMax.to(
				this,
				1.2,
				{
					y:0,
					ease:Bounce.easeOut,
					delay:1
				}
			);
		}
		
		/**
		 * Parameter menu close transition
		 * @params $dest for destination state
		 * @return void
		 */
		private function closeTransition(dest:int):void
		{
			TweenMax.to(
				this,
				0.5,
				{
					y:-height - 100,
					ease:Back.easeIn,
					delay:0.2,
					onComplete:changeState,
					onCompleteParams:[dest]
				}
			);
		}
		
		/**
		 * Change current state to play or menu state
		 * @params $dest for destination state
		 * @return void
		 */
		private function changeState(dest:int):void
		{
			if(dest == Game.PLAY_STATE)
			{
				LoadingTransition.destination = Game.PLAY_STATE;
			}
			else if(dest == Game.MENU_STATE)
			{
				LoadingTransition.destination = Game.MENU_STATE;
			}		
			game.changeState(Game.TRANSITION_STATE);
		}
		
		
		/**
		 * Update current state
		 * @return void
		 */
		public function update():void
		{
			if(!configurationScreen.isCompleted()){
				setConfigurationDone = false;
			}
			else{
				setConfigurationDone = true;
			}
			
			if(setConfigurationDone && setParameterDone && setTargetDone && setFinancialDone) {
				buttonPlay.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_play_active");
				buttonPlay.enabled = true;
			}			
			else{
				buttonPlay.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_play_unactive");
				buttonPlay.enabled = false;
			}
			
			if(setConfigurationDone){
				checkConfigurationDone.visible = true;
			}
			if(setParameterDone){
				checkParameterDone.visible = true;
			}
			if(setTargetDone){
				checkTargetDone.visible = true;
			}
			if(setFinancialDone){
				checkFinancialDone.visible = true;
			}
			
			/** reset title label visibility */
			labelConfiguration.visible = false;
			labelParameter.visible = false;
			labelTarget.visible = false;
			labelFinancial.visible = false;
			
			/** reset screen visibility */
			configurationScreen.visible = false;
			parameterScreen.visible = false;
			targetScreen.visible = false;
			financialScreen.visible = false;
			
			if(startupPage == 1)
			{
				checkConfigurationDone.visible = false;
				labelConfiguration.visible = true;
				configurationScreen.visible = true;
			}
			else if(startupPage == 2)
			{
				checkParameterDone.visible = false;
				labelParameter.visible = true;
				parameterScreen.visible = true;
			}
			else if(startupPage == 3)
			{
				checkTargetDone.visible = false;
				labelTarget.visible = true;
				targetScreen.visible = true;
			}
			else if(startupPage == 4)
			{
				checkFinancialDone.visible = false;
				labelFinancial.visible = true;
				financialScreen.visible = true;
			}
			
			showTips.x = Starling.current.nativeOverlay.mouseX - 5;
			showTips.y = Starling.current.nativeOverlay.mouseY - 10;
			
			parameterScreen.update();
			targetScreen.update();
			configurationScreen.update();
			financialScreen.update();
		}
			
		/**
		 * Garbage collector destroy all compenent and reset variable
		 * @return void
		 */
		public function destroy():void
		{			
			removeEventListener(TouchEvent.TOUCH, onButtonSetupTouched);
			fireworkManager.destroy();
			configurationScreen.destroy();
			parameterScreen.destroy();
			removeFromParent(true);
		}
		
		public function toString() : String 
		{
			return "sketchproject.states.StartupState";
		}
	}
}