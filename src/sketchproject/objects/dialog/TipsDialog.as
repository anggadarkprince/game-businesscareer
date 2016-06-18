package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkManager;
	import sketchproject.utilities.GameUtils;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Show tips of the day dialog by business advisor.
	 * 
	 * @author Angga
	 */
	public class TipsDialog extends Sprite
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var buttonPrimary:Button;
		private var tips:TextField;		
		private var fireworkManager:FireworkManager;

		/**
		 * Default constructor of TipsDialog.
		 * 
		 * @param tipsOfTheDay
		 */
		public function TipsDialog(tipsOfTheDay:String = "No Tips")
		{
			super();

			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_tips"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);

			tips = new TextField(340, 150, tipsOfTheDay, Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x222222);
			tips.hAlign = HAlign.LEFT;
			tips.vAlign = VAlign.TOP;
			tips.x = -110;
			tips.y = -65;
			addChild(tips);

			buttonPrimary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
			buttonPrimary.pivotX = buttonPrimary.width * 0.5;
			buttonPrimary.pivotY = buttonPrimary.height * 0.5;
			buttonPrimary.y = 70;
			addChild(buttonPrimary);

			buttonPrimary.addEventListener(Event.TRIGGERED, onPrimaryTrigerred);

			this.scaleX = 0.5;
			this.scaleY = 0.5;
			this.alpha = 0;
			this.visible = false;
		}

		/**
		 * Set tips of the day.
		 * 
		 * @param tips
		 */
		public function set tipsOfTheDay(tips:String):void
		{
			this.tips.text = tips;
		}

		/**
		 * Get tips of the day.
		 * 
		 * @return
		 */
		public function get tipsOfTheDay():String
		{
			return tips.text;
		}

		/**
		 * Secondary button event / [YES]-[OK] Button.
		 * 
		 * @params event passing triggered event
		 */
		public function onPrimaryTrigerred(event:Event):void
		{
			closeDialog();
		}

		/**
		 * Native dialog open / show transition.
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			visible = true;
			TweenMax.to(this, 0.7, {ease: Back.easeOut, scaleX: 1, scaleY: 1, alpha: 1, delay: 0.2});
		}

		/**
		 * Native dialog close / hide transition
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

		/**
		 * Generate random tips.
		 */
		public function generateTips():void
		{
			var index:int = GameUtils.randomFor(Config.tipsOfTheDay.length) - 1;
			tips.text = "[" + Config.tipsOfTheDay[index][1] + "]\n" + Config.tipsOfTheDay[index][2];
		}
	}
}
