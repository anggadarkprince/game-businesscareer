package sketchproject.objects.product.inventory
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.objects.adapter.ProductMaterialAdapter;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class InventoryProduct extends Sprite
	{
		private var title:TextField;
		private var itemContainer:Sprite;
		
		public function InventoryProduct()
		{
			super();
			
			title = new TextField(200, 50, "Ready Product", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			title.hAlign = HAlign.LEFT;
			addChild(title);
			
			itemContainer = new Sprite();
			itemContainer.x = 30;
			itemContainer.y = 50;			
			addChild(itemContainer);
			
			update();
		}
		
		public function update():void
		{
			itemContainer.removeChildren();
			
			for(var i:int = 0; i<Data.product.length; i++)
			{
				var textureMaterial:Array = new Array();
				
				for(var j:int = 0; j<Config.material.length; j++)
				{
					for(var k:int = 0; k<Data.productInventory[i].material.length; k++)
					{
						if(Data.productInventory[i].material[k] == Config.material[j].mtr_id)
						{
							textureMaterial.push(Config.material[j].mtr_atlas);							
						}
					}						
				}
				var min:int = int.MAX_VALUE;
				var totalMatch:int = 0;
				for(var a:int = 0; a<Data.productInventory[i].material.length; a++)
				{
					for(var b:int = 0; b<Data.inventory.length; b++)
					{
						if(Data.productInventory[i].material[a] == Data.inventory[b].mtr_id)
						{
							totalMatch++;
							if(Data.inventory[b].pma_stock < min)
							{
								min = Data.inventory[b].pma_stock;
							}
						}
					}					
				}
				
				if(totalMatch < Data.productInventory[i].material.length)
				{
					min = 0;
				}
				
				var product:ProductMaterialAdapter = new ProductMaterialAdapter(Data.product[i].prd_product,min,Data.product[i].prd_atlas,textureMaterial);
				product.y = (product.height + 5) * i;
				product.productReady = min;
				itemContainer.addChild(product);
			}
		}
	}
}