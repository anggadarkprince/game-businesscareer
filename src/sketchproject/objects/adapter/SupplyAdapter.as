package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class SupplyAdapter extends MaterialAdapter
	{
		public static const BUY_SUPPLY:String = "buy";
		
		protected var itemPrice:int;
		
		private var buyBar:Button;
		private var priceText:TextField;
		private var labelText:TextField;
		
		private var background:Image;
		
		public function SupplyAdapter(index:int, id:int, name:String, texture:String, itemPrice:int, itemExpired:int, itemQuantity:int)
		{
			super(index, 0, id, name, itemExpired, itemQuantity, texture);
						
			this.itemPrice = itemPrice;
			
			itemBar.visible =false;
			bar.visible = false;
			
			itemImage.y = 15;
			
			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("box_supplier"));
			background.x = -30;
			background.y = -10;
			addChildAt(background,0);
			
			expiredText.x = 0;
			expiredText.text = itemExpired + " Days";
			
			quantityText.x = 190;
			quantityText.text = itemQuantity + " PCS";
						
			buyBar = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_buy"));
			buyBar.x = 180;
			buyBar.y = 70;
			addChild(buyBar);
			
			removeButton.visible = false;
									
			labelText = new TextField(200, 25, "Expired", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0xFFFFFF);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = 70;
			labelText.y = 30;
			addChild(labelText);
			
			labelText = new TextField(200, 25, "Available", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0xFFFFFF);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = 125;
			labelText.y = 30;
			addChild(labelText);
			
			labelText = new TextField(200, 25, "Price", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0xFFFFFF);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = 190;
			labelText.y = 30;
			addChild(labelText);
			
			
			expiredText.x = 70;
			expiredText.y = 45;
			expiredText.fontSize = 14;
			expiredText.fontName = Assets.getFont(Assets.FONT_SSBOLD).fontName;
			
			quantityText.x = 125;
			quantityText.y = 45;
			quantityText.fontSize = 14;
			quantityText.fontName = Assets.getFont(Assets.FONT_SSBOLD).fontName;
			
			priceText = new TextField(200, 25, "IDR "+ValueFormatter.format(itemPrice), Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
			priceText.hAlign = HAlign.LEFT;
			priceText.x = 190;
			priceText.y = 45;
			addChild(priceText);
			
			buyBar.addEventListener(Event.TRIGGERED, onItemSelected);
			
		}
		
		private function onItemSelected(event:Event):void
		{
			dispatchEvent(new Event(SupplyAdapter.BUY_SUPPLY));
		}
				
		public function set price(itemPrice:int):void{
			this.itemPrice = itemPrice;
			this.priceText.text = "IDR "+ValueFormatter.format(itemPrice);
		}
		
		public function get price():int{
			return itemPrice;
		}
		
		override public function set expiredRemaining(expired:int):void{
			this.itemExpired = expired;
			this.quantityText.text = itemExpired+ " Days";
		}
		
		override public function get expiredRemaining():int{
			return itemExpired;
		}
		
		override public function set quantityRemaining(quantity:int):void{
			this.itemQuantity = quantity;			
			this.quantityText.text = itemQuantity +" PCS";
		}
		
		override public function get quantityRemaining():int{
			return itemQuantity;
		}
	}
}