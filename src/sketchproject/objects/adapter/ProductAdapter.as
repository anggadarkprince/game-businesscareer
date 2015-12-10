package sketchproject.objects.adapter
{	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class ProductAdapter extends Sprite
	{
		private var index:int;
		
		private var id:int;
		private var foodName:String;
		private var foodPrice:int;
		private var foodPriceAverage:int;
		
		private var product:Image;
		private var increasePrice:Button;
		private var decreasePrice:Button;
		private var bar:Quad;
		private var myPrice:TextField;
		private var averagePrice:TextField;		
		
		public function ProductAdapter(index:int, id:int, name:String, price:int, texture:String)
		{
			super();
			
			this.index = index;
			this.id = id;
			this.foodName = name;
			this.foodPrice = price;
			
			product = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture));
			addChild(product);
			
			myPrice = new TextField(200, 40, "IDR "+ValueFormatter.format(price), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			myPrice.hAlign = HAlign.CENTER;
			myPrice.pivotX = myPrice.width * 0.5;
			myPrice.x = 145;
			addChild(myPrice);
			
			averagePrice = new TextField(200, 40, "AVG IDR "+ValueFormatter.format(price), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			averagePrice.hAlign = HAlign.LEFT;
			averagePrice.pivotX = myPrice.width * 0.5;
			averagePrice.x = 320;
			averagePrice.y = 5;
			addChild(averagePrice);
			
			decreasePrice = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			decreasePrice.pivotX = decreasePrice.width * 0.5;
			decreasePrice.pivotY = decreasePrice.width * 0.5;
			decreasePrice.scaleX = 0.9;
			decreasePrice.scaleY = 0.9;
			decreasePrice.x = 90;
			decreasePrice.y = 25;
			addChild(decreasePrice);
			
			bar = new Quad(70, 5, 0x666666);
			bar.pivotX = bar.width * 0.5;
			bar.x = 145;
			bar.y = 32;
			addChild(bar);
						
			increasePrice = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			increasePrice.pivotX = decreasePrice.width * 0.5;
			increasePrice.pivotY = decreasePrice.width * 0.5;
			increasePrice.scaleX = 0.9;
			increasePrice.scaleY = 0.9;
			increasePrice.x = 200;
			increasePrice.y = 25;
			addChild(increasePrice);	
			
			decreasePrice.addEventListener(Event.TRIGGERED, onPriceDecreased);
			increasePrice.addEventListener(Event.TRIGGERED, onPriceIncreased);
		}
		
		private function onPriceIncreased(event:Event):void
		{
			productPrice += 500;
		}
		
		private function onPriceDecreased(event:Event):void
		{
			productPrice -= 500;
		}
		
		public function set productId(id:int):void{
			this.id = id;
		}
		
		public function get productId():int{
			return id;
		}
		
		public function set productName(name:String):void{
			this.foodName = name;
		}
		
		public function get productName():String{
			return foodName;
		}
		
		public function set productPrice(price:int):void{
			this.foodPrice = price;
			Data.product[index][2] = price;
			myPrice.text = "IDR "+ValueFormatter.format(price);			
		}
		
		public function get productPrice():int{
			return foodPrice;
		}
		
		public function set productPriceAverage(average:int):void{
			this.foodPriceAverage = average;
			averagePrice.text = "AVG IDR "+ValueFormatter.format(average);
		}
		
		public function get productPriceAverage():int{
			return foodPriceAverage;
		}
	}
}