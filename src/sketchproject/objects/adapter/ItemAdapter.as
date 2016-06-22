package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Material item handler, base item material adapter.
	 *
	 * @author Angga
	 */
	public class ItemAdapter extends Sprite
	{
		protected var index:int;
		protected var id:int;
		protected var itemId:int;
		protected var itemExpired:int;
		protected var itemQuantity:int;
		protected var itemTexture:String;
		protected var itemImage:Image;

		protected var expiredText:TextField;
		protected var quantityText:TextField;

		/**
		 * Default constructor of ItemAdapter.
		 *
		 * @param index
		 * @param id of record
		 * @param itemId item if
		 * @param itemExpired expired remaining
		 * @param itemQuantity material stock
		 * @param texture material icon
		 */
		public function ItemAdapter(index:int, id:int, itemId:int, itemExpired:int, itemQuantity:int, texture:String)
		{
			super();

			this.index = index;
			this.id = id;
			this.itemId = itemId;
			this.itemExpired = itemExpired;
			this.itemQuantity = itemQuantity;
			this.itemTexture = texture;

			itemImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture));
			itemImage.scaleX = 0.3;
			itemImage.scaleY = 0.3;
			addChild(itemImage);

			this.expiredText = new TextField(200, 25, itemExpired.toString() + " Day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			this.expiredText.hAlign = HAlign.CENTER;
			this.expiredText.pivotX = this.expiredText.width * 0.5;
			this.expiredText.x = 90;
			this.expiredText.y = 5;
			addChild(expiredText);

			this.quantityText = new TextField(200, 25, itemQuantity.toString(), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			this.quantityText.hAlign = HAlign.CENTER;
			this.quantityText.pivotX = this.quantityText.width * 0.5;
			this.quantityText.x = 185;
			this.quantityText.y = 5;
			addChild(quantityText);
		}

		/**
		 * Set data record index.
		 * 
		 * @param index
		 */
		public function set recordIndex(index:int):void
		{
			this.index = index;
		}

		/**
		 * Get data record index.
		 * 
		 * @return 
		 */
		public function get recordIndex():int
		{
			return index;
		}

		/**
		 * Set record id same as database record (player material id).
		 * 
		 * @param id
		 */
		public function set recordId(id:int):void
		{
			this.id = id;
		}

		/**
		 * Get record id.
		 * 
		 * @return 
		 */
		public function get recordId():int
		{
			return id;
		}

		/**
		 * Set material id related.
		 * 
		 * @param itemId
		 */
		public function set materialId(itemId:int):void
		{
			this.itemId = itemId;
		}

		/**
		 * Get material id related.
		 * 
		 * @return 
		 */
		public function get materialId():int
		{
			return itemId;
		}

		/**
		 * Set expiration remaining.
		 * 
		 * @param expired
		 */
		public function set expiredRemaining(expired:int):void
		{
			this.itemExpired = expired;
			this.expiredText.text = expired.toString();
		}

		/**
		 * Get expiration remaining.
		 * 
		 * @return 
		 */
		public function get expiredRemaining():int
		{
			return itemExpired;
		}

		/**
		 * Set quantity item remaining.
		 * 
		 * @param quantity
		 */
		public function set quantityRemaining(quantity:int):void
		{
			this.itemQuantity = quantity;
			this.quantityText.text = quantity.toString();
		}

		/**
		 * Get quantity remaining.
		 * 
		 * @return 
		 */
		public function get quantityRemaining():int
		{
			return itemQuantity;
		}

		/**
		 * Set icon image.
		 * 
		 * @param itemTexture
		 */
		public function set texture(itemTexture:String):void
		{
			this.itemTexture = itemTexture;
		}

		/**
		 * Get icon image.
		 * 
		 * @return 
		 */
		public function get texture():String
		{
			return itemTexture;
		}
	}
}
