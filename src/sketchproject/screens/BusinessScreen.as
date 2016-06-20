package sketchproject.screens
{	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.objects.world.GameMenu;
	import sketchproject.objects.business.HomeFrame;
	import sketchproject.objects.business.ScheduleFrame;
	import sketchproject.objects.business.ShopFrame;
	import sketchproject.objects.business.StartupFrame;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Manage business schedule, basic info, atribute and features.
	 * 
	 * @author Angga
	 */
	public class BusinessScreen extends GameScreen
	{
		private var shop:ShopFrame;
		private var schedule:ScheduleFrame;
		private var startup:StartupFrame;
		private var home:HomeFrame;
				
		private var buttonShop:Button;
		private var buttonSchedule:Button;
		private var buttonStartup:Button;
		private var buttonHome:Button;
		
		private var hud:GameMenu;
		
		/**
		 * Default constructor of BusinessScreen.
		 * 
		 * @param hud
		 */
		public function BusinessScreen(hud:GameMenu)
		{
			super();
			
			this.hud = hud;
			
			shop = new ShopFrame();
			addChild(shop);
			
			schedule = new ScheduleFrame();
			schedule.y = 20;
			addChild(schedule);
			
			startup = new StartupFrame();
			startup.y = 10;
			addChild(startup);
			
			home = new HomeFrame();
			addChild(home);
						
			buttonShop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_business_shop"));
			buttonShop.pivotX = buttonShop.width * 0.5;
			buttonShop.pivotY = buttonShop.height;	
			buttonShop.addEventListener(Event.TRIGGERED, onShopTriggered);
			buttonContainer.addChild(buttonShop);
			
			buttonSchedule = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_business_schedule"));
			buttonSchedule.pivotX = buttonSchedule.width * 0.5;
			buttonSchedule.pivotY = buttonSchedule.height;
			buttonSchedule.x = 150;
			buttonSchedule.addEventListener(Event.TRIGGERED, onScheduleTriggered);
			buttonContainer.addChild(buttonSchedule);
			
			buttonStartup = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_business_startup"));
			buttonStartup.pivotX = buttonStartup.width * 0.5;
			buttonStartup.pivotY = buttonStartup.height;
			buttonStartup.x = 300;
			buttonStartup.addEventListener(Event.TRIGGERED, onStartupTriggered);
			buttonContainer.addChild(buttonStartup);
			
			buttonHome = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_business_home"));
			buttonHome.pivotX = buttonHome.width * 0.5;
			buttonHome.pivotY = buttonHome.height;
			buttonHome.x = 450;
			buttonHome.addEventListener(Event.TRIGGERED, onHomeTriggered);
			buttonContainer.addChild(buttonHome);
			
			buttonContainer.x = Starling.current.stage.stageWidth * 0.5 - buttonContainer.width * 0.5 + buttonShop.width * 0.5;
			buttonContainer.y = 460;
			buttonContainer.visible = false;			
			hud.containerDashboard.addChild(buttonContainer);

			switchPage(shop);
		}
		
		/**
		 * Home sub menu of business triggered, switch screen into home feature.
		 * 
		 * @param event
		 */
		private function onHomeTriggered(event:Event):void
		{
			switchPage(home);
			Assets.sfxChannel = Assets.sfxHomeStatistic.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		/**
		 * Startup sub menu of business triggered, switch screen into startup business.
		 * 
		 * @param event
		 */
		private function onStartupTriggered(event:Event):void
		{
			switchPage(startup);
			Assets.sfxChannel = Assets.sfxBusinessStartup.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		/**
		 * Schedule sub menu of business triggered, switch screen manage shop scredules.
		 * 
		 * @param event
		 */
		private function onScheduleTriggered(event:Event):void
		{
			switchPage(schedule);
			Assets.sfxChannel = Assets.sfxBusinessOperation.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		/**
		 * Shop sub menu of business triggered, switch screen show basic information.
		 * 
		 * @param event
		 */
		private function onShopTriggered(event:Event):void
		{
			switchPage(shop);
			Assets.sfxChannel = Assets.sfxShopOverview.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		/**
		 * Switch screen, hide all screen then visible passed screen.
		 * 
		 * @param page
		 */
		private function switchPage(page:Sprite):void
		{
			shop.visible = false;
			schedule.visible = false;
			startup.visible = false;
			home.visible = false;
			
			page.visible = true;
		}
		
		/**
		 * Update all screens content.
		 */
		public function update():void
		{
			shop.updateStatus();
			schedule.updateTimeline();
			startup.updateAttribute();
			home.updateInfo();
		}
	}
}