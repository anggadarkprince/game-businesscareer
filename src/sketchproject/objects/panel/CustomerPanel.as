package sketchproject.objects.panel
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.objects.adapter.EmotionAdapter;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class CustomerPanel extends Panel
	{
		private var label:TextField;
		private var backgroundAvatar:Image;
		private var emotionList:Sprite;
		private var emotion:EmotionAdapter;
		private var bar:Quad;
		
		public function CustomerPanel()
		{
			super(
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_lightning"),
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("title_customer"),
				"Earn customer active by analysis customer relationship and advertising "
			);
			
			backgroundAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("advisor_shaka_ringgo"));
			backgroundAvatar.x = 250;
			backgroundAvatar.y = -160;
			this.addChild(backgroundAvatar);
			
			label = new TextField(200, 50, "Customer Emotion", Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -430;
			label.y = -175;
			addChild(label);
			
			emotionList = new Sprite();
			emotionList.x = -430;
			emotionList.y = -130;			
			addChild(emotionList);
			
			label = new TextField(200, 50, "Market Share", Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -50;
			label.y = -175;
			addChild(label);
			
			update();
						
		}
		
		public function update():void
		{
			emotionList.removeChildren();
			
			for(var i:int = 0; i<Config.emotion.length; i++){
				emotion = new EmotionAdapter(Config.emotion[i][0], Config.emotion[i][1], Config.emotion[i][2], Config.emotion[i][3]);
				emotion.y = i * emotion.height;
				emotionList.addChild(emotion);
			}
			
			bar = new Quad(250,300,0xFFFFFF);
			bar.x = 380;
			bar.y = 0;
			emotionList.addChild(bar);
			
			bar = new Quad(210,2,0xDDDDDD);
			bar.x = 400;
			bar.y = 50;
			emotionList.addChild(bar);
			
			bar = new Quad(210,2,0xDDDDDD);
			bar.x = 400;
			bar.y = 100;
			emotionList.addChild(bar);
			
			bar = new Quad(210,2,0xDDDDDD);
			bar.x = 400;
			bar.y = 150;
			emotionList.addChild(bar);
			
			bar = new Quad(210,2,0xDDDDDD);
			bar.x = 400;
			bar.y = 200;
			emotionList.addChild(bar);
			
			bar = new Quad(210,5,0x333333);
			bar.x = 400;
			bar.y = 215;
			emotionList.addChild(bar);
			
			for(var j:int = 0; j<Config.marketShare.length; j++){
				var barHeight:Number = 1;
				if(Config.marketShare[j][0] > 0){
					barHeight = 200/100*Config.marketShare[j][0];
				}
				bar = new Quad(50,barHeight,Config.marketShare[j][1]);
				bar.x = j * 70 + 410;
				bar.y = 200 - bar.height;
				emotionList.addChild(bar);
				
				label = new TextField(100, 50, Config.marketShare[j][0] + "%", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
				label.hAlign = HAlign.CENTER;
				label.vAlign = VAlign.TOP;
				label.pivotX = label.width * 0.5;
				label.pivotY = label.width * 0.5;
				label.x = bar.x + bar.width * 0.5;
				label.y = bar.y + 20;
				emotionList.addChild(label);
				
				bar = new Quad(10,10,Config.marketShare[j][1]);
				bar.x = j * 70 + 410 +20;
				bar.y = 230;
				emotionList.addChild(bar);
				
				label = new TextField(100, 50, Config.marketShare[j][2], Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
				label.hAlign = HAlign.CENTER;
				label.vAlign = VAlign.TOP;
				label.pivotX = label.width * 0.5;
				label.pivotY = label.width * 0.5;
				label.x = bar.x + bar.width * 0.5;
				label.y = 300;
				emotionList.addChild(label);
			}
		}
		
	}
}