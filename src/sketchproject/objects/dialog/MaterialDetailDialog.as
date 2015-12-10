package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.Event;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.RewardManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.SupplyAdapter;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class MaterialDetailDialog extends Sprite
	{
		public static const BUY_ITEM:String = "buy";
		
		private var overlay:Quad;
		private var dialog:Image;
		private var supply:SupplyAdapter;
		private var labelText:TextField;
		
		private var supplyPreview:Image;
		private var nameText:TextField;
		private var priceText:TextField;
		private var availableText:TextField;
		private var expiredText:TextField;
		
		private var totalText:TextField;
		private var totalPriceText:TextField;
		
		private var increaseTotal:Button;
		private var decreaseTotal:Button;
		private var buttonPay:Button;
		
		private var total:int;
		private var totalPrice:int;
		
		private var confirmDialog:NativeDialog;
		private var buttonClose:Button;
		private var server:ServerManager;
		private var infoDialog:NativeDialog;
		
		private var supplier:SupplierDialog;
		private var gemManager:RewardManager;
		
		public function MaterialDetailDialog(supplier:SupplierDialog)
		{
			super();
			
			this.supplier = supplier;
			
			gemManager = new RewardManager(RewardManager.REWARD_GEM, RewardManager.SPAWN_LOW);
			
			overlay = new Quad(Starling.current.stage.stageWidth * 2.5,Starling.current.stage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialog = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_material_detail"));
			dialog.pivotX = dialog.width * 0.5;
			dialog.pivotY = dialog.height * 0.5;
			addChild(dialog);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = 120;
			buttonClose.y = -170;
			addChild(buttonClose);
			
			buttonPay = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_parameter"),"BUY THIS ITEM");
			buttonPay.pivotX = buttonPay.width * 0.5;
			buttonPay.y = 155;
			buttonPay.fontSize = 16;
			buttonPay.fontColor = 0xFFFFFF;
			buttonPay.fontBold = true;
			buttonPay.fontName = Assets.getFont(Assets.FONT_SSREGULAR).fontName;
			addChild(buttonPay);
						
			supplyPreview = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("material_chicken"));
			supplyPreview.pivotX = supplyPreview.width * 0.5;
			supplyPreview.pivotY = supplyPreview.height * 0.5;
			supplyPreview.y = -70;
			addChild(supplyPreview);
			
			labelText = new TextField(200, 25, "Product Name", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = -120;
			labelText.y = -10;
			addChild(labelText);
			
			nameText = new TextField(150, 25, "Name", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			nameText.hAlign = HAlign.RIGHT;
			nameText.x = -30;
			nameText.y = -10;
			addChild(nameText);
			
			labelText = new TextField(200, 25, "Product Price", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = -120;
			labelText.y = 10;
			addChild(labelText);
			
			priceText = new TextField(150, 25, "Price", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			priceText.hAlign = HAlign.RIGHT;
			priceText.x = -30;
			priceText.y = 10;
			addChild(priceText);
			
			labelText = new TextField(200, 25, "Expired For", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = -120;
			labelText.y = 30;
			addChild(labelText);
			
			expiredText = new TextField(150, 25, "expired", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			expiredText.hAlign = HAlign.RIGHT;
			expiredText.x = -30;
			expiredText.y = 30;
			addChild(expiredText);
			
			labelText = new TextField(200, 25, "Avaiable Item", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			labelText.hAlign = HAlign.LEFT;
			labelText.x = -120;
			labelText.y = 50;
			addChild(labelText);
			
			availableText = new TextField(150, 25, "total", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			availableText.hAlign = HAlign.RIGHT;
			availableText.x = -30;
			availableText.y = 50;
			addChild(availableText);
			
			labelText = new TextField(70, 25, "BUY FOR", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			labelText.hAlign = HAlign.CENTER;
			labelText.x = -100;
			labelText.y = 80;
			addChild(labelText);
			
			totalText = new TextField(70, 25, "0", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x333333);
			totalText.hAlign = HAlign.CENTER;
			totalText.x = -100;
			totalText.y = 105;
			addChild(totalText);
			
			decreaseTotal = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			decreaseTotal.pivotX = decreaseTotal.width * 0.5;
			decreaseTotal.pivotY = decreaseTotal.height * 0.5;
			decreaseTotal.x = -100;
			decreaseTotal.y = 120;
			addChild(decreaseTotal);
			
			increaseTotal = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			increaseTotal.pivotX = increaseTotal.width * 0.5;
			increaseTotal.pivotY = increaseTotal.height * 0.5;
			increaseTotal.x = -30;
			increaseTotal.y = 120;
			addChild(increaseTotal);
			
			labelText = new TextField(150, 25, "TOTAL PRICE", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			labelText.hAlign = HAlign.RIGHT;
			labelText.x = -30;
			labelText.y = 80;
			addChild(labelText);
			
			totalPriceText = new TextField(150, 25, "0", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			totalPriceText.hAlign = HAlign.RIGHT;
			totalPriceText.x = -30;
			totalPriceText.y = 105;
			addChild(totalPriceText);
			
			buttonPay.addEventListener(starling.events.Event.TRIGGERED, onItemPayed);
			buttonClose.addEventListener(starling.events.Event.TRIGGERED, onOrderCanceled);
			decreaseTotal.addEventListener(starling.events.Event.TRIGGERED, onTotalDecreased);
			increaseTotal.addEventListener(starling.events.Event.TRIGGERED, onTotalIncreased);
			
			confirmDialog = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Confirm");
			confirmDialog.addEventListener(DialogBoxEvent.CLOSED, onConfirmed);			
			addChild(confirmDialog);
			
			infoDialog = new NativeDialog(NativeDialog.DIALOG_INFORMATION);
			infoDialog.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void{infoDialog.closeDialog()});			
			addChild(infoDialog);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;			
		}
		
		private function onOrderCanceled(event:starling.events.Event):void
		{
			closeDialog();
		}
		
		private function onConfirmed(event:DialogBoxEvent):void
		{
			if(event.result)
			{
				var isItemExist:Boolean = false;
				var index:int = -1;
				for(var i:uint = 0;i<Data.inventory.length;i++)
				{
					if(Data.inventory[i].mtr_id==supply.productId && Data.inventory[i].pma_expired_remaining == supply.expiredRemaining)
					{
						isItemExist = true;
						index = i;
						break;
					}
				}
				
				var gameObject:Object 				= new Object();
				if(isItemExist)
				{
					var newStock:int = int(Data.inventory[index].pma_stock) + int(total);
					
					Game.loadingScreen.show();
					gameObject.token 				= Data.key;
					gameObject.action	 			= "update";
					gameObject.id		 			= Data.inventory[index].pma_id;
					gameObject.stock	 			= newStock;
					gameObject.expired	 			= supply.expiredRemaining;
				}
				else{					
					Game.loadingScreen.show();
					gameObject.token 				= Data.key;
					gameObject.action	 			= "new";
					gameObject.material	 			= supply.productId;
					gameObject.stock	 			= total;
					gameObject.expired	 			= supply.expiredRemaining;
										
				}	
				
				server = new ServerManager("inventory/buy_material",gameObject);
				server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void{
					Game.loadingScreen.hide();	
					
					var playerMaterial:String 	= server.received.player_material_var;
					
					if(JSON.parse(playerMaterial) as Array != null)		
						Data.inventory = JSON.parse(playerMaterial) as Array;		
					
					supply.quantityRemaining -= total;
					
					gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40, 100);
					
					dispatchEvent(new starling.events.Event(MaterialDetailDialog.BUY_ITEM));
				});
				server.sendRequest();
			}			
			
			confirmDialog.closeDialog();
			closeDialog();
		}
		
		public function getTotal():int
		{
			return totalPrice;
		}
		
		private function onTotalIncreased(event:starling.events.Event):void
		{
			if(total+10 <= supply.quantityRemaining)
			{
				total+=10;
				updatePrice();
			}			
		}
		
		private function onTotalDecreased(event:starling.events.Event):void
		{
			if(total-10 >= 0)
			{
				total-=10;
				updatePrice();
			}			
		}
		
		private function updatePrice():void
		{
			totalText.text = ValueFormatter.format(total);
			totalPriceText.text = "IDR "+ValueFormatter.format(supply.price * total);
			
			totalPrice = supply.price * total;
		}
		
		private function onItemPayed(event:starling.events.Event):void
		{			
			if(Data.cash < (supplier.totalInventoryBought + totalPrice))
			{
				infoDialog.dialogTitle = "Information";
				infoDialog.dialogMessage = "Your don't have enough money";
				infoDialog.openDialog();
			}
			else if(totalPrice <= 0)
			{
				infoDialog.dialogTitle = "Information";
				infoDialog.dialogMessage = "Buy at least 10 Item";
				infoDialog.openDialog();
			}
			else
			{
				confirmDialog.dialogMessage = "Buy Item : "+supply.itemName +" total "+total +" ?";
				confirmDialog.openDialog();
			}	
		}
		
		public function setCurrentSupply(supply:SupplyAdapter):void
		{
			total = 0;
			totalPrice = 0;
			
			this.supply = supply;
			
			supplyPreview.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(supply.texture);
			supplyPreview.readjustSize();
			
			nameText.text = supply.itemName;
			priceText.text = "IDR "+ValueFormatter.format(supply.price);
			expiredText.text = supply.expiredRemaining.toString();
			availableText.text = supply.quantityRemaining.toString();
			
			updatePrice();
		}
		
		public function openDialog():void
		{
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