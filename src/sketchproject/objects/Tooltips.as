package sketchproject.objects
{
	import sketchproject.core.Assets;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Tooltip to show information menu.
	 *
	 * @author Angga
	 */
	public class Tooltips extends Sprite
	{
		public static const TIPS_LEFT:String = "left";
		public static const TIPS_RIGHT:String = "right";

		private static var instance:Tooltips;

		private var background:Image;
		private var textInfo:TextField;

		/**
		 * Default constructor of tooltips.
		 */
		public function Tooltips()
		{
			super();

			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("tips"));
			background.x = -10;
			background.y = -30;
			addChild(background);

			textInfo = new TextField(background.width, 20, "Default Tooltips", Assets.getFont(Assets.FONT_DMIERAS).fontName, 12, 0x333333);
			textInfo.x = background.x;
			textInfo.y = -28;
			textInfo.hAlign = HAlign.CENTER;
			addChild(textInfo);

			hideTips();
		}

		/**
		 * Singleton instatiation.
		 *
		 * @return Tooltips object
		 */
		public static function getInstance():Tooltips
		{
			if (instance == null)
			{
				instance = new Tooltips();
			}
			return instance;
		}

		/**
		 * Set tooltip info text.
		 *
		 * @param textInfo string text
		 */
		public function set info(textInfo:String):void
		{
			this.textInfo.text = textInfo;
		}

		/**
		 * Get tooltip info text.
		 *
		 * @return string text
		 */
		public function get info():String
		{
			return this.textInfo.text;
		}

		/**
		 * Flip or set tooltips background image.
		 *
		 * @param mode left or right direction.
		 */
		public function tipsDirection(mode:String):void
		{
			if (mode == Tooltips.TIPS_LEFT)
			{
				background.scaleX = 1;
				background.x = -10;
				textInfo.x = background.x;
			}
			else if (mode == Tooltips.TIPS_RIGHT)
			{
				background.scaleX = -1;
				background.x = 30;
				textInfo.x = -background.width + 30;
			}
		}

		/**
		 * Show tooltips.
		 */
		public function showTips():void
		{
			visible = true;
		}

		/**
		 * Hide tooltips.
		 */
		public function hideTips():void
		{
			visible = false;
		}

		/**
		 * Update tooltips location depends on mouse location and push little bit further.
		 */
		public function update():void
		{
			this.x = Starling.current.nativeOverlay.mouseX - 5;
			this.y = Starling.current.nativeOverlay.mouseY - 10;
		}
	}
}
