package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.Event;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.FireworkParticleManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.SupplyAdapter;
	import sketchproject.objects.adapter.UpgradeAdapter;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class SupplierDialog extends Sprite
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var avatar:Image;
		private var buttonClose:Button;
		private var label:TextField;
		private var cash:TextField;
		private var labelPage:TextField;
		
		private var dataMarket:Object;
		
		private var fireworkManager:FireworkParticleManager;
		private var itemContainer:Sprite;
		
		private var currentPage:int;
		private var totalPage:int;
		private var itemPerPage:int;
		private var totalItem:int;
		
		private var inventory:Array;
		private var prevPage:Button;
		private var nextPage:Button;
		private var supply:SupplyAdapter;
		private var upgrade:UpgradeAdapter;
		private var materialConfirm:MaterialDetailDialog;
		
		private var dialogConfirm:NativeDialog;
		private var dialogInfo:NativeDialog;
		
		public var totalInventoryBought:int;
		private var server:ServerManager;
		
		private var dialogPost:PostDialog;
		
		public function SupplierDialog(data:Object)
		{
			super();
			
			currentPage = 1;
			totalPage = 1;
			itemPerPage = 6;
			totalItem = 0;
			
			dataMarket = data;
			
			totalInventoryBought = 0;
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			overlay = new Quad(Starling.current.stage.stageWidth * 2.5,Starling.current.stage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialogBase = new Image(Assets.getAtlas(Assets.PANEL, Assets.PANEL_XML).getTexture("dialog_asset_supplier"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
									
			dialogBase = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture(data.spl_atlas));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			dialogBase.x = -360;
			dialogBase.y = -20;
			addChild(dialogBase);
			
			dialogBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_supplier"));
			dialogBase.x = -450;
			dialogBase.y = 75;
			addChild(dialogBase);
			
			label = new TextField(300, 50, data.spl_name +" "+ data.spl_type, Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			label.pivotX = label.width * 0.5;
			label.y = -260;
			label.hAlign = HAlign.CENTER;
			addChild(label);
			
			cash = new TextField(250, 50, "IDR "+ValueFormatter.format(Data.cash), Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			cash.pivotX = cash.width * 0.5;
			cash.y = 210;
			cash.hAlign = HAlign.CENTER;
			cash.vAlign = VAlign.TOP;
			addChild(cash);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = 405;
			buttonClose.y = -220;
			addChild(buttonClose);
			
			itemContainer = new Sprite();
			itemContainer.x = -210;
			itemContainer.y = -180;
			addChild(itemContainer);
			
			labelPage = new TextField(150, 30, "Item Page 1/1", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xFFFFFF);
			labelPage.pivotX = labelPage.width * 0.5;
			labelPage.pivotY = labelPage.height * 0.5;
			labelPage.hAlign = HAlign.CENTER;
			labelPage.vAlign = VAlign.TOP;
			labelPage.x = 282;
			labelPage.y = 193;
			addChild(labelPage);
			
			prevPage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			prevPage.pivotX = prevPage.width * 0.5;
			prevPage.pivotY = prevPage.height * 0.5;
			prevPage.scaleX = -1;
			prevPage.x = 207;
			prevPage.y = 190;
			addChild(prevPage);
			
			nextPage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			nextPage.pivotX = nextPage.width * 0.5;
			nextPage.pivotY = nextPage.height * 0.5;
			nextPage.x = 357;
			nextPage.y = 190;
			addChild(nextPage);
						
			buttonClose.addEventListener(starling.events.Event.TRIGGERED, postingInventory);
			
			if(data.spl_type == "Market")
			{
				itemPerPage = 6;
				
				createMarket(String(data.item).split(","));
				materialConfirm = new MaterialDetailDialog(this);
				materialConfirm.addEventListener(MaterialDetailDialog.BUY_ITEM, onItemBought);
				addChild(materialConfirm);
			}
			else
			{
				itemPerPage = 3;
				itemContainer.x = -210
				createWorkshop(String(data.item).split(","));
			}
			
			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION);
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, onUpgradeConfirmed);
			addChild(dialogConfirm);
			
			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION);
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED,
				function(event:DialogBoxEvent):void{
					dialogInfo.closeDialog();
			});
			addChild(dialogInfo);
			
			dialogPost = new PostDialog("Inventory",totalInventoryBought,false);
			dialogPost.x = Starling.current.stage.stageWidth * 0.5;
			dialogPost.y = Starling.current.stage.stageHeight * 0.5;
			dialogPost.isDestroyable = false;
			dialogPost.isTask = false;
			dialogPost.addEventListener(PostDialog.POSTING, function(event:starling.events.Event):void{
				totalInventoryBought = 0;	
				cash.text = "IDR "+ValueFormatter.format(Data.cash);
			});
			Game.overlayStage.addChild(dialogPost);
			
			prevPage.addEventListener(starling.events.Event.TRIGGERED, onPrevPage);
			nextPage.addEventListener(starling.events.Event.TRIGGERED, onNextPage);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;			
		}
		
		
		private function postingInventory(event:starling.events.Event):void
		{
			closeDialog(); 
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			
			if(totalInventoryBought>0)
			{
				if(dataMarket.spl_type == "Market")
				{
					dialogPost.transactionType = "Inventory";
				}
				else
				{
					dialogPost.transactionType = "Equipment";
				}
				dialogPost.transactionValue = totalInventoryBought;
				dialogPost.preparePosting();
				dialogPost.openDialog();
			}			
		}
		
		private function onItemBought(event:starling.events.Event):void
		{
			totalInventoryBought += materialConfirm.getTotal();
		}
		
		private function onNextPage(event:starling.events.Event):void
		{
			if(currentPage < totalPage){
				currentPage++;
				if(dataMarket.spl_type == "Market")
				{
					createMarket(String(dataMarket.item).split(","));
				}
				else
				{
					createWorkshop(String(dataMarket.item).split(","));
				}
				
			}			
		}
		
		private function onPrevPage(event:starling.events.Event):void
		{
			if(currentPage > 1){
				currentPage--;
				if(dataMarket.spl_type == "Market")
				{
					createMarket(String(dataMarket.item).split(","));
				}
				else
				{
					createWorkshop(String(dataMarket.item).split(","));
				}
			}
		}
		
		private function onUpgradeConfirmed(event:DialogBoxEvent):void
		{
			if(event.result)
			{
				if(Data.cash < (totalInventoryBought + upgrade.price)){
					dialogInfo.dialogTitle = "Upgrade Failed";
					dialogInfo.dialogMessage = "Your cash not enough for upgrade?";
					dialogInfo.openDialog();
				}
				else{
					for(var i:int = 0; i<Data.asset.length; i++){
						if(Data.asset[i][2] == upgrade.type)
						{
							Game.loadingScreen.show();
							var gameObject:Object 			= new Object();							
							gameObject.token 				= Data.key;
							gameObject.asset	 			= upgrade.productId;
							
							server = new ServerManager("inventory/upgrade_asset",gameObject);
							server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void{
								Game.loadingScreen.hide();	
								
								var newItem:Array = [upgrade.productId,upgrade.type, upgrade.itemName,upgrade.texture, upgrade.level];
								Data.asset.splice(i,1,newItem);
								totalInventoryBought += upgrade.price;
								
								dialogInfo.dialogTitle = "Asset Upgraded";
								dialogInfo.dialogMessage = "Your asset "+upgrade.type+" has upgraded to level "+upgrade.level;
								dialogInfo.openDialog();
																
								var asset:String 		= server.received.player_asset_var;								
								if(JSON.parse(asset) as Array != null)		
									Data.asset = JSON.parse(asset) as Array;
								
								createWorkshop(String(dataMarket.item).split(","));
							});
							server.sendRequest();
						}
					}
					
				}
			}
			dialogConfirm.closeDialog();
		}
		
		public function createMarket(supply:Array):void
		{
			itemContainer.removeChildren();
			
			totalItem = 0;
			inventory = new Array();
			for(var i:int = 0; i<Config.material.length; i++){
				for(var j:int = 0; j<supply.length; j++){
					if(Config.material[i].mtr_id == supply[j]){
						totalItem++;
						inventory.push(Config.material[i]);
					}
				}
			}
			
			totalPage = Math.ceil(totalItem/itemPerPage);
			
			if(currentPage > totalPage){
				currentPage = totalPage;
			}
			
			labelPage.text = "Item Page "+currentPage+" / "+totalPage;
			
			var startItem:int = (totalItem==0)?0:(currentPage-1)*itemPerPage;
			var endItem:int = (currentPage==totalPage) ? totalItem : startItem+itemPerPage;
			
			for(var k:int = startItem; k<endItem; k++){
				var item:SupplyAdapter = new SupplyAdapter(
					k, 
					inventory[k].mtr_id, 
					inventory[k].mtr_item, 
					inventory[k].mtr_atlas, 
					inventory[k].mtr_price, 
					inventory[k].mtr_expired_at,
					Math.random() * 50 + 20
				);
				var counter:int = (k - (itemPerPage*(currentPage-1)));
				item.x = (counter%2) * 290;
				item.y = Math.floor(counter/2) * 117;
				item.addEventListener(SupplyAdapter.BUY_SUPPLY, onItemSelected);
				itemContainer.addChild(item);
			}			
			
		}
		
		private function onItemSelected(event:starling.events.Event):void
		{
			supply = SupplyAdapter(event.currentTarget);
			materialConfirm.openDialog();
			materialConfirm.setCurrentSupply(supply);
		}
		
		public function createWorkshop(supply:Array):void
		{
			itemContainer.removeChildren();

			totalItem = 0;
			inventory = new Array();
			
			var isDifferent:String = "";
			for(var i:int = 0; i<Config.asset.length; i++){
				for(var j:int = 0; j<supply.length; j++){
					if(Config.asset[i].ast_id == supply[j]){
										
						for(var l:int = 0; l<Data.asset.length; l++){
							
							if(Data.asset[l].ast_type == Config.asset[i].ast_type && int(Data.asset[l].ast_level) + 1 == Config.asset[i].ast_level)
							{
								totalItem++;
								inventory.push(Config.asset[i]);
							}
							if(Data.asset[l].ast_type == Config.asset[i].ast_type && int(Data.asset[l].ast_level) == 3)
							{
								if(isDifferent != Data.asset[l].ast_type)
								{
									isDifferent = Data.asset[l].ast_type;
									totalItem++;
									inventory.push(new Array(
										1,
										"-",
										"-",
										Data.asset[l].ast_atlas,
										0,
										3,
										"-"
									));
								}									
							}
						}
					}
					
				}
			}
			
			totalPage = Math.ceil(totalItem/itemPerPage);
			
			if(currentPage > totalPage){
				currentPage = totalPage;
			}
			if(totalPage <= 1)
			{
				nextPage.visible = false;
				prevPage.visible = false;
				labelPage.visible = false;
			}
			else
			{
				nextPage.visible = true;
				prevPage.visible = true;
				labelPage.visible = true;
			}
			
			labelPage.text = "Item Page "+currentPage+" / "+totalPage;
			
			var startItem:int = (totalItem==0)?0:(currentPage-1)*itemPerPage;
			var endItem:int = (currentPage==totalPage) ? totalItem : startItem+itemPerPage;
			
			for(var k:int = startItem; k<endItem; k++){
				var item:UpgradeAdapter = new UpgradeAdapter(
					k, 
					inventory[k][0],
					inventory[k][1],
					inventory[k][2],
					inventory[k][3], 
					inventory[k][4], 
					inventory[k][5],
					inventory[k][6]
				);
				
				if(inventory[k][1] == "-" && inventory[k][2] == "-"){
					item.maximumLevel();
				}
				var counter:int = (k - (itemPerPage*(currentPage-1)));
				item.x = counter * 200;
				item.addEventListener(UpgradeAdapter.UPGRADE_ITEM, onUpgradeSelected);
				itemContainer.addChild(item);
			}
			
			
		}
		
		private function onUpgradeSelected(event:starling.events.Event):void
		{
			upgrade = UpgradeAdapter(event.currentTarget);
			dialogConfirm.dialogTitle = "Upgrade Confirm"
			dialogConfirm.dialogMessage = "Do you want to upgrade "+upgrade.type +" Level "+upgrade.level+"?";
			dialogConfirm.openDialog();			
		}
		
		public function openDialog():void
		{
			cash.text = "IDR "+ValueFormatter.format(Data.cash);
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this,
				0.7,
				{
					ease:Back.easeOut,
					alpha:1,
					scaleX:1,
					scaleY:1,
					delay:0.2
				}
			);	
		}
		
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			TweenMax.to(
				this,
				0.5,
				{
					ease:Back.easeIn,
					scaleX:0.5,
					scaleY:0.5,
					alpha:0,
					delay:0.2,
					onComplete:function():void{
						visible = false;
					}
				}
			);
		}
	}
}