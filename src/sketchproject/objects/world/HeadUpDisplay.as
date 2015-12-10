package sketchproject.objects.world
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.NavigationEvent;
	import sketchproject.events.ZoomEvent;
	import sketchproject.managers.FireworkParticleManager;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class HeadUpDisplay extends Sprite
	{
		protected var hudContainer:Sprite;
		protected var zoomContainer:Sprite;
		
		/** HUD component */
		protected var hudBase:Image;
		protected var hudIcon:Image;	
		
		protected var buttonAddCustomer:Button;
		protected var buttonAddPoint:Button;
		protected var buttonAddStar:Button;
		protected var buttonAddProfit:Button;
		
		protected var textProfit:TextField;
		protected var textPoint:TextField;
		protected var textCustomer:TextField;
		
		protected var customerBar:Image;		
		protected var starsContainer:Sprite;
		protected var star:Image;
		
		protected var buttonZoomIn:Button;
		protected var buttonZoomOut:Button;
		protected var zoomTrack:Image;
		protected var zoomSlider:Image;
		protected var zoomLabel:TextField;
		
		protected var cart:MobileCart;
		
		protected var fireworkManager:FireworkParticleManager;
		
		public function HeadUpDisplay()
		{
			super();
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			hudContainer = new Sprite();
			zoomContainer = new Sprite();
						
			/** HUD customer */
			hudBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_base"));
			hudBase.x = 120.35;
			hudBase.y = 19.45;			
			hudContainer.addChild(hudBase);
			
			hudIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_lighting"));
			hudIcon.x = 115.25;
			hudIcon.y = 12;
			hudContainer.addChild(hudIcon);
			
			customerBar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("blue_bar"));
			customerBar.x = 148;
			customerBar.y = 27;
			customerBar.width = 100;
			customerBar.height = 17;
			hudContainer.addChild(customerBar);
			
			textCustomer = new TextField(150,25,Data.customer+" / "+Data.valuePopulation, Assets.getFont(Assets.FONT_CORegular).fontName,13, 0xFFFFFF);
			textCustomer.hAlign = HAlign.LEFT;
			textCustomer.x = 160;
			textCustomer.y = 24;
			hudContainer.addChild(textCustomer);
			
			buttonAddCustomer = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus")); 
			buttonAddCustomer.x = 255.75;
			buttonAddCustomer.y = 24.95;
			buttonAddCustomer.scaleX = 0.7;
			buttonAddCustomer.scaleY = 0.7;
			hudContainer.addChild(buttonAddCustomer);
			
			/** HUD points */
			hudBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_base"));
			hudBase.x = 315.1;
			hudBase.y = 19.45;
			hudContainer.addChild(hudBase);
			
			hudIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_diamond"));
			hudIcon.x = 305.45;
			hudIcon.y = 18.5;
			hudContainer.addChild(hudIcon);
			
			textPoint = new TextField(150,25,ValueFormatter.format(Data.point)+" PTS", Assets.getFont(Assets.FONT_CORegular).fontName,13, 0xFFFFFF);
			textPoint.hAlign = HAlign.LEFT;
			textPoint.x = 346.45;
			textPoint.y = 24;
			hudContainer.addChild(textPoint);
			
			buttonAddPoint = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus")); 
			buttonAddPoint.x = 450.5;
			buttonAddPoint.y = 24.95;
			buttonAddPoint.scaleX = 0.7;
			buttonAddPoint.scaleY = 0.7;
			hudContainer.addChild(buttonAddPoint);
			
			/** HUD achievement */
			hudBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_base"));
			hudBase.x = 511.75;
			hudBase.y = 19.45;
			hudContainer.addChild(hudBase);
			
			hudIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_star"));
			hudIcon.x = 500.2;
			hudIcon.y = 14.7;
			hudContainer.addChild(hudIcon);
			
			starsContainer = new Sprite();
			starsContainer.x = 542;
			starsContainer.y = 27;
			for(var i:uint = 0; i<5;i++)
			{
				if(i < Data.stars)
				{
					star = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("star_big"));
				}
				else
				{
					star = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("star_base_big"));
				}				
				star.scaleX = 0.4;
				star.scaleY = 0.4;
				star.x = i * 20;
				starsContainer.addChild(star);
			}
			hudContainer.addChild(starsContainer);
			
			buttonAddStar = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus")); 
			buttonAddStar.x = 647.35;
			buttonAddStar.y = 24.95;
			buttonAddStar.scaleX = 0.7;
			buttonAddStar.scaleY = 0.7;
			hudContainer.addChild(buttonAddStar);
			
			/** HUD profit */
			hudBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_base"));
			hudBase.x = 707.05;
			hudBase.y = 19.45;
			hudContainer.addChild(hudBase);
			
			hudIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_coin"));
			hudIcon.x = 692.85;
			hudIcon.y = 15.45;
			hudContainer.addChild(hudIcon);
			
			textProfit = new TextField(150,25,"IDR "+ValueFormatter.format(Data.cash), Assets.getFont(Assets.FONT_CORegular).fontName,13, 0xFFFFFF);
			textProfit.hAlign = HAlign.LEFT;
			textProfit.x = 737.35;
			textProfit.y = 24;
			hudContainer.addChild(textProfit);
			
			buttonAddProfit = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus")); 
			buttonAddProfit.x = 842.5;
			buttonAddProfit.y = 23.6;
			buttonAddProfit.scaleX = 0.7;
			buttonAddProfit.scaleY = 0.7;
			hudContainer.addChild(buttonAddProfit);
			
			/** HUD zoom control */
			zoomTrack = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("zoom_track"));
			zoomTrack.x = 44.2;	
			zoomTrack.y = 345.5;
			zoomContainer.addChild(zoomTrack);
			
			buttonZoomIn = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("zoom_in"));
			buttonZoomIn.pivotX = buttonZoomIn.width * 0.5;
			buttonZoomIn.pivotY = buttonZoomIn.height * 0.5;
			buttonZoomIn.x = 100;
			buttonZoomIn.y = 346;
			zoomContainer.addChild(buttonZoomIn);
			
			buttonZoomOut = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("zoom_out"));
			buttonZoomOut.pivotX = buttonZoomOut.width * 0.5;
			buttonZoomOut.pivotY = buttonZoomOut.height * 0.5;
			buttonZoomOut.x = 38;
			buttonZoomOut.y = 392.95;
			zoomContainer.addChild(buttonZoomOut);
			
			zoomSlider = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("zoom_slider"));
			zoomSlider.x = 54.75;	
			zoomSlider.y = 358.6;			
			zoomContainer.addChild(zoomSlider);
			
			zoomLabel = new TextField(50,70,"2X Zoom", Assets.getFont(Assets.FONT_CORegular).fontName,13, 0xFFFFFF);
			zoomLabel.x = 80;
			zoomLabel.y = 353;
			zoomContainer.addChild(zoomLabel);
			
			hudContainer.addChild(zoomContainer);
			
			cart = new MobileCart();
			cart.x = 790;
			cart.y = 60;
			cart.startAdvisorSignal();
			hudContainer.addChild(cart);
			
			addChild(hudContainer);
			
			buttonAddCustomer.addEventListener(Event.TRIGGERED, onTrigerredCustomer);
			buttonAddPoint.addEventListener(Event.TRIGGERED, onTrigerredPoint);
			buttonAddStar.addEventListener(Event.TRIGGERED, onTrigerredStar);
			buttonAddProfit.addEventListener(Event.TRIGGERED, onTrigerredProfit);
			
			buttonZoomIn.addEventListener(Event.TRIGGERED, onTrigerredZoomIn);
			buttonZoomOut.addEventListener(Event.TRIGGERED, onTrigerredZoomOut);
			
			zoomControl(Config.zoom);
		}
		
		/** class function */
		public function hideHUD():void
		{
			hudContainer.visible = false;
		}
		
		public function showHUD():void
		{
			hudContainer.visible = true;
		}
		
		public function zoomControl(zoom:uint):void
		{
			switch(zoom)
			{
				case 1:
					zoomSlider.x = 40;	
					zoomSlider.y = 375;
					zoomLabel.text = "1X Zoom";
					break;
				case 2:
					zoomSlider.x = 54.75;	
					zoomSlider.y = 366.6;
					zoomLabel.text = "2X Zoom";
					break;
				case 3:
					zoomSlider.x = 66;	
					zoomSlider.y = 348;
					zoomLabel.text = "3X Zoom";
					break;
			}
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
		}
		
		public function update():void
		{
			textPoint.text = ValueFormatter.format(Data.point)+" PTS";
			textProfit.text = "IDR "+ValueFormatter.format(Data.cash);
			textCustomer.text = int(Data.customer).toString();
		}
		
		public function destroy():void
		{
			cart.stopAdvisorSignal();
			removeFromParent(true);
		}
		
		public function addTaskList(taskContainer:DisplayObjectContainer):void
		{
			hudContainer.addChild(taskContainer);
		}
		
		/** panel event dispatch */
		private function onTrigerredCustomer(event:Event):void
		{
			//Assets.sfxChannel = Assets.sfxCustomer.play(0,0,Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_CUSTOMER));
		}
		private function onTrigerredPoint(event:Event):void
		{
			//Assets.sfxChannel = Assets.sfxTaskList.play(0,0,Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_POINT));
		}
		private function onTrigerredStar(event:Event):void
		{
			//Assets.sfxChannel = Assets.sfxAchievement.play(0,0,Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_STAR));
		}
		private function onTrigerredProfit(event:Event):void
		{
			//Assets.sfxChannel = Assets.sfxProfit.play(0,0,Assets.sfxTransform);
			dispatchEvent(new NavigationEvent(NavigationEvent.SWITCH, NavigationEvent.NAVIGATE_PROFIT));
		}
		
		
		/** zoom event dispatch */
		private function onTrigerredZoomIn(event:Event):void
		{
			dispatchEvent(new ZoomEvent(ZoomEvent.ZOOM_IN));
		}
		private function onTrigerredZoomOut(event:Event):void
		{
			dispatchEvent(new ZoomEvent(ZoomEvent.ZOOM_OUT));
		}
	}
}