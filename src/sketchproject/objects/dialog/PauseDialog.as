package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.ServerManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Pause menu dialog to return to the main menu and logout.
	 * 
	 * @author Angga
	 */
	public class PauseDialog extends Sprite
	{
		private var overlay:Quad;
		private var background:Image;
		private var buttonResume:Button;
		private var buttonOption:Button;
		private var buttonMenu:Button;
		private var buttonLogout:Button;

		private var dialogBack:NativeDialog = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Back To Menu", "Kembali ke Main Menu?");
		private var dialogLogout:NativeDialog = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Logout Confirmation", "Kamu yakin ingin sign out?");

		private var game:Game;
		private var option:OptionDialog;

		private var fireworkManager:FireworkManager;

		/**
		 * Default constructor of PauseDialog.
		 * 
		 * @param game root
		 * @param option dialog
		 */
		public function PauseDialog(game:Game, option:OptionDialog)
		{
			super();

			this.game = game;
			this.option = option;

			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			initObjectProperty();
		}

		/**
		 * Initialize pause dialog components.
		 */
		public function initObjectProperty():void
		{
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			background = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_pause"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);

			buttonResume = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_resume"));
			buttonResume.pivotX = buttonResume.width * 0.5;
			buttonResume.pivotY = buttonResume.height * 0.5;
			buttonResume.y = -70;
			addChild(buttonResume);

			buttonOption = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_option"));
			buttonOption.pivotX = buttonResume.width * 0.5;
			buttonOption.pivotY = buttonResume.height * 0.5;
			buttonOption.y = 10;
			addChild(buttonOption);

			buttonMenu = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_menu"));
			buttonMenu.pivotX = buttonResume.width * 0.5;
			buttonMenu.pivotY = buttonResume.height * 0.5;
			buttonMenu.y = 90;
			addChild(buttonMenu);

			buttonLogout = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_logout"));
			buttonLogout.pivotX = buttonResume.width * 0.5;
			buttonLogout.pivotY = buttonResume.height * 0.5;
			buttonLogout.y = 170;
			addChild(buttonLogout);

			buttonResume.addEventListener(Event.TRIGGERED, onGameResumed);
			buttonOption.addEventListener(Event.TRIGGERED, onOptionCalled);
			buttonMenu.addEventListener(Event.TRIGGERED, onMenuCalled);
			buttonLogout.addEventListener(Event.TRIGGERED, onLogout);

			dialogBack.addEventListener(DialogBoxEvent.CLOSED, onMenuDialogClosed);
			addChild(dialogBack);

			dialogLogout.addEventListener(DialogBoxEvent.CLOSED, onLogoutDialogClosed);
			addChild(dialogLogout);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}

		/**
		 * Resume and close dialog.
		 * 
		 * @param event
		 */
		private function onGameResumed(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			closeDialog();
		}

		/**
		 * Open dialog option.
		 * 
		 * @param event
		 */
		private function onOptionCalled(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			option.openDialog();
		}

		/**
		 * Back to menu clicked.
		 * 
		 * @param event
		 */
		private function onMenuCalled(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			dialogBack.openDialog();
		}

		/**
		 * Logout button clicked.
		 * 
		 * @param event
		 */
		private function onLogout(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			Assets.sfxChannel = Assets.sfxLogout.play(0,0,Assets.sfxTransform);
			dialogLogout.openDialog();
		}

		/**
		 * Event handler confirm back to menu.
		 * 
		 * @param event
		 */
		private function onMenuDialogClosed(event:DialogBoxEvent):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			if (event.result)
			{
				closeDialog();
				game.changeState(Game.MENU_STATE);
			}
			else
			{
				dialogBack.closeDialog();
			}
		}

		/**
		 * Event handler confirm logout.
		 * 
		 * @param event dialog event
		 */
		private function onLogoutDialogClosed(event:DialogBoxEvent):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			if (event.result)
			{
				var request:URLRequest = new URLRequest(ServerManager.SERVER_HOST + "/player/logout");
				try
				{
					closeDialog();
					navigateToURL(request, '_self');
				}
				catch (e:Error)
				{
					trace("Link error occurred!" + e.message);
				}
			}
			else
			{
				dialogLogout.closeDialog();
			}
		}

		/**
		 * Open / show pause dialog.
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					delay: 0.2
				}
			);
		}

		/**
		 * Close / hide pause dialog.
		 */
		public function closeDialog():void
		{
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
	}
}
