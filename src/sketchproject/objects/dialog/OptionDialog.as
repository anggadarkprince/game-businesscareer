package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkManager;
	import sketchproject.objects.Tooltips;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Setting game screen and sounds.
	 * 
	 * @author Angga
	 */
	public class OptionDialog extends Sprite
	{
		public static const SOUND_CHANGED:String = "soundchanged";
		public static var STATE_FULLSCREEN:String = "fullscreen";
		public static var STATE_WINDOW:String = "window";

		private static var instance:OptionDialog;

		private var overlay:Quad;
		private var background:Image;
		private var volumeValue:Image;
		private var buttonClose:Button;

		private var buttonPlusBgm:Button;
		private var buttonMinBgm:Button;
		private var buttonPlusSfx:Button;
		private var buttonMinSfx:Button;

		private var buttonWindow:Button;
		private var buttonFullscreen:Button;
		private var buttonConfirm:Button;
		private var buttonDiscard:Button;
		private var buttonFacebook:Button;
		private var buttonTwitter:Button;

		public static var volumeSfx:uint;
		public static var volumeBgm:uint;
		private var screen:String;

		private var sfxVolumeBar:Sprite;
		private var bgmVolumeBar:Sprite;

		private var fireworkManager:FireworkManager;

		private var showTips:Tooltips;

		/**
		 * Default constructor of OptionDialog.
		 */
		public function OptionDialog()
		{
			super();

			fireworkManager = new FireworkManager(Game.overlayStage);

			showTips = new Tooltips();
			showTips.tipsDirection(Tooltips.TIPS_LEFT);
			Game.overlayStage.addChild(showTips);

			volumeBgm = Config.volbgm;
			volumeSfx = Config.volsfx;
			screen = Config.mode;

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			background = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_option"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);

			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = background.width * 0.5 - 105;
			buttonClose.y = -background.height * 0.5 + 90;
			addChild(buttonClose);

			buttonPlusBgm = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonPlusBgm.pivotX = buttonPlusBgm.width * 0.5;
			buttonPlusBgm.pivotY = buttonPlusBgm.height * 0.5;
			buttonPlusBgm.x = 200;
			buttonPlusBgm.y = -68;
			addChild(buttonPlusBgm);

			buttonMinBgm = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonMinBgm.pivotX = buttonMinBgm.width * 0.5;
			buttonMinBgm.pivotY = buttonMinBgm.height * 0.5;
			buttonMinBgm.x = -31;
			buttonMinBgm.y = -68;
			addChild(buttonMinBgm);

			bgmVolumeBar = new Sprite();
			bgmVolumeBar.pivotY = buttonMinBgm.height * 0.5;
			bgmVolumeBar.x = -8;
			bgmVolumeBar.y = -67;
			addChild(bgmVolumeBar);

			buttonPlusSfx = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonPlusSfx.pivotX = buttonPlusSfx.width * 0.5;
			buttonPlusSfx.pivotY = buttonPlusSfx.height * 0.5;
			buttonPlusSfx.x = 200;
			buttonPlusSfx.y = -9;
			addChild(buttonPlusSfx);

			buttonMinSfx = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonMinSfx.pivotX = buttonMinSfx.width * 0.5;
			buttonMinSfx.pivotY = buttonMinSfx.height * 0.5;
			buttonMinSfx.x = -31;
			buttonMinSfx.y = -9;
			addChild(buttonMinSfx);

			sfxVolumeBar = new Sprite();
			sfxVolumeBar.pivotY = buttonMinSfx.height * 0.5;
			sfxVolumeBar.x = -8;
			sfxVolumeBar.y = -10;
			addChild(sfxVolumeBar);

			buttonWindow = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_window"));
			buttonWindow.pivotX = buttonWindow.width * 0.5;
			buttonWindow.pivotY = buttonWindow.height * 0.5;
			buttonWindow.x = 10;
			buttonWindow.y = 55;
			addChild(buttonWindow);

			buttonFullscreen = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_fullscreen"));
			buttonFullscreen.pivotX = buttonFullscreen.width * 0.5;
			buttonFullscreen.pivotY = buttonFullscreen.height * 0.5;
			buttonFullscreen.x = 145;
			buttonFullscreen.y = 55;
			addChild(buttonFullscreen);

			buttonDiscard = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_discard"));
			buttonDiscard.pivotX = buttonDiscard.width * 0.5;
			buttonDiscard.pivotY = buttonDiscard.height * 0.5;
			buttonDiscard.x = 20;
			buttonDiscard.y = 150;
			addChild(buttonDiscard);

			buttonConfirm = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_confirm"));
			buttonConfirm.pivotX = buttonConfirm.width * 0.5;
			buttonConfirm.pivotY = buttonConfirm.height * 0.5;
			buttonConfirm.x = 150;
			buttonConfirm.y = 150;
			addChild(buttonConfirm);

			buttonFacebook = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_social_facebook"));
			buttonFacebook.pivotX = buttonFacebook.width * 0.5;
			buttonFacebook.pivotY = buttonFacebook.height * 0.5;
			buttonFacebook.x = -185;
			buttonFacebook.y = 145;
			addChild(buttonFacebook);

			buttonTwitter = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_social_twitter"));
			buttonTwitter.pivotX = buttonTwitter.width * 0.5;
			buttonTwitter.pivotY = buttonTwitter.height * 0.5;
			buttonTwitter.x = -120;
			buttonTwitter.y = 145;
			addChild(buttonTwitter);

			addEventListener(TouchEvent.TOUCH, onButtonTouched);
			buttonFullscreen.addEventListener(TouchEvent.TOUCH, modeFullscreen);
			buttonWindow.addEventListener(TouchEvent.TOUCH, modeWindow);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;

			updateSetting();
		}

		/**
		 * Singeleton pattern.
		 * 
		 * @return instance of OptionDialog
		 */
		public static function getInstance():OptionDialog
		{
			if (instance == null)
			{
				instance = new OptionDialog();
			}
			return instance;
		}

		/**
		 * Open / show dialog transition.
		 * 
		 * @return void
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			updateSetting();
			visible = true;
			TweenMax.to(this, 0.7, {ease: Back.easeOut, scaleX: 1, scaleY: 1, alpha: 1, delay: 0.2});
		}

		/**
		 * Close / hide dialog transition.
		 * 
		 * @return void
		 */
		public function closeDialog():void
		{
			Assets.setupGameSound();
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			TweenMax.to(
				this, 
				0.5, 
				{
					ease: Back.easeIn, 
					scaleX: 0.5, 
					scaleY: 0.5, 
					alpha: 0, 
					delay: 0.2, 
					onComplete: function():void {
						visible = false;
					}
				}
			);
		}

		/**
		 * Switch screen to fullscreen mode with call native stage.
		 * 
		 * @params e passing touch event
		 * @return void
		 */
		private function modeFullscreen(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if (!touch)
				return;
			if (touch.phase == TouchPhase.BEGAN)
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, fullScreen);
			}
		}

		/**
		 * Switch screen to window mode with call native stage.
		 * 
		 * @params e passing touch event
		 * @return void
		 */
		private function modeWindow(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if (!touch)
				return;
			if (touch.phase == TouchPhase.BEGAN)
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, window);
			}
		}

		/**
		 * Switch stage to fullscreen
		 * @params $e passing mouse event
		 * @return void
		 */
		private function fullScreen(e:MouseEvent):void
		{
			Starling.current.nativeStage.removeEventListener(MouseEvent.MOUSE_UP, fullScreen);
			Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN;
			Config.mode = OptionDialog.STATE_FULLSCREEN;
		}

		/**
		 * Switch stage to window
		 * @params $e passing mouse event
		 * @return void
		 */
		private function window(e:MouseEvent):void
		{
			Starling.current.nativeStage.removeEventListener(MouseEvent.MOUSE_UP, window);
			Starling.current.nativeStage.displayState = StageDisplayState.NORMAL;
			Config.mode = OptionDialog.STATE_WINDOW;
		}

		/**
		 * Action triggered by touching dialog.
		 * 
		 * @params touch passing touch event
		 * @return void
		 */
		private function onButtonTouched(touch:TouchEvent):void
		{
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
			else
			{
				showTips.hideTips();
			}

			if (touch.getTouch(buttonFacebook, TouchPhase.ENDED))
			{
				var request:URLRequest;
				request = new URLRequest("http://www.facebook.com/page/businesscareer");
				try
				{
					navigateToURL(request, '_blank');
				}
				catch (e:Error)
				{
					trace("Link error occurred!" + e.message);
				}
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}

			if (touch.getTouch(buttonTwitter, TouchPhase.ENDED))
			{
				request = new URLRequest("http://www.twitter.com/businesscareer");
				try
				{
					navigateToURL(request, '_blank');
				}
				catch (e:Error)
				{
					trace("Link error occurred!" + e.message);
				}
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}

			if (touch.getTouch(buttonPlusBgm, TouchPhase.ENDED))
			{
				if (bgmVolume < 10)
				{
					bgmVolume = bgmVolume + 1;
					Assets.setupGameSound();
					updateSetting();
				}
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}
			
			if (touch.getTouch(buttonMinBgm, TouchPhase.ENDED))
			{
				if (bgmVolume > 0)
				{
					bgmVolume = bgmVolume - 1;
					Assets.setupGameSound();
					updateSetting();
				}
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}

			if (touch.getTouch(buttonPlusSfx, TouchPhase.ENDED))
			{
				if (sfxVolume < 10)
				{
					sfxVolume = sfxVolume + 1;
					Assets.setupGameSound();
					updateSetting();
				}
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}
			
			if (touch.getTouch(buttonMinSfx, TouchPhase.ENDED))
			{
				if (sfxVolume > 0)
				{
					sfxVolume = sfxVolume - 1;
					Assets.setupGameSound();
					updateSetting();
				}
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}

			if (touch.getTouch(buttonConfirm, TouchPhase.ENDED))
			{
				Config.volbgm = volumeBgm;
				Config.volsfx = volumeSfx;
				Config.mode = screen;
				closeDialog();
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				dispatchEvent(new Event(OptionDialog.SOUND_CHANGED));
			}

			if (touch.getTouch(buttonDiscard, TouchPhase.ENDED))
			{
				volumeBgm = Config.volbgm;
				volumeSfx = Config.volsfx;
				screen = Config.mode;
				closeDialog();
				updateSetting();
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}

			if (touch.getTouch(buttonClose, TouchPhase.ENDED))
			{
				volumeBgm = Config.volbgm;
				volumeSfx = Config.volsfx;
				screen = Config.mode;
				closeDialog();
				updateSetting();
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			}
		}

		/**
		 * Update tooltips location.
		 */
		public function update():void
		{
			showTips.update();
		}

		/**
		 * SFX setter.
		 * 
		 * @params volume new volume
		 * @return void
		 */
		public function set sfxVolume(volume:uint):void
		{
			volumeSfx = volume;
		}

		/**
		 * SFX getter
		 * @return SFX volume
		 */
		public function get sfxVolume():uint
		{
			return volumeSfx;
		}

		/**
		 * BGM setter
		 * @params volume new volume
		 * @return void
		 */
		public function set bgmVolume(volume:uint):void
		{
			volumeBgm = volume;
		}

		/**
		 * BGM getter
		 * @return BGM volume
		 */
		public function get bgmVolume():uint
		{
			return volumeBgm;
		}

		/**
		 * Screen state setter.
		 * 
		 * @params state new screen state
		 * @return void
		 */
		public function set screenState(state:String):void
		{
			screen = state;
		}

		/**
		 * Screen state getter.
		 * 
		 * @return screen current state
		 */
		public function get screenState():String
		{
			return screen;
		}

		/**
		 * Update current sound setting.
		 * 
		 * @return void
		 */
		public function updateSetting():void
		{
			bgmVolumeBar.removeChildren();
			for (var i:uint = 0; i < bgmVolume; i++)
			{
				volumeValue = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));
				volumeValue.x = (volumeValue.width + 5) * i;
				bgmVolumeBar.addChild(volumeValue);
			}
			
			sfxVolumeBar.removeChildren();
			for (var j:uint = 0; j < sfxVolume; j++)
			{
				volumeValue = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));
				volumeValue.x = (volumeValue.width + 5) * j;
				sfxVolumeBar.addChild(volumeValue);
			}
		}

		/**
		 * Remove all resources.
		 */
		public function destroy():void
		{
			showTips.removeFromParent(true);
			removeFromParent(true);
		}
	}
}
