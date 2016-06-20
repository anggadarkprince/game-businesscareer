package sketchproject.screens
{
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.objects.world.GameMenu;
	import sketchproject.objects.advertising.AdvertisementFrame;
	import sketchproject.objects.advertising.ResearchFrame;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Show and manage advertisement.
	 *
	 * @author Angga
	 */
	public class AdvertisingScreen extends GameScreen
	{
		private var buttonAdvertisement:Button;
		private var buttonResearch:Button;

		private var advertisement:AdvertisementFrame;
		private var research:ResearchFrame;
		private var hud:GameMenu;

		/**
		 * Default constructor of AdvertisingScreen
		 * @param hud
		 */
		public function AdvertisingScreen(hud:GameMenu)
		{
			super();

			this.hud = hud;

			advertisement = new AdvertisementFrame();
			addChild(advertisement);

			research = new ResearchFrame();
			addChild(research);

			buttonAdvertisement = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_adver_advertisement"));
			buttonAdvertisement.pivotX = buttonAdvertisement.width * 0.5;
			buttonAdvertisement.pivotY = buttonAdvertisement.height;
			buttonAdvertisement.addEventListener(Event.TRIGGERED, onAdvertisementTriggered);
			buttonContainer.addChild(buttonAdvertisement);

			buttonResearch = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_adver_research"));
			buttonResearch.pivotX = buttonResearch.width * 0.5;
			buttonResearch.pivotY = buttonResearch.height;
			buttonResearch.x = 150;
			buttonResearch.addEventListener(Event.TRIGGERED, onResearchTriggered);
			buttonContainer.addChild(buttonResearch);

			buttonContainer.x = Starling.current.stage.stageWidth * 0.5 - buttonContainer.width * 0.5 + buttonAdvertisement.width * 0.5;
			buttonContainer.y = 460;
			buttonContainer.visible = false;
			hud.containerDashboard.addChild(buttonContainer);

			switchPage(advertisement);
		}

		/**
		 * Switch page to advertisement sub screen.
		 *
		 * @param event
		 */
		private function onAdvertisementTriggered(event:Event):void
		{
			switchPage(advertisement);
			Assets.sfxChannel = Assets.sfxAdvertisement.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}

		/**
		 * Switch page to research sub screen.
		 */
		private function onResearchTriggered():void
		{
			switchPage(research);
			Assets.sfxChannel = Assets.sfxResearchPromotion.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}

		/**
		 * Switch sub screen control.
		 *
		 * @param page
		 */
		private function switchPage(page:Sprite):void
		{
			advertisement.visible = false;
			research.visible = false;

			page.visible = true;
		}
	}
}
