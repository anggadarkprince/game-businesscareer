package sketchproject.objects.product
{	
	import feathers.controls.PickerList;
	import feathers.data.ListCollection;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.ItemAdapter;
	import sketchproject.objects.adapter.ProductAdapter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Manage ready product, set price and support stuff.
	 * 
	 * @author Angga
	 */
	public class ProductFrame extends Sprite
	{
		private var label:TextField;
		private var productContainer:Sprite;
		private var itemContainer:Sprite;
		private var currentPage:int;
		private var totalPage:int;
		private var itemPerPage:int;
		private var totalItem:int;

		private var nextPage:Button;
		private var prevPage:Button;
		private var labelPage:TextField;

		private var inventory:Array;
		private var listQuality:PickerList;
		private var visibilityList:ListCollection = new ListCollection([{text: "NONE"}, {text: "LOW"}, {text: "AVG"}, {text: "HIGH"}]);
		private var listAppearance:PickerList;
		private var strip:Quad;

		private var shop:Image;
		private var shelf:Image;
		private var vehicle:Image;
		private var storage:Image;
		private var stove:Image;
		private var accessory:Image;
		
		private var server:ServerManager;

		/**
		 * Default constructor of ProductFrame.
		 */
		public function ProductFrame()
		{
			super();

			currentPage = 1;
			totalPage = 1;
			itemPerPage = 6;
			totalItem = 0;

			label = new TextField(100, 50, "Ready Stock", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -430;
			label.y = -200;
			addChild(label);

			label = new TextField(300, 50, "Rollover a product to view the inventory items needed", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -430;
			label.y = -180;
			addChild(label);

			productContainer = new Sprite();
			productContainer.x = -430;
			productContainer.y = -155;
			addChild(productContainer);

			label = new TextField(300, 50, "*Keep in mind your product will throwed away because expired session", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -430;
			label.y = 95;
			addChild(label);

			label = new TextField(100, 50, "Item Product", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -70;
			label.y = -200;
			addChild(label);

			label = new TextField(230, 50, "Item detail for product menu", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -70;
			label.y = -180;
			addChild(label);

			label = new TextField(100, 50, "Item", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -70;
			label.y = -160;
			addChild(label);

			label = new TextField(100, 50, "Expired", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.y = -160;
			addChild(label);

			label = new TextField(100, 50, "Quantity", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 80;
			label.y = -160;
			addChild(label);

			itemContainer = new Sprite();
			itemContainer.x = -70;
			itemContainer.y = -135;
			addChild(itemContainer);

			strip = new Quad(220, 35, 0xFFFFFF);
			strip.x = -70;
			strip.y = 77;
			addChild(strip);

			labelPage = new TextField(150, 30, "Item Page 1/1", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			labelPage.pivotX = labelPage.width * 0.5;
			labelPage.pivotY = labelPage.height * 0.5;
			labelPage.hAlign = HAlign.CENTER;
			labelPage.vAlign = VAlign.TOP;
			labelPage.x = 40;
			labelPage.y = 98;
			addChild(labelPage);

			prevPage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			prevPage.pivotX = prevPage.width * 0.5;
			prevPage.pivotY = prevPage.height * 0.5;
			prevPage.scaleX = -1;
			prevPage.x = -50;
			prevPage.y = 95;
			addChild(prevPage);

			nextPage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			nextPage.pivotX = nextPage.width * 0.5;
			nextPage.pivotY = nextPage.height * 0.5;
			nextPage.x = 130;
			nextPage.y = 95;
			addChild(nextPage);

			label = new TextField(230, 50, "Market Instant Improvement", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = -200;
			addChild(label);

			label = new TextField(230, 50, "Investing in the quality of your product and the appearance of your cart will make you more competitive", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = -180;
			addChild(label);

			label = new TextField(100, 50, "Quality", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = -120;
			addChild(label);

			listQuality = new PickerList();
			listQuality.dataProvider = visibilityList;
			listQuality.listProperties.@itemRendererProperties.labelField = "text";
			listQuality.labelField = "text";
			listQuality.width = 120;
			listQuality.height = 25;
			listQuality.x = 310;
			listQuality.y = -120;
			listQuality.addEventListener(Event.CHANGE, onQualityChanged);
			addChild(listQuality);

			label = new TextField(100, 50, "Appearance", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = -85;
			addChild(label);

			listAppearance = new PickerList();
			listAppearance.dataProvider = visibilityList;
			listAppearance.listProperties.@itemRendererProperties.labelField = "text";
			listAppearance.labelField = "text";
			listAppearance.width = 120;
			listAppearance.height = 25;
			listAppearance.x = 310;
			listAppearance.y = -85;
			listAppearance.addEventListener(Event.CHANGE, onAppearanceChanged);
			addChild(listAppearance);

			label = new TextField(250, 50, "Support Item Active", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = -45;
			addChild(label);

			label = new TextField(100, 50, "VEHICLE", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 203;
			label.y = -20;
			addChild(label);

			label = new TextField(100, 50, "SHELF", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 290;
			label.y = -20;
			addChild(label);

			label = new TextField(100, 50, "SHOP", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 368;
			label.y = -20;
			addChild(label);

			strip = new Quad(50, 50, 0x333333);
			strip.x = 210;
			strip.y = 0;
			addChild(strip);

			vehicle = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[0].ast_atlas));
			vehicle.x = 213;
			vehicle.y = 2;
			vehicle.scaleX = 0.3;
			vehicle.scaleY = 0.3;
			addChild(vehicle);

			strip = new Quad(50, 50, 0x333333);
			strip.x = 290;
			strip.y = 0;
			addChild(strip);

			shelf = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[1].ast_atlas));
			shelf.x = 293;
			shelf.y = 0;
			shelf.scaleX = 0.3;
			shelf.scaleY = 0.3;
			addChild(shelf);

			strip = new Quad(50, 50, 0x333333);
			strip.x = 370;
			strip.y = 0;
			addChild(strip);

			shop = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[2].ast_atlas));
			shop.x = 373;
			shop.y = 3;
			shop.scaleX = 0.3;
			shop.scaleY = 0.3;
			addChild(shop);

			label = new TextField(100, 50, "STORAGE", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 203;
			label.y = 55;
			addChild(label);

			label = new TextField(100, 50, "STOVE", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 290;
			label.y = 55;
			addChild(label);

			label = new TextField(100, 50, "ACCESSORY", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 368;
			label.y = 55;
			addChild(label);

			strip = new Quad(50, 50, 0x333333);
			strip.x = 210;
			strip.y = 75;
			addChild(strip);

			storage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[3].ast_atlas));
			storage.x = 213;
			storage.y = 79;
			storage.scaleX = 0.3;
			storage.scaleY = 0.3;
			addChild(storage);

			strip = new Quad(50, 50, 0x333333);
			strip.x = 290;
			strip.y = 75;
			addChild(strip);

			stove = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[4].ast_atlas));
			stove.x = 293;
			stove.y = 79;
			stove.scaleX = 0.3;
			stove.scaleY = 0.3;
			addChild(stove);

			strip = new Quad(50, 50, 0x333333);
			strip.x = 370;
			strip.y = 75;
			addChild(strip);

			accessory = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[5].ast_atlas));
			accessory.x = 373;
			accessory.y = 77;
			accessory.scaleX = 0.3;
			accessory.scaleY = 0.3;
			addChild(accessory);

			prevPage.addEventListener(starling.events.Event.TRIGGERED, onPrevPage);
			nextPage.addEventListener(starling.events.Event.TRIGGERED, onNextPage);

			update();
		}

		/**
		 * Next page material / product components and update the list.
		 * 
		 * @param event
		 */
		private function onNextPage(event:starling.events.Event):void
		{
			if (currentPage < totalPage)
			{
				currentPage++;
				update();
			}
		}

		/**
		 * Prev page material / product components and update the list.
		 * 
		 * @param event
		 */
		private function onPrevPage(event:starling.events.Event):void
		{
			if (currentPage > 1)
			{
				currentPage--;
				update();
			}
		}

		/**
		 * Update material list.
		 */
		public function update():void
		{
			productContainer.removeChildren();
			itemContainer.removeChildren();

			for (var i:int = 0; i < Data.product.length; i++)
			{
				var product:ProductAdapter = new ProductAdapter(i, Data.product[i].prd_id, Data.product[i].prd_product, Data.product[i].prd_price, Data.product[i].prd_atlas);
				product.y = i * product.height + 5;
				product.addEventListener(ProductAdapter.PRICE_CHANGED, saveProductPrice);
				productContainer.addChild(product);
			}

			totalItem = 0;
			inventory = new Array();
			for (var j:int = 0; j < Data.material.length; j++)
			{
				totalItem++;
				inventory.push(Data.material[j]);
			}

			totalPage = Math.ceil(totalItem / itemPerPage);

			if (currentPage > totalPage)
			{
				currentPage = totalPage;
			}

			labelPage.text = "Item Page " + currentPage + " / " + totalPage;

			var startItem:int = (totalItem == 0) ? 0 : (currentPage - 1) * itemPerPage;
			var endItem:int = (currentPage == totalPage) ? totalItem : startItem + itemPerPage;
			var loop:int;
			if (totalItem == 0)
			{
				loop = itemPerPage;
				itemPerPage = 1;
				currentPage = 1;
			}
			else
			{
				loop = itemPerPage * currentPage;
			}

			for (var k:int = startItem; k < loop; k++)
			{
				if (k % 2 == 0)
				{
					strip = new Quad(220, 35, 0xFFFFFF);
					strip.alpha = 0.3;
					strip.y = (k - (itemPerPage * (currentPage - 1))) * 33;
					itemContainer.addChild(strip);
				}
				if (k < endItem)
				{
					var item:ItemAdapter = new ItemAdapter(k, inventory[k].pma_id, inventory[k].mtr_id, inventory[k].pma_expired_remaining, inventory[k].pma_stock, inventory[k].mtr_atlas);
					item.x = 10;
					item.y = (k - (itemPerPage * (currentPage - 1))) * 33;
					itemContainer.addChild(item);
				}
			}

			for (var a:int = 0; a < Data.asset.length; a++)
			{
				if (Data.asset[a].ast_type == "Vehicle")
				{
					vehicle.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					vehicle.readjustSize();
				}
				if (Data.asset[a].ast_type == "Shelf")
				{
					shelf.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					shelf.readjustSize();
				}
				if (Data.asset[a].ast_type == "Shop")
				{
					shop.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					shop.readjustSize();
				}
				if (Data.asset[a].ast_type == "Storage")
				{
					storage.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					storage.readjustSize();
				}
				if (Data.asset[a].ast_type == "Productivity")
				{
					stove.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					stove.readjustSize();
				}
				if (Data.asset[a].ast_type == "Accessory")
				{
					accessory.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					accessory.readjustSize();
				}
			}
		}
		
		/**
		 * Quick quality improvement.
		 * 
		 * @param event
		 */
		public function onQualityChanged(event:Event):void
		{
			var quality:String = listQuality.selectedItem.text;
			if(quality == "AVG"){
				Data.quality = 0;
			}
			else if(quality == "LOW"){
				Data.quality = 1;
			}
			else if(quality == "AVG"){
				Data.quality = 2;
			}
			else if(quality == "HIGH"){
				Data.quality = 3;
			}
		}
		
		/**
		 * Quick appearance improvement.
		 * 
		 * @param event
		 */
		public function onAppearanceChanged(event:Event):void
		{
			var appearance:String = listAppearance.selectedItem.text;
			if(appearance == "AVG"){
				Data.appearance = 0;
			}
			else if(appearance == "LOW"){
				Data.appearance = 1;
			}
			else if(appearance == "AVG"){
				Data.appearance = 2;
			}
			else if(appearance == "HIGH"){
				Data.appearance = 3;
			}
		}
		
		/**
		 * Save product price to the server.
		 * 
		 * @param event
		 */
		public function saveProductPrice(event:starling.events.Event):void
		{
			var gameObject:Object = new Object();
			gameObject.token = Data.key;
			gameObject.product_data = JSON.stringify(Data.product);

			server = new ServerManager("product/update_product_price", gameObject);
			server.sendRequest();
		}
	}
}
