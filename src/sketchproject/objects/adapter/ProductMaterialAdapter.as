package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Handle product material info with total minimum could produce.
	 * 
	 * @author Angga
	 */
	public class ProductMaterialAdapter extends Sprite
	{
		private var ready:int;

		private var item:Image;
		private var label:TextField;
		private var readyProduct:TextField;
		private var bar:Quad;

		/**
		 * Default constructor of ProductMaterialAdapter.
		 * 
		 * @param productName food name
		 * @param ready minimum product ready
		 * @param textureProduct icon food
		 * @param textureMaterial icon material
		 */
		public function ProductMaterialAdapter(productName:String, ready:int, textureProduct:String, textureMaterial:Array)
		{
			super();

			this.ready = ready;

			bar = new Quad(400, 55, 0x212121);
			addChild(bar);

			bar = new Quad(75, 55, 0x141414);
			addChild(bar);

			item = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(textureProduct));
			item.x = 5;
			item.y = 5;
			addChild(item);

			label = new TextField(200, 25, productName, Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
			label.hAlign = HAlign.LEFT;
			label.x = 85;
			addChild(label);

			label = new TextField(100, 25, "READY MIN", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
			label.hAlign = HAlign.RIGHT;
			label.x = 290;
			addChild(label);

			for (var i:int = 0; i < textureMaterial.length; i++)
			{
				item = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(textureMaterial[i]));
				item.scaleX = 0.2;
				item.scaleY = 0.2;
				item.x = i * item.width + 85;
				item.y = 25;
				addChild(item);
			}

			readyProduct = new TextField(100, 25, ready + " PCS", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			readyProduct.hAlign = HAlign.RIGHT;
			readyProduct.x = 290;
			readyProduct.y = 20;
			addChild(readyProduct);
		}

		/**
		 * Set minimum product ready.
		 * 
		 * @param ready
		 */
		public function set productReady(ready:int):void
		{
			this.ready = ready;
			readyProduct.text = ready + " PCS";
		}

		/**
		 * Get minimum product ready.
		 * 
		 * @return
		 */
		public function get productReady():int
		{
			return ready;
		}
	}
}
