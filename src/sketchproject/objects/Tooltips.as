package sketchproject.objects
{
	import sketchproject.core.Assets;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class Tooltips extends Sprite
	{
		private static var instance:Tooltips;
		
		public static const TIPS_LEFT:String = "left";
		public static const TIPS_RIGHT:String = "right";
		
		private var background:Image;
		private var textInfo:TextField;
		
		public function Tooltips()
		{
			super();
			
			background = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("tips"));
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
		
		public static function getInstance():Tooltips{
			if(instance == null){
				instance = new Tooltips();
			}
			return instance;
		}
		
		public function set info(textInfo:String):void{
			this.textInfo.text = textInfo;
		}
		
		public function get info():String{
			return this.textInfo.text;
		}
		
		public function tipsDirection(mode:String):void{
			if(mode == Tooltips.TIPS_LEFT){
				background.scaleX = 1;
				background.x = -10;
				textInfo.x = background.x;
			}
			else if(mode == Tooltips.TIPS_RIGHT){
				background.scaleX = -1;
				background.x = 30;
				textInfo.x = -background.width + 30;
			}			
		}
		
		public function showTips():void{
			visible = true;
		}
		
		public function hideTips():void{
			visible = false;
		}
		
		public function update():void
		{
			this.x = Starling.current.nativeOverlay.mouseX - 5;
			this.y = Starling.current.nativeOverlay.mouseY - 10;
		}
	}
}