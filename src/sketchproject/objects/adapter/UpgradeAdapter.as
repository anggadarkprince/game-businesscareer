package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class UpgradeAdapter extends MaterialAdapter
	{
		public static const UPGRADE_ITEM:String = "upgrade";
		
		private var itemType:String;
		private var itemLevel:int;
		private var itemPrice:int;
		
		private var labelText:TextField;
		private var priceText:TextField;
		private var descriptionText:TextField;
		private var starContainer:Sprite;
		
		private var buyBar:Quad;
		
						
		public function UpgradeAdapter(index:int, id:int, type:String, name:String, texture:String, price:int, level:int, desription:String)
		{
			super(index, 0, id, name, 0, 0, texture);
			
			this.itemLevel = level;
			this.itemPrice = price;
			this.itemType = type;
			
			removeButton.visible = false;
			expiredText.visible = false;
			quantityText.visible = false;
			itemBar.visible = false;
			
			bar.width = 180;
			bar.height = 340;
			
			bar = new Quad(180, 30, 0xff4a4e);
			bar.y = 0;
			addChild(bar);
			
			labelText = new TextField(180, 25, type.toUpperCase(), Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 0;
			addChild(labelText);
			
			bar = new Quad(180, 30, 0xff4a4e);
			bar.y = 320;
			addChild(bar);
			
			labelText = new TextField(180, 25, "UPGRADE ITEM", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 320;
			addChild(labelText);
			
			buyBar = new Quad(180, 30, 0xff4a4e);
			buyBar.y = 320;
			buyBar.alpha = 0;
			addChild(buyBar);
			
			itemImage.pivotX = itemImage.width * 0.5;
			itemImage.x = 180 * 0.5;
			itemImage.y = 35;
					
			
			labelText = new TextField(180, 25, "UPGRADE", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xff4a4e);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 100;
			addChild(labelText);
			
			nameLabel.x = 0;
			nameLabel.y = 115;
			nameLabel.width = 180;
			nameLabel.fontSize = 18;
			nameLabel.hAlign = HAlign.CENTER;
			nameLabel.fontName = Assets.getFont(Assets.FONT_SSBOLD).fontName;
			
			labelText = new TextField(180, 25, "DESCRIPTION", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xff4a4e);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 140;
			addChild(labelText);
			
			descriptionText = new TextField(180, 50, desription, Assets.getFont(Assets.FONT_SSBOLD).fontName, 12, 0xFFFFFF);			
			descriptionText.hAlign = HAlign.CENTER;
			descriptionText.vAlign = VAlign.TOP;
			descriptionText.y = 155;
			addChild(descriptionText);
			
			labelText = new TextField(180, 25, "PRICE", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xff4a4e);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 220;
			addChild(labelText);
			
			priceText = new TextField(180, 25, "IDR "+ValueFormatter.format(itemPrice), Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			priceText.hAlign = HAlign.CENTER;
			priceText.y = 235;
			addChild(priceText);
			
			labelText = new TextField(180, 25, "LEVEL", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xff4a4e);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 260;
			addChild(labelText);
			
			starContainer = new Sprite();			
			var levelStar:Image;
			for(var j:int = 0; j<3; j++)
			{
				if(j < level)
				{
					levelStar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_orange"));	
				}					
				else
				{
					levelStar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_dark"));
				}
				levelStar.x = j * 30;
				
				starContainer.addChild(levelStar);						
			}
			starContainer.pivotX = starContainer.width * 0.5;
			starContainer.x = bar.width * 0.5;
			starContainer.y = 282;
			addChild(starContainer);
			
			buyBar.addEventListener(TouchEvent.TOUCH, onItemSelected);
		}
		
		private function onItemSelected(touch:TouchEvent):void
		{
			if(touch.getTouch(buyBar,TouchPhase.ENDED)){
				dispatchEvent(new Event(UpgradeAdapter.UPGRADE_ITEM));
			}
		}
		
		public function maximumLevel():void
		{
			itemImage.visible = false;
			
			bar = new Quad(180, 340, 0x212121);
			bar.alpha = 0.8;
			addChild(bar);
			
			labelText = new TextField(180, 25, "MAXIMUM UPGRADE", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xff4a4e);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 30;
			addChild(labelText);
			
			labelText = new TextField(180, 25, "REACHED", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0xff4a4e);			
			labelText.hAlign = HAlign.CENTER;
			labelText.y = 50;
			addChild(labelText);
		}
		
		public function set type(itemType:String):void{
			this.itemType = itemType;
		}
		
		public function get type():String{
			return itemType;
		}
		
		public function set level(itemLevel:int):void{
			this.itemLevel = itemLevel;
		}
		
		public function get level():int{
			return itemLevel;
		}
		
		public function set price(itemPrice:int):void{
			this.itemPrice = itemPrice;
			this.priceText.text = "IDR "+ValueFormatter.format(itemPrice);
		}
		
		public function get price():int{
			return itemPrice;
		}
		
	}
}