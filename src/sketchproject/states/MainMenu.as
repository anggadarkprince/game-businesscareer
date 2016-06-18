package sketchproject.states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Linear;
	
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.RainManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.Tooltips;
	import sketchproject.objects.dialog.HelpDialog;
	import sketchproject.objects.dialog.NativeDialog;
	import sketchproject.objects.dialog.OptionDialog;
	import sketchproject.objects.particle.RainParticle;
	import sketchproject.utilities.GameUtils;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * State that handle main menu, contain game configuration
	 * and help, main gate to enter the game.
	 *
	 * @author Angga
	 */
	public class MainMenu extends Sprite implements IState
	{
		private var game:Game;

		private var background:Image;
		private var backgroundNight:Image;
		private var sun:Image;
		private var copyright:Image;
		private var logo:Image;
		private var credit:Image;

		private var buttonStart:Button;
		private var buttonOption:Button;
		private var buttonHelp:Button;
		private var buttonExit:Button;

		private var buttonFacebook:Button;
		private var buttonTwitter:Button;
		private var buttonCredit:Button;

		private var dialogOption:OptionDialog;
		private var dialogHelp:HelpDialog;
		private var dialogExitConfirm:NativeDialog;

		private var request:URLRequest;
		private var fireworkManager:FireworkManager;
		private var timerFireworks:Timer;

		private var rainManager:RainManager;
		private var rainContainer:Sprite;
		private var isRaining:Boolean;

		private var showTips:Tooltips;

		/**
		 * Default constructor of MainMenu.
		 *
		 * @param game root
		 */
		public function MainMenu(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		/**
		 * Init component and transition when this sprite added to stage.
		 *
		 * @param event listener added to stage
		 */
		private function init(event:Event):void
		{
			trace("[STATE] MAIN MENU");
			initialize();
			openTransition();
		}

		/**
		 * Initializing all main menu component.
		 *
		 * @return void
		 */
		public function initialize():void
		{
			timerFireworks = new Timer(1000);

			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			showTips = Tooltips.getInstance();
			showTips.tipsDirection(Tooltips.TIPS_LEFT);
			Game.overlayStage.addChild(showTips);

			background = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("menu_background"));
			background.alpha = 0;
			addChild(background);

			backgroundNight = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("menu_background_night"));
			backgroundNight.alpha = 0;
			addChild(backgroundNight);

			rainContainer = new Sprite();
			addChild(rainContainer);

			credit = new Image(Assets.getAtlas(Assets.PANEL, Assets.PANEL_XML).getTexture("credit_title"));
			credit.x = 50;
			credit.y = Starling.current.nativeStage.stageHeight + 50;
			addChild(credit);

			sun = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("sun"));
			sun.pivotX = sun.width * 0.5;
			sun.pivotY = sun.height * 0.5;
			sun.x = 680;
			sun.y = -100;
			addChild(sun);

			copyright = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("copyright"));
			copyright.pivotY = copyright.height;
			copyright.x = 5;
			copyright.y = Starling.current.stage.stageHeight + copyright.height;
			addChild(copyright);

			logo = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("game_logo"));
			logo.pivotX = logo.width * 0.5;
			logo.pivotY = logo.height * 0.5;
			logo.x = 850;
			logo.y = 100;
			logo.scaleX = 0;
			logo.scaleY = 0;
			logo.alpha = 0;
			addChild(logo);

			buttonStart = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_menu_play"));
			buttonStart.pivotY = buttonStart.height * 0.5;
			buttonStart.alpha = 0;
			buttonStart.x = 0;
			buttonStart.y = 135;
			addChild(buttonStart);

			buttonOption = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_menu_option"));
			buttonOption.pivotY = buttonOption.height * 0.5;
			buttonOption.alpha = 0;
			buttonOption.x = 0;
			buttonOption.y = buttonStart.y + buttonStart.height * 0.5 + 20 + 10;
			addChild(buttonOption);

			buttonHelp = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_menu_help"));
			buttonHelp.pivotY = buttonHelp.height * 0.5;
			buttonHelp.alpha = 0;
			buttonHelp.x = 0;
			buttonHelp.y = buttonOption.y + buttonOption.height * 0.5 + 10;
			addChild(buttonHelp);

			buttonExit = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_menu_exit"));
			buttonExit.pivotY = buttonExit.height * 0.5;
			buttonExit.alpha = 0;
			buttonExit.x = 0;
			buttonExit.y = buttonHelp.y + buttonHelp.height * 0.5 + 5;
			addChild(buttonExit);

			buttonFacebook = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_facebook"));
			buttonFacebook.pivotX = buttonFacebook.width * 0.5;
			buttonFacebook.pivotY = buttonFacebook.height * 0.5;
			buttonFacebook.alpha = 0;
			buttonFacebook.x = 250;
			buttonFacebook.y = 470 + 40;
			addChild(buttonFacebook);

			buttonTwitter = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_twitter"));
			buttonTwitter.pivotX = buttonTwitter.width * 0.5;
			buttonTwitter.pivotY = buttonTwitter.height * 0.5;
			buttonTwitter.alpha = 0;
			buttonTwitter.x = buttonFacebook.x + buttonFacebook.width * 0.5 + 20;
			buttonTwitter.y = buttonFacebook.y - 30 + 40;
			addChild(buttonTwitter);

			buttonCredit = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_credit"));
			buttonCredit.pivotX = buttonCredit.width * 0.5;
			buttonCredit.pivotY = buttonCredit.height * 0.5;
			buttonCredit.alpha = 0;
			buttonCredit.x = buttonTwitter.x + buttonTwitter.width * 0.5 + 20;
			buttonCredit.y = buttonTwitter.y - 20 + 40;
			addChild(buttonCredit);

			dialogOption = new OptionDialog();
			dialogOption.x = stage.stageWidth * 0.5;
			dialogOption.y = stage.stageHeight * 0.5;
			addChild(dialogOption);

			dialogHelp = new HelpDialog();
			dialogHelp.x = stage.stageWidth * 0.5;
			dialogHelp.y = stage.stageHeight * 0.5;
			addChild(dialogHelp);

			dialogExitConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Exit Confirm", "Do you want to exit the game?");
			dialogExitConfirm.x = stage.stageWidth * 0.5;
			dialogExitConfirm.y = stage.stageHeight * 0.5;
			dialogExitConfirm.addEventListener(DialogBoxEvent.CLOSED, onConfirmExit);
			addChild(dialogExitConfirm);

			addEventListener(TouchEvent.TOUCH, onMenuTouched);

			setDayNight();
		}
		
		/**
		 * Set transition from day to night,
		 * seed probability to produce rain and choice the rain drop type.
		 */
		public function setDayNight():void
		{
			TweenMax.to(
				backgroundNight,
				20,
				{
					repeat: 3,
					alpha: 1,
					yoyo: true,
					delay: 10
				}
			);

			isRaining = GameUtils.probability(0.5);
			if (isRaining)
			{
				var rainType:String;
				switch (GameUtils.randomFor(3))
				{
					case 1:
						rainType = RainParticle.HEAVY_RAIN;
						break;
					case 2:
						rainType = RainParticle.LIGHT_RAIN;
						break;
					case 3:
						rainType = RainParticle.STORM_RAIN;
						break;

				}
				rainManager = new RainManager(rainContainer, rainType);
			}
		}

		/**
		 * Event when buttons on main menu are touched.
		 *
		 * @params touch passing touch event
		 * @return void
		 */
		private function onMenuTouched(touch:TouchEvent):void
		{
			// show tooltips when cursor over the social buttons
			
			if (touch.getTouch(buttonFacebook, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Like Facebook Fans Page";
			}
			else if (touch.getTouch(buttonTwitter, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Follow Our Twitter";
			}
			else if (touch.getTouch(buttonCredit, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Show Game Credit";
			}
			else
			{
				showTips.hideTips();
			}

			// catch event touch if hits the button
			
			if (touch.getTouch(buttonStart, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxLetsPlay.play(0, 0, Assets.sfxTransform);
				closeTransition();
			}

			if (touch.getTouch(buttonOption, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxOption.play(0, 0, Assets.sfxTransform);
				dialogOption.openDialog();
			}

			if (touch.getTouch(buttonHelp, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxHelp.play(0, 0, Assets.sfxTransform);
				dialogHelp.openDialog();
			}

			if (touch.getTouch(buttonExit, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				Assets.sfxChannel = Assets.sfxExit.play(0, 0, Assets.sfxTransform);
				dialogExitConfirm.openDialog();
			}

			if (touch.getTouch(buttonFacebook, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				request = new URLRequest("http://www.facebook.com/page/businesscareer");
				try
				{
					navigateToURL(request, '_blank');
				}
				catch (e:Error)
				{
					trace("[ERROR LINK] Error occurred!" + e.message);
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonTwitter, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				request = new URLRequest("http://www.twitter.com/businesscareer");
				try
				{
					navigateToURL(request, '_blank');
				}
				catch (e:Error)
				{
					trace("[ERROR LINK] Error occurred!" + e.message);
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonCredit, TouchPhase.ENDED))
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);

				copyright.visible = false;
				buttonStart.visible = false;
				buttonOption.visible = false;
				buttonHelp.visible = false;
				buttonExit.visible = false;
				buttonFacebook.visible = false;
				buttonTwitter.visible = false;
				buttonCredit.visible = false;

				showCredit();

				timerFireworks.addEventListener(TimerEvent.TIMER, randomFireworks);
				timerFireworks.start();
			}
		}

		/**
		 * Spawn random firework when credit still scrolling.
		 *
		 * @param event triggered timer event
		 */
		private function randomFireworks(event:TimerEvent):void
		{
			Assets.sfxChannel = Assets.sfxFireworks.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
		}

		/**
		 * Dispatch event when dialog box confirm.
		 * 
		 * @params event passing dialog box event
		 * @return void
		 */
		private function onConfirmExit(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				dialogExitConfirm.closeDialog();

				TweenMax.to(
					dialogExitConfirm, 
					1, 
					{
						delay: 0.5, 
						onComplete: function():void {
							request = new URLRequest(ServerManager.SERVER_HOST);
							try
							{
								navigateToURL(request, '_self');
							}
							catch (e:Error)
							{
								trace("[ERROR LINK] Error occurred!" + e.message);
							}
						}
					}
				);
			}
			else
			{
				dialogExitConfirm.closeDialog();
			}
		}
		
		/**
		 * Show credit title, scrolling up until over the top 50px and restore menu visibility.
		 * 
		 * @return void
		 */
		private function showCredit():void
		{			
			TweenMax.to(
				credit,
				35,
				{
					ease: Linear.easeNone,
					y: -credit.height + 50,
					onComplete:function():void {
						copyright.visible = true;
						buttonStart.visible = true;
						buttonOption.visible = true;
						buttonHelp.visible = true;
						buttonExit.visible = true;
						buttonFacebook.visible = true;
						buttonTwitter.visible = true;
						buttonCredit.visible = true;
						credit.y = Starling.current.nativeStage.stageHeight + 50;
						timerFireworks.stop();
						timerFireworks.removeEventListener(TimerEvent.TIMER, randomFireworks);
					}					
				}
			);
		}

		/**
		 * Main menu open transition.
		 *
		 * @return void
		 */
		private function openTransition():void
		{
			// show up main menu
			TweenMax.to(
				background,
				1,
				{
					alpha: 1,
					delay: 0.3
				}
			);
			
			// scale up the logo
			TweenMax.to(
				logo,
				1,
				{
					scaleX: 0.6,
					scaleY: 0.6,
					alpha: 1,
					ease: Back.easeOut,
					delay: 2.5
				}
			);
			
			// show up the sun
			TweenMax.to(
				sun,
				1,
				{
					x: 680,
					y: 80,
					alpha: 1,
					ease: Back.easeOut,
					delay: 1.8
				}
			);
			
			// rise up the copyright text image
			TweenMax.to(
				copyright,
				1,
				{
					y: Starling.current.stage.stageHeight + 15, 
					alpha: 1, 
					ease: Back.easeOut, 
					delay: 0.7
				}
			);
			
			// slide right button start
			TweenMax.to(
				buttonStart,
				0.5,
				{
					x: 130,
					alpha: 1,
					ease: Back.easeOut,
					delay: 1
				}
			);
				
			// slide right button option
			TweenMax.to(
				buttonOption,
				0.5,
				{
					x:160,
					alpha:1,
					ease:Back.easeOut,
					delay:1.4
				}
			);
			
			// slide right button help
			TweenMax.to(
				buttonHelp,
				0.5,
				{
					x:170,
					alpha:1,
					ease:Back.easeOut,
					delay:1.8
				}
			);
			
			// slide right button exit
			TweenMax.to(
				buttonExit,
				0.5,
				{
					x: 180,
					alpha: 1,
					ease: Back.easeOut,
					delay: 2.2
				}
			);
			
			// slide up button link facebook
			TweenMax.to(
				buttonFacebook,
				0.3,
				{
					y: 470,
					alpha: 1,
					ease: Back.easeOut,
					delay: 2.2
				}
			);
			
			// slide up button link twitter
			TweenMax.to(
				buttonTwitter,
				0.3,
				{
					y:440,
					alpha:1,
					ease:Back.easeOut,
					delay:2.4
				}
			);
			
			// slide up button credit
			TweenMax.to(
				buttonCredit,
				0.3,
				{
					y:410,
					alpha:1,
					ease:Back.easeOut,
					delay:2.6
				}
			);
			
		}

		/**
		 * Main menu close transition.
		 *
		 * @return void
		 */
		private function closeTransition():void
		{
			// slide down button link credit
			TweenMax.to(
				buttonCredit,
				0.3,
				{
					y: 450,
					alpha: 0,
					ease: Back.easeOut
				}
			);
			
			// slide down button link twitter
			TweenMax.to(
				buttonTwitter,
				0.3,
				{
					y: 480,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.2
				}
			);
			
			// slide down button link facebook
			TweenMax.to(
				buttonFacebook,
				0.3,
				{
					y: 510,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.4
				}
			);
			
			// slide right and fade out button start
			TweenMax.to(
				buttonStart,
				0.4,
				{
					x: 180,
					alpha: 0,
					ease: Back.easeOut
				}
			);
			
			// slide right and fade out button option
			TweenMax.to(
				buttonOption,
				0.4,
				{
					x: 210,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.1
				}
			);
			
			// slide right and fade out button help
			TweenMax.to(
				buttonHelp,
				0.4,
				{
					x: 220,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.2
				}
			);
			
			// slide right and fade out button exit
			TweenMax.to(
				buttonExit,
				0.4,
				{
					x: 230,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.3
				}
			);
			
			// scale down and fade out logo 
			TweenMax.to(
				logo,
				1,
				{
					scaleX: 0,
					scaleY: 0,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.4
				}
			);
			
			// fade out the sun
			TweenMax.to(
				sun,
				1,
				{
					alpha: 0,
					delay: 0.2
				}
			);
			
			// slide down and fade out copyright text image
			TweenMax.to(
				copyright,
				0.4,
				{
					y: Starling.current.stage.stageHeight + copyright.height,
					alpha: 0,
					ease: Back.easeOut,
					delay: 0.4
				}
			);
			
			// fade menu background and decide if change state to game or setup if 
			// the game will play for the first time
			TweenMax.to(
				background,
				0.5,
				{
					alpha:0,
					delay:0.6,
					onComplete:function():void{
						if(Config.firstPlay) {
							LoadingTransition.destination = Game.CONFIGURATION_STATE;
						}
						else {
							LoadingTransition.destination = Game.PLAY_STATE;
						}
						game.changeState(Game.TRANSITION_STATE);
					}
				}
			);
		}

		/**
		 * Update current state.
		 *
		 * @return void
		 */
		public function update():void
		{
			// moving the sun from right to left and repeat when overlap the x
			if (sun.x > -sun.width)
			{
				sun.x -= 0.1;
			}
			else
			{
				sun.x = Starling.current.nativeStage.stageWidth + sun.width;
			}

			// update the rain if exist
			if (isRaining)
			{
				rainManager.update();
			}

			// update setting and tooltip location
			showTips.update();
			dialogOption.update();
		}

		/**
		 * Garbage collector destroy all compenent and reset varable
		 * @return void
		 */
		public function destroy():void
		{
			removeEventListener(TouchEvent.TOUCH, onMenuTouched);

			dialogOption.destroy();

			if (rainManager != null)
			{
				rainManager.destroy();
			}

			background.removeFromParent(true);
			sun.removeFromParent(true);
			copyright.removeFromParent(true);
			logo.removeFromParent(true);
			credit.removeFromParent(true);

			buttonStart.removeFromParent(true);
			buttonOption.removeFromParent(true);
			buttonHelp.removeFromParent(true);
			buttonExit.removeFromParent(true);

			buttonFacebook.removeFromParent(true);
			buttonTwitter.removeFromParent(true);
			buttonCredit.removeFromParent(true);

			removeFromParent(true);
		}

		/**
		 * Print main menu state.
		 * 
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.states.MainMenu";
		}
	}
}