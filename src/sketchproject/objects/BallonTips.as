package sketchproject.objects
{
	import sketchproject.core.Assets;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	/**
	 * Show ballon tips and messages.
	 *
	 * @author Angga
	 */
	public class Ballontips extends Sprite
	{
		public static const FLIP_RIGHT:String = "right";
		public static const FLIP_LEFT:String = "left";

		private var background:Image;
		private var tips:TextField;

		/**
		 * Default constructor of Ballontips.
		 *
		 * @param tip info
		 * @param flipRight direction of ballon
		 * @param textLarge show large font
		 */
		public function Ballontips(tip:String = "No Tips", flipRight:Boolean = false, textLarge:Boolean = false)
		{
			super();

			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("ballontips"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);

			tips = new TextField(90, 100, tip, Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			tips.pivotX = tips.width * 0.5;
			tips.pivotY = tips.height * 0.5;
			tips.y = -5;
			addChild(tips);

			if (flipRight)
			{
				this.background.scaleX = -1;
			}
			if (textLarge)
			{
				tips.fontSize = 18;
			}
		}

		/**
		 * Set message or info.
		 *
		 * @param message
		 */
		public function set tip(message:String):void
		{
			this.tips.text = message;
		}

		/**
		 * Get message or info.
		 *
		 * @return
		 */
		public function get tip():String
		{
			return tips.text;
		}

		/**
		 * Flip ballon direction.
		 *
		 * @param direction
		 */
		public function flipBallon(direction:String = "left"):void
		{
			if (direction == Ballontips.FLIP_LEFT)
			{
				this.background.scaleX = 1;
			}
			else
			{
				this.background.scaleX = -1;
			}
		}
	}
}
