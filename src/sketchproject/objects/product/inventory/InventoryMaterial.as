package sketchproject.objects.product.inventory
{
	import flash.events.Event;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.MaterialAdapter;
	import sketchproject.objects.dialog.NativeDialog;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class InventoryMaterial extends Sprite
	{
		private var title:TextField;
		private var itemContainer:Sprite;
		
		private var currentPage:int;
		private var totalPage:int;
		private var itemPerPage:int;
		private var totalItem:int;
		
		private var inventory:Array;
		private var labelPage:TextField;
		private var capacityLabel:TextField;
		private var nextPage:Button;
		private var prevPage:Button;
		
		private var material:MaterialAdapter;
		private var dialogConfirm:NativeDialog;
		private var bar:Quad;
		private var server:ServerManager;
		
		private var totalThrowed:int;
		
		public function InventoryMaterial()
		{
			super();
			
			totalThrowed = 0;
			
			currentPage = 1;
			totalPage = 1;
			itemPerPage = 6;
			totalItem = 0;
			
			title = new TextField(200, 50, "Raw Material", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			title.hAlign = HAlign.LEFT;
			addChild(title);
			
			itemContainer = new Sprite();
			itemContainer.y = 55;			
			addChild(itemContainer);
			
			bar = new Quad(188, 35, 0x212121);
			bar.x = 235;
			bar.y = 323;
			addChild(bar);
			
			labelPage = new TextField(150, 30, "Item Page 1/1", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
			labelPage.pivotX = labelPage.width * 0.5;
			labelPage.pivotY = labelPage.height * 0.5;
			labelPage.hAlign = HAlign.CENTER;
			labelPage.vAlign = VAlign.TOP;
			labelPage.x = 332;
			labelPage.y = 343;
			addChild(labelPage);
			
			capacityLabel = new TextField(150, 30, "Capacity 8/8 Items", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
			capacityLabel.pivotX = labelPage.width * 0.5;
			capacityLabel.pivotY = labelPage.height * 0.5;
			capacityLabel.hAlign = HAlign.CENTER;
			capacityLabel.vAlign = VAlign.TOP;
			capacityLabel.x = 100;
			capacityLabel.y = 345;
			addChild(capacityLabel);
			
			prevPage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			prevPage.pivotX = prevPage.width * 0.5;
			prevPage.pivotY = prevPage.height * 0.5;
			prevPage.scaleX = -1;
			prevPage.x = 257;
			prevPage.y = 340;
			addChild(prevPage);
			
			nextPage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			nextPage.pivotX = nextPage.width * 0.5;
			nextPage.pivotY = nextPage.height * 0.5;
			nextPage.x = 407;
			nextPage.y = 340;
			addChild(nextPage);
			
			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Remove","Do you want to remove material?");
			dialogConfirm.x = Starling.current.stage.stageWidth * 0.5;
			dialogConfirm.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(dialogConfirm);
			
			prevPage.addEventListener(starling.events.Event.TRIGGERED, onPrevPage);
			nextPage.addEventListener(starling.events.Event.TRIGGERED, onNextPage);
			
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, onRemoveConfirmed);
			
			update();
		}
		
		private function onRemoveConfirmed(event:DialogBoxEvent):void
		{
			if(event.result)
			{
				Game.loadingScreen.show();
				
				var gameObject:Object 			= new Object();
				gameObject.token 				= Data.key;
				gameObject.material_id 			= material.recordId;
				
				totalThrowed+=Data.inventory[material.recordIndex].mtr_price;
				
				server = new ServerManager("inventory/remove_material",gameObject);
				server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void{
					Game.loadingScreen.hide();
					
					removeItem();
				});
				server.sendRequest();				
				
			}	
			dialogConfirm.closeDialog();
		}
		
		public function getTotalThrowed():int
		{
			return totalThrowed;
		}
		
		private function onNextPage(event:starling.events.Event):void
		{
			if(currentPage < totalPage){
				currentPage++;
				update();
			}			
		}
		
		private function onPrevPage(event:starling.events.Event):void
		{
			if(currentPage > 1){
				currentPage--;
				update();
			}
		}
		
		public function update():void
		{
			
			itemContainer.removeChildren();
			
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
			
			for(var k:int = startItem; k<endItem; k++){
				var item:MaterialAdapter = new MaterialAdapter(
					k, 
					inventory[k].pma_id, 
					inventory[k].mtr_id,
					inventory[k].mtr_item, 
					inventory[k].pma_expired_remaining, 
					inventory[k].pma_stock, 
					inventory[k].mtr_atlas
				);
				var counter:int = (k - (itemPerPage*(currentPage-1)));
				item.x = (counter%2) * 230;
				item.y = Math.floor(counter/2) * 90;
				item.addEventListener(MaterialAdapter.ITEM_REMOVE, onItemRemoved);
				itemContainer.addChild(item);
			}
		}
		
		private function onItemRemoved(event:starling.events.Event):void
		{
			Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			material = MaterialAdapter(event.currentTarget);
			Game.overlayStage.swapChildren(dialogConfirm, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
			dialogConfirm.dialogMessage = "Do you want to remove "+material.itemName+"?"
			dialogConfirm.openDialog();			
		}
		
		private function removeItem():void
		{
			for(var i:int = Data.inventory.length-1; i >= 0 ; i--)
			{
				if(Data.inventory[i].pma_id == material.recordId)
				{
					Data.inventory.splice(i,1);					
				}
			}
			update();
		}
	}
}