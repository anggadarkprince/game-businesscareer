package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.CelebrateManager;
	import sketchproject.managers.FireworkManager;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;

	/**
	 * Dialog when complete the tasks.
	 * 
	 * @author Angga
	 */
	public class CompleteDialog extends Sprite implements IDialog
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var dialogIcon:Image;
		private var info:TextField;
		private var buttonOK:Button;

		private var celebrateManager:CelebrateManager;
		private var celebrateContainer:Sprite;

		private var fireworkManager:FireworkManager;
		private var fireworksTimer:Timer;

		/**
		 * Default constructor of CompleteDialog.
		 * 
		 * @param textInfo
		 */
		public function CompleteDialog(textInfo:String = "No Task Info")
		{
			super();

			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			celebrateContainer = new Sprite();
			celebrateContainer.x = -Starling.current.nativeStage.stageWidth * 0.5;
			celebrateContainer.y = -Starling.current.nativeStage.stageHeight * 0.5;
			addChild(celebrateContainer);

			celebrateManager = new CelebrateManager(celebrateContainer);

			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_new_congratulation"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);

			dialogIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_task_complete"));
			dialogIcon.pivotX = dialogIcon.width * 0.5;
			dialogIcon.pivotY = dialogIcon.height * 0.5;
			dialogIcon.y = -80;
			dialogIcon.scaleX = 0.8;
			dialogIcon.scaleY = 0.8;
			addChild(dialogIcon);

			info = new TextField(250, 150, textInfo, Assets.getFont(Assets.FONT_CORegular).fontName, 17, 0xFFFFFF);
			info.pivotX = info.width * 0.5;
			info.y = -5;
			info.vAlign = VAlign.TOP;
			addChild(info);

			buttonOK = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok_outline"));
			buttonOK.pivotX = buttonOK.width * 0.5;
			buttonOK.pivotY = buttonOK.height * 0.5;
			buttonOK.scaleX = 0.75;
			buttonOK.scaleY = 0.75;
			buttonOK.y = 100;
			buttonOK.addEventListener(Event.TRIGGERED, onPrimaryTrigerred);
			addChild(buttonOK);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;

			fireworksTimer = new Timer(1500);
			fireworksTimer.addEventListener(TimerEvent.TIMER, onFireworksTriggered);
		}

		/**
		 * Spawn fireworks each 1500 ms.
		 * 
		 * @param event
		 */
		protected function onFireworksTriggered(event:TimerEvent):void
		{
			Assets.sfxChannel = Assets.sfxFireworks.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Math.random() * Starling.current.stage.stageWidth, Math.random() * Starling.current.stage.stageHeight);
		}

		/**
		 * Set task complete info.
		 * 
		 * @param info
		 */
		public function set completeInfo(info:String):void
		{
			this.info.text = info;
		}

		/**
		 * Get task complete info.
		 * 
		 * @return
		 */
		public function get completeInfo():String
		{
			return this.info.text;
		}

		/**
		 * Open / show complete dialog
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxHarp.play(0, 0, Assets.sfxTransform);
			fireworksTimer.start();
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					delay: 0.4, 
					onComplete: function():void {
						fireworkManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5);
					}
				}
			);
		}

		/**
		 * Close / hide complete dialog
		 */
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworksTimer.stop();
			TweenMax.to(
				this, 
				0.5, 
				{
					ease: Back.easeIn, 
					scaleX: 0.5, 
					scaleY: 0.5, 
					alpha: 0, 
					onComplete: function():void {
						visible = false;
					}
				}
			);
		}

		/**
		 * Confirm complete task dialog.
		 * 
		 * @param event
		 */
		public function onPrimaryTrigerred(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			closeDialog();
		}

		/**
		 * Update celebrating manager.
		 * 
		 * @return void
		 */
		public function update():void
		{
			celebrateManager.update();
		}


		/**
		 * Release resources.
		 * 
		 * @return void
		 */
		public function destroy():void
		{
			celebrateManager.destroy();
			removeFromParent(true);
		}
	}
}
