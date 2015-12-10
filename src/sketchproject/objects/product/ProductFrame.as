package sketchproject.objects.product
{	
	import feathers.controls.PickerList;
	import feathers.data.ListCollection;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
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
		private var visibilityList:ListCollection = new ListCollection([{ text: "NONE" },{ text: "LOW" }, { text: "AVG" }, { text: "HIGH" }]);
		private var listAppearance:PickerList;
		private var strip:Quad;
		
		private var shop:Image;
		private var shelf:Image;
		private var vihicle:Image;
		
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
			
			label = new TextField(300, 50, "*Keep in mind your product will throwed away because expired session", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 9, 0x333333);
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
			addChild(listAppearance);
			
			label = new TextField(250, 50, "Support Item Active", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = -45;
			addChild(label);
			
			label = new TextField(100, 50, "VIHICLE", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
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
			label.x = 370;
			label.y = -20;
			addChild(label);
			
			strip = new Quad(50, 50, 0x333333);
			strip.x = 210;
			strip.y = 0;
			addChild(strip);
			
			vihicle = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[0].ast_atlas));
			vihicle.x = 213;
			vihicle.y = 0;
			vihicle.scaleX = 0.3;
			vihicle.scaleY = 0.3;
			addChild(vihicle);
			
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
			shop.y = 0;
			shop.scaleX = 0.3;
			shop.scaleY = 0.3;
			addChild(shop);
			
			label = new TextField(100, 50, "STUFF", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 200;
			label.y = 55;
			addChild(label);
			
			label = new TextField(100, 50, "STORAGE", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 290;
			label.y = 55;
			addChild(label);
			
			label = new TextField(100, 50, "ACCESORRY", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 370;
			label.y = 55;
			addChild(label);
			
			strip = new Quad(50, 50, 0x333333);
			strip.x = 210;
			strip.y = 75;
			addChild(strip);
			
			vihicle = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[3].ast_atlas));
			vihicle.x = 215;
			vihicle.y = 80;
			vihicle.scaleX = 0.3;
			vihicle.scaleY = 0.3;
			addChild(vihicle);
			
			strip = new Quad(50, 50, 0x333333);
			strip.x = 290;
			strip.y = 75;
			addChild(strip);
			
			shelf = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[4].ast_atlas));
			shelf.x = 295;
			shelf.y = 80;
			shelf.scaleX = 0.3;
			shelf.scaleY = 0.3;
			addChild(shelf);
			
			strip = new Quad(50, 50, 0x333333);
			strip.x = 370;
			strip.y = 75;
			addChild(strip);
			
			shop = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[5].ast_atlas));
			shop.x = 375;
			shop.y = 80;
			shop.scaleX = 0.3;
			shop.scaleY = 0.3;
			addChild(shop);
			
			prevPage.addEventListener(Event.TRIGGERED, onPrevPage);
			nextPage.addEventListener(Event.TRIGGERED, onNextPage);
			
			update();
		}
		
		private function onNextPage(event:Event):void
		{
			if(currentPage < totalPage){
				currentPage++;
				update();
			}			
		}
		
		private function onPrevPage(event:Event):void
		{
			if(currentPage > 1){
				currentPage--;
				update();
			}
		}
		
		public function update():void
		{
			productContainer.removeChildren();
			itemContainer.removeChildren();
			
			for(var i:int = 0; i<Data.product.length; i++){
				var product:ProductAdapter = new ProductAdapter(i, Data.product[i].prd_id, Data.product[i].prd_product, Data.product[i].prd_price, Data.product[i].prd_atlas);
				product.y = i * product.height + 5;
				productContainer.addChild(product);				
			}
			
			totalItem = 0;
			inventory = new Array();
			for(var j:int = 0; j<Data.inventory.length; j++){
				totalItem++;
				inventory.push(Data.inventory[j]);
			}

			totalPage = Math.ceil(totalItem/itemPerPage);
			
			if(currentPage > totalPage){
				currentPage = totalPage;
			}
			
			labelPage.text = "Item Page "+currentPage+" / "+totalPage;
			
			var startItem:int = (totalItem==0)?0:(currentPage-1)*itemPerPage;
			var endItem:int = (currentPage==totalPage) ? totalItem : startItem+itemPerPage;
			var loop:int;
			if(totalItem==0)
			{
				loop = itemPerPage;
				itemPerPage = 1;
				currentPage = 1;
			}
			else
			{
				loop = itemPerPage*currentPage;
			}
			
			for(var k:int = startItem; k<loop; k++){
				if(k%2 == 0){
					strip = new Quad(220, 35, 0xFFFFFF);
					strip.alpha = 0.3;
					strip.y = (k - (itemPerPage*(currentPage-1))) * 33;
					itemContainer.addChild(strip);
				}
				if(k<endItem){					
					var item:ItemAdapter = new ItemAdapter(k, inventory[k].pma_id, inventory[k].mtr_id, inventory[k].pma_expired_remaining, inventory[k].pma_stock, inventory[k].mtr_atlas);
					item.x = 10;
					item.y = (k - (itemPerPage*(currentPage-1))) * 33;
					itemContainer.addChild(item);	
				}
			}
			
			for(var a:int = 0; a<Data.asset.length; a++){
				if(Data.asset[i].ast_asset == "Vehicle")
				{
					vihicle.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					vihicle.readjustSize();
				}
				if(Data.asset[i].ast_asset == "Shelf")
				{
					shelf.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					shelf.readjustSize();
				}
				if(Data.asset[i].ast_asset == "Shop")
				{
					shop.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[a].ast_atlas);
					shop.readjustSize();
				}
			}			
		}
	}
}