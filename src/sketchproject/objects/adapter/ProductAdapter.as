package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Handle single product setting.
	 * 
	 * @author Angga
	 */
	public class ProductAdapter extends Sprite
	{
		public static var PRICE_CHANGED:String = "priceChanged";
		
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

		/**
		 * Default constructor of ProductAdapter.
		 * 
		 * @param index of list
		 * @param id of product
		 * @param name food name
		 * @param price product price
		 * @param texture image icon
		 */
		public function ProductAdapter(index:int, id:int, name:String, price:int, texture:String)
		{
			super();

			this.index = index;
			this.id = id;
			this.foodName = name;
			this.foodPrice = price;

			product = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture));
			addChild(product);

			myPrice = new TextField(200, 40, "IDR " + ValueFormatter.numberFormat(price), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			myPrice.hAlign = HAlign.CENTER;
			myPrice.pivotX = myPrice.width * 0.5;
			myPrice.x = 145;
			addChild(myPrice);

			averagePrice = new TextField(200, 40, "AVG IDR " + ValueFormatter.numberFormat(Config.product[index].prd_price), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
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

		/**
		 * Increase product price value per 500.
		 * 
		 * @param event
		 */
		private function onPriceIncreased(event:Event):void
		{
			if(productPrice + 500 <= 100000){				
				productPrice += 500;
				dispatchEvent(new Event(ProductAdapter.PRICE_CHANGED));
			}
		}

		/**
		 * Decrease product price value per 500.
		 * 
		 * @param event
		 */
		private function onPriceDecreased(event:Event):void
		{
			if(productPrice - 500 >= 500){
				productPrice -= 500;
				dispatchEvent(new Event(ProductAdapter.PRICE_CHANGED));
			}
		}

		/**
		 * Set product id.
		 * 
		 * @param id
		 */
		public function set productId(id:int):void
		{
			this.id = id;
		}

		/**
		 * Get product id.
		 * 
		 * @return
		 */
		public function get productId():int
		{
			return id;
		}

		/**
		 * Set product name.
		 * 
		 * @param name
		 */
		public function set productName(name:String):void
		{
			this.foodName = name;
		}

		/**
		 * Get product name.
		 * 
		 * @return
		 */
		public function get productName():String
		{
			return foodName;
		}

		/**
		 * Set product price.
		 * 
		 * @param price
		 */
		public function set productPrice(price:int):void
		{
			foodPrice = price;
			Data.product[index][2] = price;
			Data.product[index].prd_price = price;
			myPrice.text = "IDR " + ValueFormatter.numberFormat(price);
		}

		/**
		 * Get product price.
		 * 
		 * @return
		 */
		public function get productPrice():int
		{
			return foodPrice;
		}

		/**
		 * Set product price average.
		 * 
		 * @param average
		 */
		public function set productPriceAverage(average:int):void
		{
			foodPriceAverage = average;
			averagePrice.text = "Avg. IDR " + ValueFormatter.format(average);
		}

		/**
		 * Get product average.
		 * 
		 * @return
		 */
		public function get productPriceAverage():int
		{
			return foodPriceAverage;
		}
	}
}
