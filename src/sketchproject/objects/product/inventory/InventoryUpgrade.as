package sketchproject.objects.product.inventory
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class InventoryUpgrade extends Sprite
	{
		private var title:TextField;
		
		private var bar:Quad;
		private var itemContainer:Sprite;
		private var starContainer:Sprite;
		private var label:TextField;
		private var upgrade:Image;
		
		public function InventoryUpgrade()
		{
			super();
			
			title = new TextField(200, 50, "Item Upgraded", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			title.hAlign = HAlign.LEFT;
			addChild(title);
			
			itemContainer = new Sprite();
			itemContainer.x = 50;
			itemContainer.y = 60;			
			addChild(itemContainer);
			
		}
		
		public function update():void
		{
			itemContainer.removeChildren();
			
			for(var i:int = 0; i<Data.asset.length;i++)
			{
				bar = new Quad(100, 120, 0x212121);
				bar.x = i%3 * 120;
				bar.y = Math.floor(i/3) * 140;
				itemContainer.addChild(bar);
				
				bar = new Quad(100, 30, 0x141414);
				bar.x = i%3 * 120;
				bar.y = Math.floor(i/3) * 140 + 90;
				itemContainer.addChild(bar);
				
				upgrade = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[i][3]));
				upgrade.pivotX = upgrade.width * 0.5;
				upgrade.pivotY = upgrade.height * 0.5;
				upgrade.x = (i%3 * 120) + (bar.width * 0.5);
				upgrade.y = Math.floor(i/3) * 140 + 35;
				upgrade.scaleX = 0.4;
				upgrade.scaleY = 0.4;
				itemContainer.addChild(upgrade);
				
				label = new TextField(150, 30, Data.asset[i][2], Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
				label.pivotX = label.width * 0.5;
				label.pivotY = label.height * 0.5;
				label.hAlign = HAlign.CENTER;
				label.vAlign = VAlign.TOP;
				label.x = i%3 * 120 + (bar.width * 0.5);
				label.y = Math.floor(i/3) * 140 + 80;
				itemContainer.addChild(label);
				
				starContainer = new Sprite();
				
				for(var j:int = 0; j<3; j++)
				{
					if(j < Data.asset[i][4])
					{
						upgrade = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_orange"));	
					}					
					else
					{
						upgrade = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_dark"));
					}
					upgrade.x = j * 30;
					
					starContainer.addChild(upgrade);						
				}
				starContainer.pivotX = starContainer.width * 0.5;
				starContainer.pivotY = starContainer.height * 0.5;				
				starContainer.x = (i%3 * 120) + (bar.width * 0.5);
				starContainer.y = (Math.floor(i/3) * 140 + 90) + (bar.height * 0.5);
				itemContainer.addChild(starContainer);
			}
		}
	}
}