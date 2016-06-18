package sketchproject.objects.world
{
	import flash.media.SoundChannel;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.NavigationEvent;
	import sketchproject.objects.dialog.OptionDialog;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	 * Menu game as dashboard and control extend HUD.
	 * 
	 * @author Angga
	 */
	public class GameMenu extends HeadUpDisplay
	{
		/** container */
		public var containerDashboard:Sprite;
		private var dashboard:Image;

		/** dashboard component */
		private var buttonMap:Button;
		private var buttonBusiness:Button;
		private var buttonProduct:Button;
		private var buttonEmployee:Button;
		private var buttonIssues:Button;
		private var buttonAdvertising:Button;
		private var buttonFinance:Button;

		private var buttonAvatar:Button;
		private var buttonSetting:Button;
		private var buttonHelp:Button;
		private var buttonAchievement:Button;
		private var buttonLeaderboard:Button;
		private var buttonBooster:Button;
		private var buttonMenu:Button;
		private var buttonBgm:Button;
		private var buttonSfx:Button;

		private var buttonOpenMarket:Button;
		private var avatar:Avatar;
		private var timeClock:Clock;

		private var selectMenu:Image;
		private var label:TextField;

		/** sound status */
		private var bgmOn:Boolean;
		private var sfxOn:Boolean;

		/**
		 * Default constructor of GameMenu
		 */
		public function GameMenu()
		{
			super();

			bgmOn = (Config.volbgm == 0) ? false : true;
			sfxOn = (Config.volsfx == 0) ? false : true;

			containerDashboard = new Sprite();

			/** dashboard */
			dashboard = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dashboard"));
			dashboard.x = 0;
			dashboard.y = 422;
			containerDashboard.addChild(dashboard);

			buttonMap = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_map"));
			buttonMap.pivotX = buttonMap.width * 0.5;
			buttonMap.pivotY = buttonMap.height * 0.5;
			buttonMap.x = 282.2;
			buttonMap.y = 505.4;
			containerDashboard.addChild(buttonMap);

			buttonBusiness = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_business"));
			buttonBusiness.pivotX = buttonBusiness.width * 0.5;
			buttonBusiness.pivotY = buttonBusiness.height * 0.5;
			buttonBusiness.x = 351.9;
			buttonBusiness.y = 505.4;
			containerDashboard.addChild(buttonBusiness);

			buttonProduct = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_product"));
			buttonProduct.pivotX = buttonProduct.width * 0.5;
			buttonProduct.pivotY = buttonProduct.height * 0.5;
			buttonProduct.x = 421.6;
			buttonProduct.y = 505.4;
			containerDashboard.addChild(buttonProduct);

			buttonEmployee = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_employee"));
			buttonEmployee.pivotX = buttonEmployee.width * 0.5;
			buttonEmployee.pivotY = buttonEmployee.height * 0.5;
			buttonEmployee.x = 491.3;
			buttonEmployee.y = 505.4;
			containerDashboard.addChild(buttonEmployee);

			buttonIssues = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_issues"));
			buttonIssues.pivotX = buttonEmployee.width * 0.5;
			buttonIssues.pivotY = buttonEmployee.height * 0.5;
			buttonIssues.x = 561;
			buttonIssues.y = 505.4;
			containerDashboard.addChild(buttonIssues);

			buttonAdvertising = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_advert"));
			buttonAdvertising.pivotX = buttonAdvertising.width * 0.5;
			buttonAdvertising.pivotY = buttonAdvertising.height * 0.5;
			buttonAdvertising.x = 630.7;
			buttonAdvertising.y = 505.4;
			containerDashboard.addChild(buttonAdvertising);

			buttonFinance = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_finance"));
			buttonFinance.pivotX = buttonFinance.width * 0.5;
			buttonFinance.pivotY = buttonFinance.height * 0.5;
			buttonFinance.x = 700.4;
			buttonFinance.y = 505.4;
			containerDashboard.addChild(buttonFinance);

			/** Dashboard side control */
			buttonHelp = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_help"));
			buttonHelp.pivotX = buttonHelp.width * 0.5;
			buttonHelp.pivotY = buttonHelp.height * 0.5;
			buttonHelp.x = 112.55;
			buttonHelp.y = 453;
			containerDashboard.addChild(buttonHelp);

			buttonSetting = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_setting"));
			buttonSetting.pivotX = buttonSetting.width * 0.5;
			buttonSetting.pivotY = buttonSetting.height * 0.5;
			buttonSetting.x = 123.2;
			buttonSetting.y = 489;
			containerDashboard.addChild(buttonSetting);

			buttonAvatar = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_info"));
			buttonAvatar.pivotX = buttonAvatar.width * 0.5;
			buttonAvatar.pivotY = buttonAvatar.height * 0.5;
			buttonAvatar.x = 112.45;
			buttonAvatar.y = 526;
			containerDashboard.addChild(buttonAvatar);

			buttonAchievement = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_achievement"));
			buttonAchievement.pivotX = buttonAchievement.width * 0.5;
			buttonAchievement.pivotY = buttonAchievement.height * 0.5;
			buttonAchievement.x = 887.95;
			buttonAchievement.y = 453;
			containerDashboard.addChild(buttonAchievement);

			buttonLeaderboard = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_leaderboard"));
			buttonLeaderboard.pivotX = buttonLeaderboard.width * 0.5;
			buttonLeaderboard.pivotY = buttonLeaderboard.height * 0.5;
			buttonLeaderboard.x = 873.55;
			buttonLeaderboard.y = 489;
			containerDashboard.addChild(buttonLeaderboard);

			buttonBooster = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_game"));
			buttonBooster.pivotX = buttonBooster.width * 0.5;
			buttonBooster.pivotY = buttonBooster.height * 0.5;
			buttonBooster.x = 884.4;
			buttonBooster.y = 526;
			containerDashboard.addChild(buttonBooster);

			buttonMenu = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_pause"));
			buttonMenu.pivotX = buttonMenu.width * 0.5;
			buttonMenu.pivotY = buttonMenu.height * 0.5;
			buttonMenu.x = 763.65;
			buttonMenu.y = 508.05;
			containerDashboard.addChild(buttonMenu);

			buttonBgm = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music"));
			buttonBgm.pivotX = buttonBgm.width * 0.5;
			buttonBgm.pivotY = buttonBgm.height * 0.5;
			buttonBgm.x = 812.85;
			buttonBgm.y = 489.05;
			containerDashboard.addChild(buttonBgm);

			buttonSfx = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound"));
			buttonSfx.pivotX = buttonSfx.width * 0.5;
			buttonSfx.pivotY = buttonSfx.height * 0.5;
			buttonSfx.x = 814.05;
			buttonSfx.y = 529.2;
			containerDashboard.addChild(buttonSfx);

			buttonOpenMarket = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_open_market"));
			buttonOpenMarket.pivotX = buttonOpenMarket.width * 0.5;
			buttonOpenMarket.pivotY = buttonOpenMarket.height * 0.5;
			buttonOpenMarket.x = 939.8;
			buttonOpenMarket.y = 483;
			containerDashboard.addChild(buttonOpenMarket);

			label = new TextField(80, 70, "MARKET", Assets.getFont("FontErasITC").fontName, 15, 0x333333);
			label.pivotX = label.width * 0.5;
			label.pivotY = label.height * 0.5;
			label.x = 939.8;
			label.y = 540;
			containerDashboard.addChild(label);

			avatar = new Avatar();
			avatar.x = 20;
			avatar.y = 450;
			avatar.scaleX = 0.8;
			avatar.scaleY = 0.8;
			containerDashboard.addChild(avatar);

			timeClock = new Clock();
			timeClock.pivotX = timeClock.width * 0.5;
			timeClock.pivotY = timeClock.height * 0.5;
			timeClock.x = 240;
			timeClock.y = 555;
			containerDashboard.addChild(timeClock);

			selectMenu = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("focus_circle"));
			selectMenu.pivotX = selectMenu.width * 0.5;
			selectMenu.pivotY = selectMenu.height * 0.5;
			selectMenu.x = buttonMap.x;
			selectMenu.y = buttonMap.y;
			containerDashboard.addChild(selectMenu);

			addChild(containerDashboard);

			buttonHelp.addEventListener(Event.TRIGGERED, onTrigerredHelp);
			buttonSetting.addEventListener(Event.TRIGGERED, onTrigerredSetting);
			buttonAvatar.addEventListener(Event.TRIGGERED, onTrigerredAvatar);
			buttonAchievement.addEventListener(Event.TRIGGERED, onTrigerredAchievement);
			buttonLeaderboard.addEventListener(Event.TRIGGERED, onTrigerredLeaderboard);
			buttonBooster.addEventListener(Event.TRIGGERED, onTrigerredBooster);
			buttonMenu.addEventListener(Event.TRIGGERED, onTrigerredMenu);
			buttonOpenMarket.addEventListener(Event.TRIGGERED, onTrigerredMarket);
			buttonBgm.addEventListener(Event.TRIGGERED, bgmSwitch);
			buttonSfx.addEventListener(Event.TRIGGERED, sfxSwitch);

			buttonMap.addEventListener(Event.TRIGGERED, onTrigerredMap);
			buttonBusiness.addEventListener(Event.TRIGGERED, onTrigerredBusiness);
			buttonProduct.addEventListener(Event.TRIGGERED, onTrigerredProduct);
			buttonEmployee.addEventListener(Event.TRIGGERED, onTrigerredEmployee);
			buttonIssues.addEventListener(Event.TRIGGERED, onTrigerredIssues);
			buttonAdvertising.addEventListener(Event.TRIGGERED, onTrigerredAdvertisement);
			buttonFinance.addEventListener(Event.TRIGGERED, onTrigerredFinance);

			if (this.bgmOn)
			{
				buttonBgm.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music");
			}
			else
			{
				buttonBgm.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music_disable");
			}
			
			if (this.sfxOn)
			{
				buttonSfx.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound");
			}
			else
			{
				buttonSfx.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound_disable");
			}

		}

		/**
		 * Sfx toggle max volume or mute.
		 * 
		 * @param event
		 */
		private function sfxSwitch(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			initSfxState();
		}

		/**
		 * Set sfx state, switch on or off.
		 */
		private function initSfxState():void
		{
			var sfxChannel:SoundChannel;
			if (this.sfxOn)
			{
				sfxOn = false;
				Config.volsfx = 0;
				buttonSfx.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound_disable");
				sfxChannel = Assets.sfxSfxMute.play();
			}
			else
			{
				sfxOn = true;
				Config.volsfx = 10;
				buttonSfx.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound");
				sfxChannel = Assets.sfxSfxActive.play();
			}
			OptionDialog.volumeBgm = Config.volbgm;
			OptionDialog.volumeSfx = Config.volsfx;
			Assets.setupGameSound();
		}

		/**
		 * Bgm toggle max volume or mute.
		 * 
		 * @param event
		 */
		private function bgmSwitch(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			initBgmState();
		}

		/**
		 * Set bgm state, switch on or off.
		 */
		private function initBgmState():void
		{
			var bgmChannel:SoundChannel;
			if (this.bgmOn)
			{
				bgmOn = false;
				Config.volbgm = 0;
				buttonBgm.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music_disable");
				bgmChannel = Assets.sfxBgmMute.play();
			}
			else
			{
				bgmOn = true;
				Config.volbgm = 10;
				buttonBgm.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music");
				bgmChannel = Assets.sfxBgmActive.play();
			}
			OptionDialog.volumeBgm = Config.volbgm;
			OptionDialog.volumeSfx = Config.volsfx;
			Assets.setupGameSound();
		}

		/**
		 * Update sound state if option set muted or loud.
		 */
		public function checkSoundState():void
		{
			if (Config.volbgm > 0)
			{
				bgmOn = true;
				buttonBgm.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music");
			}
			else
			{
				bgmOn = false;
				buttonBgm.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_music_disable");
			}


			if (Config.volsfx > 0)
			{
				sfxOn = true;
				buttonSfx.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound");
			}
			else
			{
				sfxOn = false;
				buttonSfx.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_sound_disable");
			}
		}

		/** dialog event dispatch */
		
		/**
		 * Dispatch help button.
		 * 
		 * @param event
		 */
		private function onTrigerredHelp(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxHelp.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_HELP));
		}

		/**
		 * Dispatch setting button.
		 * 
		 * @param event
		 */
		private function onTrigerredSetting(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxOption.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_SETTING));
		}

		/**
		 * Dispatch update avatar button.
		 * 
		 * @param event
		 */
		private function onTrigerredAvatar(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxAvatar.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_AVATAR));
		}

		/**
		 * Dispatch show achievement button.
		 * 
		 * @param event
		 */
		private function onTrigerredAchievement(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxAchievement.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_ACHIEVEMENT));
		}

		/**
		 * Dispatch show leaderboard button.
		 * 
		 * @param event
		 */
		private function onTrigerredLeaderboard(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxLeaderboard.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_LEADERBOARD));
		}

		/**
		 * Dispatch upgrade booster button.
		 * 
		 * @param event
		 */
		private function onTrigerredBooster(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxGameBooster.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_BOOSTER));
		}

		/**
		 * Dispatch menu button.
		 * 
		 * @param event
		 */
		private function onTrigerredMenu(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxPause.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_PAUSE));
		}

		/**
		 * Dispatch market button
		 * @param event
		 */
		private function onTrigerredMarket(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_MARKET));
		}


		/** navigation event dispatch */
		
		/**
		 * Dispatch map menu.
		 * 
		 * @param event
		 */
		private function onTrigerredMap(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxGameWorld.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonMap.x;
			selectMenu.y = buttonMap.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_MAP));
		}

		/**
		 * Dispatch business menu.
		 * 
		 * @param event
		 */
		private function onTrigerredBusiness(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxBusiness.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonBusiness.x;
			selectMenu.y = buttonBusiness.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_BUSINESS));
		}

		/**
		 * Dispatch product menu.
		 * 
		 * @param event
		 */
		private function onTrigerredProduct(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxProduct.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonProduct.x;
			selectMenu.y = buttonProduct.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_PRODUCT));
		}

		/**
		 * Dispatch employee menu.
		 * 
		 * @param event
		 */
		private function onTrigerredEmployee(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxEmployee.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonEmployee.x;
			selectMenu.y = buttonEmployee.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_EMPLOYEE));
		}

		/**
		 * Dispatch issues menu.
		 * 
		 * @param event
		 */
		private function onTrigerredIssues(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxIssues.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonIssues.x;
			selectMenu.y = buttonIssues.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_ISSUES));
		}

		/**
		 * Dispatch advertisement menu.
		 * 
		 * @param event
		 */
		private function onTrigerredAdvertisement(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxAdvertising.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonAdvertising.x;
			selectMenu.y = buttonAdvertising.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_ADVERTISING));
		}

		/**
		 * Dispatch finance menu.
		 * 
		 * @param event
		 */
		private function onTrigerredFinance(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxFinance.play(0, 0, Assets.sfxTransform);
			selectMenu.x = buttonFinance.x;
			selectMenu.y = buttonFinance.y;
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_FINANCE));
		}

		/**
		 * Update avatar, menu selection and HUD.
		 */
		override public function update():void
		{
			avatar.updateAvatar();
			textPoint.text = ValueFormatter.format(Data.point) + " PTS";
			textProfit.text = "IDR " + ValueFormatter.format(Data.cash);
			selectMenu.rotation += 0.1;
		}

		/**
		 * Release dashboard menu.
		 */
		override public function destroy():void
		{
			cart.stopAdvisorSignal();
			avatar.removeFromParent(false);
			removeFromParent(true);
		}
	}
}
