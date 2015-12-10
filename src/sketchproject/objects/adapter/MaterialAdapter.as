package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class MaterialAdapter extends ItemAdapter
	{
		public static const ITEM_REMOVE:String = "remove";
		
		protected var materialName:String;
		
		protected var bar:Quad;
		protected var itemBar:Quad;
		protected var removeButton:Button;
		protected var nameLabel:TextField;
				
		public function MaterialAdapter(index:int, id:int, itemId:int, name:String, itemExpired:int, itemQuantity:int, texture:String)
		{
			super(index, id, itemId, itemExpired, itemQuantity, texture);
			
			this.materialName = name;
			
			bar = new Quad(200, 75, 0x212121);
			addChildAt(bar, 0);
			
			itemBar = new Quad(55, 55, 0x454545);
			itemBar.x = 10;
			itemBar.y = 10;
			addChildAt(itemBar, 1);
			
			itemImage.scaleX = 0.4;
			itemImage.scaleY = 0.4;
			itemImage.x = 10;
			itemImage.y = 10;
			
			nameLabel = new TextField(200, 25, name.toString(), Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0xFFFFFF);
			nameLabel.hAlign = HAlign.LEFT;
			nameLabel.x = 70;
			nameLabel.y = 10;
			addChild(nameLabel);
			
			quantityText.hAlign = HAlign.LEFT;
			quantityText.pivotX = 0;
			quantityText.x = 70;
			quantityText.y = 30;
			quantityText.fontSize = 14;
			quantityText.fontName = Assets.getFont(Assets.FONT_CORegular).fontName;
			quantityText.color = 0xFFFFFF;
			quantityText.text = "Stock "+itemQuantity +" PCS";
			
			expiredText.hAlign = HAlign.LEFT;
			expiredText.pivotX = 0;
			expiredText.x = 70;
			expiredText.y = 45;
			expiredText.fontSize = 11;
			expiredText.fontName = Assets.getFont(Assets.FONT_CORegular).fontName;
			expiredText.color = 0xFFFFFF;
			expiredText.text = "Expired for "+itemExpired+ " Days";
			
			removeButton = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			removeButton.pivotX = removeButton.width * 0.5;
			removeButton.pivotY = removeButton.height * 0.5;
			removeButton.x = 200;
			removeButton.y = 37;
			addChild(removeButton);
			
			removeButton.addEventListener(Event.TRIGGERED, onItemRemoved);
		}
		
		private function onItemRemoved(event:Event):void
		{
			dispatchEvent(new Event(MaterialAdapter.ITEM_REMOVE));
		}
		
		public function set itemName(itemName:String):void{
			this.materialName = itemName;
		}
		
		public function get itemName():String{
			return materialName;
		}
		
		override public function set expiredRemaining(expired:int):void{
			this.itemExpired = expired;
			this.quantityText.text = "Expired for "+itemExpired+ " Days";
		}
		
		override public function get expiredRemaining():int{
			return itemExpired;
		}
		
		override public function set quantityRemaining(quantity:int):void{
			this.itemQuantity = quantity;			
			this.quantityText.text = "Stock "+itemQuantity +" PCS";
		}
		
		override public function get quantityRemaining():int{
			return itemQuantity;
		}
	}
}