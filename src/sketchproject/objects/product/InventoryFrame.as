package sketchproject.objects.product
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkManager;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.objects.product.inventory.InventoryAssets;
	import sketchproject.objects.product.inventory.InventoryMaterial;
	import sketchproject.objects.product.inventory.InventoryProduct;
	import sketchproject.objects.product.inventory.InventoryUpgrade;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.deg2rad;
	
	public class InventoryFrame extends Sprite
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var buttonClose:Button;
		private var buttonExchange:Button;
		private var selectMenu:Image;
		
		private var cash:TextField;
		private var point:TextField;
		private var label:TextField;
		
		private var material:TextField;
		private var product:TextField;
		private var upgrade:TextField;
		private var assets:TextField;

		private var materialFrame:InventoryMaterial;
		private var productFrame:InventoryProduct;
		private var upgradeFrame:InventoryUpgrade;
		private var assetsFrame:InventoryAssets;
		
		private var fireworkManager:FireworkManager;
		
		public function InventoryFrame()
		{
			super();
			
			fireworkManager = new FireworkManager(Game.overlayStage);
			
			overlay = new Quad(Starling.current.stage.stageWidth * 2.5,Starling.current.stage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialogBase = new Image(Assets.getAtlas(Assets.PANEL, Assets.PANEL_XML).getTexture("dialog_inventory"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
			
			selectMenu = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("inventory_select"));
			selectMenu.x = -390;
			selectMenu.y = -127;
			addChild(selectMenu);
			
			material = new TextField(200, 50, "Material", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			material.x = -390;
			material.y = -120;
			addChild(material);
			
			product = new TextField(200, 50, "Product", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			product.x = -390;
			product.y = -70;
			addChild(product);
			
			upgrade = new TextField(200, 50, "Upgrade", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			upgrade.x = -390;
			upgrade.y = -20;
			addChild(upgrade);
			
			assets = new TextField(200, 50, "Assets", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			assets.x = -390;
			assets.y = 30;
			addChild(assets);
			
			dialogBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_coin"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			dialogBase.x = 190;
			dialogBase.y = -207;
			addChild(dialogBase);
			
			cash = new TextField(200, 50, "IDR "+ValueFormatter.format(Data.cash), Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			cash.x = 210;
			cash.y = -233;
			cash.rotation = deg2rad(-4);
			cash.hAlign = HAlign.LEFT;
			addChild(cash);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = 380;
			buttonClose.y = -220;
			addChild(buttonClose);
			
			label = new TextField(200, 50, "Points", Assets.getFont(Assets.FONT_CORegular).fontName, 14, 0xFFFFFF);
			label.hAlign =HAlign.LEFT;
			label.x = -360;
			label.y = 135;			
			label.rotation = deg2rad(-8);
			addChild(label);
			
			point = new TextField(200, 50, ValueFormatter.format(Data.point)+" PTS", Assets.getFont(Assets.FONT_CORegular).fontName, 15, 0xFFFFFF);
			point.hAlign =HAlign.LEFT;
			point.x = -360;
			point.y = 152;
			point.rotation = deg2rad(-8);
			addChild(point);
			
			dialogBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_diamond"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			dialogBase.x = -375;
			dialogBase.y = 170;
			addChild(dialogBase);
			
			buttonExchange = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_exchange"));
			buttonExchange.pivotX = buttonExchange.width * 0.5;
			buttonExchange.pivotY = buttonExchange.height * 0.5;
			buttonExchange.x = -225;
			buttonExchange.y = 155;
			buttonExchange.rotation = deg2rad(-3);
			//addChild(buttonExchange);
			
			materialFrame = new InventoryMaterial();
			materialFrame.x = -150;
			materialFrame.y = -210;
			addChild(materialFrame);
			
			productFrame = new InventoryProduct();
			productFrame.x = -150;
			productFrame.y = -210;
			addChild(productFrame);
			
			upgradeFrame = new InventoryUpgrade();
			upgradeFrame.x = -150;
			upgradeFrame.y = -210;
			addChild(upgradeFrame);
			
			assetsFrame = new InventoryAssets();
			assetsFrame.x = -150;
			assetsFrame.y = -210;
			addChild(assetsFrame);
			
			addEventListener(TouchEvent.TOUCH, onMenuTouched);
			
			buttonClose.addEventListener(Event.TRIGGERED, onClosed);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
			
			switchPage(materialFrame);
		}
		
		private function onClosed(event:Event):void
		{
			if(materialFrame.getTotalThrowed() > 0)
			{
				var dialog:PostDialog = new PostDialog("Loss",materialFrame.getTotalThrowed(),false);
				dialog.x = stage.stageWidth * 0.5;
				dialog.y = stage.stageHeight * 0.5;
				Game.overlayStage.addChild(dialog);
				dialog.openDialog();
			}			
			closeDialog(); 
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function onMenuTouched(touch:TouchEvent):void
		{
			if(touch.getTouch(material, TouchPhase.ENDED)){
				TweenMax.to(selectMenu,0.3,{y:TextField(touch.target).y-7});
				materialFrame.update();
				switchPage(materialFrame);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if(touch.getTouch(product, TouchPhase.ENDED)){
				TweenMax.to(selectMenu,0.3,{y:TextField(touch.target).y-7});
				productFrame.update();
				switchPage(productFrame);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if(touch.getTouch(upgrade, TouchPhase.ENDED)){
				TweenMax.to(selectMenu,0.3,{y:TextField(touch.target).y-7});
				upgradeFrame.update();
				switchPage(upgradeFrame);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if(touch.getTouch(assets, TouchPhase.ENDED)){
				TweenMax.to(selectMenu,0.3,{y:TextField(touch.target).y-7});
				assetsFrame.update();
				switchPage(assetsFrame);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}				
		}		
		
		private function switchPage(frame:Sprite):void
		{			
			materialFrame.visible = false;
			productFrame.visible = false;
			upgradeFrame.visible = false;
			assetsFrame.visible = false;
			
			frame.visible = true;
		}
		
		public function openDialog():void
		{
			materialFrame.update();
			productFrame.update();
			upgradeFrame.update();
			assetsFrame.update();
			
			cash.text = "IDR "+ValueFormatter.format(Data.cash);
			
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