package sketchproject.objects
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class BallonTips extends Sprite
	{
		public static const FLIP_RIGHT:String = "right";
		public static const FLIP_LEFT:String = "left";
		
		private var background:Image;
		private var tips:TextField;
				
		public function BallonTips(tip:String = "No Tips", flipRight:Boolean = false, textLarge:Boolean = false)
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
			
			if(flipRight){
				this.background.scaleX = -1;
			}
			if(textLarge){
				tips.fontSize = 18;
			}
		}
		
		public function set tip(message:String):void
		{
			this.tips.text = message;
		}
		
		public function get tip():String
		{
			return tips.text;
		}
		
		public function flipBallon(direction:String = "left"):void
		{
			if(direction == BallonTips.FLIP_LEFT)
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