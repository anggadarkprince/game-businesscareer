package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Emotion list adapter for customer panel.
	 *
	 * @author Angga
	 */
	public class EmotionAdapter extends Sprite
	{
		private var emotionIcon:Image;
		private var emotionText:TextField;
		private var descriptionText:TextField;
		private var valueText:TextField;

		/**
		 * Default constructor of EmotionAdapter.
		 *
		 * @param texture emotion icon
		 * @param emotion text of emotion
		 * @param description info how customers have this title
		 * @param value precentage of customer stats have this response
		 */
		public function EmotionAdapter(texture:String, emotion:String, description:String, value:int)
		{
			super();

			emotionIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture));
			this.addChild(emotionIcon);

			emotionText = new TextField(100, 50, emotion, Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0x333333);
			emotionText.hAlign = HAlign.LEFT;
			emotionText.vAlign = VAlign.TOP;
			emotionText.x = 70;
			emotionText.y = 5;
			this.addChild(emotionText);

			descriptionText = new TextField(200, 30, description, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			descriptionText.hAlign = HAlign.LEFT;
			descriptionText.vAlign = VAlign.TOP;
			descriptionText.x = 70;
			descriptionText.y = 30;
			this.addChild(descriptionText);

			valueText = new TextField(50, 30, String(value) + " %", Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0x333333);
			valueText.hAlign = HAlign.RIGHT;
			valueText.vAlign = VAlign.TOP;
			valueText.x = 250;
			valueText.y = 15;
			this.addChild(valueText);
		}

		/**
		 * Set emotion value.
		 *
		 * @param index
		 */
		public function set emotionValue(index:Number):void
		{
			this.emotionText.text = String(index) + " %";
		}

		/**
		 * Get emotioan value.
		 *
		 * @return
		 */
		public function get emotionValue():Number
		{
			return Number(this.emotionText.text);
		}
	}
}
