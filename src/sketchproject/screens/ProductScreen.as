package sketchproject.screens
{
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.objects.world.GameMenu;
	import sketchproject.objects.product.InventoryFrame;
	import sketchproject.objects.product.ProductFrame;
	import sketchproject.objects.product.SupplierFrame;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ProductScreen extends GameScreen
	{
		private var buttonProduct:Button;
		private var buttonInventory:Button;
		private var buttonSupplier:Button;
		
		private var product:ProductFrame;
		private var inventory:InventoryFrame;
		private var supplier:SupplierFrame;
		
		private var hud:GameMenu;
		
		public function ProductScreen(hud:GameMenu)
		{
			super();
			
			this.hud = hud;
			
			product = new ProductFrame();
			addChild(product);
			
			inventory = new InventoryFrame();
			inventory.x = Starling.current.stage.stageWidth * 0.5;
			inventory.y = Starling.current.stage.stageHeight * 0.5;
			inventory.name = "inventoryDialog";
			Game.overlayStage.addChild(inventory);
			
			supplier = new SupplierFrame();
			addChild(supplier);
			
			buttonProduct = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_product_product"));
			buttonProduct.pivotX = buttonProduct.width * 0.5;
			buttonProduct.pivotY = buttonProduct.height;	
			buttonProduct.addEventListener(Event.TRIGGERED, onProductTriggered);
			buttonContainer.addChild(buttonProduct);
			
			buttonInventory = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_product_inventory"));
			buttonInventory.pivotX = buttonInventory.width * 0.5;
			buttonInventory.pivotY = buttonInventory.height;
			buttonInventory.x = 150;
			buttonInventory.addEventListener(Event.TRIGGERED, onInventoryTriggered);
			buttonContainer.addChild(buttonInventory);
			
			buttonSupplier = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_product_supplier"));
			buttonSupplier.pivotX = buttonSupplier.width * 0.5;
			buttonSupplier.pivotY = buttonSupplier.height;
			buttonSupplier.x = 300;
			buttonSupplier.addEventListener(Event.TRIGGERED, onSupplierTriggered);
			buttonContainer.addChild(buttonSupplier);
			
			buttonContainer.x = Starling.current.stage.stageWidth * 0.5 - buttonContainer.width * 0.5 + buttonProduct.width * 0.5;
			buttonContainer.y = 460;
			buttonContainer.visible = false;			
			hud.containerDashboard.addChild(buttonContainer);
			
			switchPage(product);
		}
		
		private function onProductTriggered(event:Event):void
		{
			switchPage(product);
			Assets.sfxChannel = Assets.sfxProductList.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function onInventoryTriggered():void
		{
			inventory.openDialog();
			Assets.sfxChannel = Assets.sfxInventory.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function onSupplierTriggered():void
		{
			switchPage(supplier);
			Assets.sfxChannel = Assets.sfxSupplier.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function switchPage(page:Sprite):void
		{			
			product.visible = false;
			supplier.visible = false;
			
			page.visible = true;
		}
	}
}