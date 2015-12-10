package sketchproject.objects.dialog
{	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.managers.DataManager;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class StartupDialog extends DialogOverlay
	{		
		public static const STARTUP_BUSINESS:String = "business plan";
		public static const STARTUP_OBJECTIVE:String = "business objective";
		public static const STARTUP_FINANCE:String = "business finance";
		public static const STARTUP_PARAMETER:String = "business parameter";
		
		private var startupType:String;
		private var buttonOk:Button;
		private var titleText:TextField;
		
		private var server:DataManager;
		
		private var buttonRightPopulation:Button;
		private var buttonLeftPopulation:Button;
		private var buttonRightWheater:Button;
		private var buttonLeftWheater:Button;
		private var buttonRightEvent:Button;
		private var buttonLeftEvent:Button;
		private var buttonRightCompetitor:Button;
		private var buttonLeftCompetitor:Button;
		
		private var buttonRightVariant:Button;
		private var buttonLeftVariant:Button;
		private var buttonRightAddicted:Button;
		private var buttonLeftAddicted:Button;
		private var buttonRightBuying:Button;
		private var buttonLeftBuying:Button;
		private var buttonRightEmotion:Button;
		private var buttonLeftEmotion:Button;
		
		private var sliderPopulation:Image;
		private var sliderWheater:Image;
		private var sliderEvent:Image;
		private var sliderCompetitor:Image;
		
		private var sliderVariant:Image;
		private var sliderAddicted:Image;
		private var sliderBuying:Image;
		private var sliderEmotion:Image;
		
		private var worldLeft:uint;
		private var worldRight:uint;
		
		private var customerLeft:uint;
		private var customerRight:uint;
		
		private var distance:uint;
				
		public function StartupDialog(startup:String)
		{
			super(false);
			
			server = new DataManager();
			
			startupType = startup;
			
			switch(startup){
				case STARTUP_BUSINESS:
					overlay = new Quad(570,360);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					addChild(overlay);
					
					overlay = new Quad(570,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = -126;
					addChild(overlay);
					
					overlay = new Quad(570,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = 115;
					addChild(overlay);
										
					titleText = new TextField(170, 50, "No Title", Assets.getFont(Assets.FONT_SSBOLD).fontName, 26, 0x454545);
					titleText.pivotX = titleText.width * 0.5;
					titleText.vAlign = VAlign.TOP;
					titleText.y = -170;
					addChild(titleText);
					
					buttonOk = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
					buttonOk.pivotX = buttonOk.width * 0.5;
					buttonOk.pivotY = buttonOk.height * 0.5;
					buttonOk.y = 145;
					buttonOk.addEventListener(Event.TRIGGERED, function(event:Event):void{
						closeDialog();
					});
					addChild(buttonOk);
					
					layoutBusinessPlan();
					break;
				case STARTUP_OBJECTIVE:
					overlay = new Quad(570,360);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					addChild(overlay);
					
					overlay = new Quad(570,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = -126;
					addChild(overlay);
					
					overlay = new Quad(570,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = 115;
					addChild(overlay);
										
					titleText = new TextField(170, 50, "No Title", Assets.getFont(Assets.FONT_SSBOLD).fontName, 26, 0x454545);
					titleText.pivotX = titleText.width * 0.5;
					titleText.vAlign = VAlign.TOP;
					titleText.y = -170;
					addChild(titleText);
					
					buttonOk = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
					buttonOk.pivotX = buttonOk.width * 0.5;
					buttonOk.pivotY = buttonOk.height * 0.5;
					buttonOk.y = 145;
					buttonOk.addEventListener(Event.TRIGGERED, function(event:Event):void{
						closeDialog();
					});
					addChild(buttonOk);
					
					layoutPersonalObjective();
					break;
				case STARTUP_FINANCE:
					overlay = new Quad(450,400);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					addChild(overlay);
					
					overlay = new Quad(450,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = -146;
					addChild(overlay);
					
					overlay = new Quad(450,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = 135;
					addChild(overlay);
										
					titleText = new TextField(170, 50, "No Title", Assets.getFont(Assets.FONT_SSBOLD).fontName, 26, 0x454545);
					titleText.pivotX = titleText.width * 0.5;
					titleText.vAlign = VAlign.TOP;
					titleText.y = -190;
					addChild(titleText);
					
					buttonOk = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
					buttonOk.pivotX = buttonOk.width * 0.5;
					buttonOk.pivotY = buttonOk.height * 0.5;
					buttonOk.y = 165;
					buttonOk.addEventListener(Event.TRIGGERED, function(event:Event):void{
						closeDialog();
					});
					addChild(buttonOk);
					
					layoutSeedFinancing();
					break;
				case STARTUP_PARAMETER:
					overlay = new Quad(800,430);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					addChild(overlay);
					
					overlay = new Quad(450,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = -160;
					addChild(overlay);
					
					overlay = new Quad(450,2,0x666666);
					overlay.pivotX = overlay.width * 0.5;
					overlay.pivotY = overlay.height * 0.5;
					overlay.y = 150;
					addChild(overlay);
					
					titleText = new TextField(170, 50, "No Title", Assets.getFont(Assets.FONT_SSBOLD).fontName, 26, 0x454545);
					titleText.pivotX = titleText.width * 0.5;
					titleText.vAlign = VAlign.TOP;
					titleText.y = -205;
					addChild(titleText);
					
					buttonOk = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
					buttonOk.pivotX = buttonOk.width * 0.5;
					buttonOk.pivotY = buttonOk.height * 0.5;
					buttonOk.y = 180;
					buttonOk.addEventListener(Event.TRIGGERED, function(event:Event):void{
						closeDialog();
					});
					addChild(buttonOk);
					
					layoutGameParameter();
					
					worldLeft = 230;
					worldRight = 230 + 170 - sliderPopulation.width;
					customerLeft = 600;
					customerRight = 690 + 170 - sliderPopulation.width;
					distance = worldRight - worldLeft;
					
					break;
			}
			
			scaleX = 1;
			scaleY = 1;
			alpha = 1;
		}
		
		public function layoutBusinessPlan():void
		{
			titleText.text = "Business Plan";
						
			var businessPlan:TextField = new TextField(500,220,Data.businessPlan,Assets.getFont(Assets.FONT_SSREGULAR).fontName,12);
			businessPlan.x = -250;
			businessPlan.y = -115;
			businessPlan.vAlign = VAlign.TOP;
			businessPlan.hAlign = HAlign.LEFT;
			addChild(businessPlan);
		}
		
		public function layoutPersonalObjective():void
		{
			titleText.text = "Personal Objective";
			
			var personalObjective:TextField = new TextField(500,220,Data.personalObjective,Assets.getFont(Assets.FONT_SSREGULAR).fontName,12);
			personalObjective.x = -250;
			personalObjective.y = -115;
			personalObjective.vAlign = VAlign.TOP;
			personalObjective.hAlign = HAlign.LEFT;
			addChild(personalObjective);
		}
		
		public function layoutSeedFinancing():void
		{
			titleText.text = "Startup Financing";
			
			var container:Sprite = new Sprite();
			container.x = -700;
			container.y = -210;
			
			var text:TextField = new TextField(300, 50, "Cart", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 70;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "5.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 70;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			text = new TextField(300, 50, "Equipment", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 90;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "300.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 90;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			text = new TextField(300, 50, "Permits", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 110;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "750.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 110;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			text = new TextField(300, 50, "Sign", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 130;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "500.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 130;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			text = new TextField(300, 50, "Insurance", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 150;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "300.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 150;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			var line:Quad = new Quad(300,5,0x333333);
			line.x = 550;
			line.y = 200;
			container.addChild(line);
			
			text = new TextField(200, 50, "Total Startup Cost", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 550;
			text.y = 200;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "6.850.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 700;
			text.y = 200;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			text = new TextField(200, 50, "Working Capital", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 550;
			text.y = 230;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "3.150.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 700;
			text.y = 230;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			line = new Quad(300,5,0x333333);
			line.x = 550;
			line.y = 275;
			container.addChild(line);
			
			text = new TextField(300, 50, "Total Seed Financing", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 550;
			text.y = 280;
			text.hAlign = HAlign.LEFT;
			container.addChild(text);
			
			text = new TextField(150, 50, "10.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 700;
			text.y = 280;
			text.hAlign = HAlign.RIGHT;
			container.addChild(text);
			
			container.flatten();
			
			addChild(container);
		}
		
		public function layoutGameParameter():void
		{
			var textLabelParameter:Array = ["Population", "Social Variant", "Wheater Chaos", "Addicted Level", "Event Traffict", "Buying Power", "Competitor", "Emotion Chaos"];
			
			titleText.text = "Startup Parameter";
			
			var container:Sprite = new Sprite();
			container.x = -500;
			container.y = -215;
			
			for(var i:uint = 0; i< 8; i++)
			{
				var gearLabel:Image = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dark_gear"));
				gearLabel.x = 370 * (i % 2) + 200; 
				gearLabel.y =  70 * int(i/2) + 70;
				container.addChild(gearLabel);
				
				var labelParameter:TextField = new TextField(150, 20, textLabelParameter[i], Assets.getFont("FontErasITC").fontName, 18, 0x333333);
				labelParameter.x = 370 * (i % 2) + 225;
				labelParameter.y = 70 * int(i/2) + 70;
				labelParameter.hAlign = HAlign.LEFT;
				container.addChild(labelParameter);
				
				var backgroundSet:Quad = new Quad(170,25,0xDDDDDD);
				backgroundSet.x = 370 * (i % 2) + 230;
				backgroundSet.y =  70 * int(i/2) + 100;
				container.addChild(backgroundSet);
			}
			
			
			
			/** world **/
			buttonRightPopulation = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightPopulation.x = 400;
			buttonRightPopulation.y = 100 - 3;
			container.addChild(buttonRightPopulation);
			
			buttonLeftPopulation = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftPopulation.x = 230;
			buttonLeftPopulation.y = 100 - 3;
			buttonLeftPopulation.scaleX = -1;
			container.addChild(buttonLeftPopulation);
			
			sliderPopulation = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderPopulation.x = 300;
			sliderPopulation.y = 100;
			container.addChild(sliderPopulation);
			
			
			buttonRightWheater = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightWheater.x = 400;
			buttonRightWheater.y = 170 - 3;
			container.addChild(buttonRightWheater);
			
			buttonLeftWheater = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftWheater.x = 230;
			buttonLeftWheater.y = 170 - 3;
			buttonLeftWheater.scaleX = -1;
			container.addChild(buttonLeftWheater);
			
			sliderWheater = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderWheater.x = 300;
			sliderWheater.y = 170;
			container.addChild(sliderWheater);
			
			
			buttonRightEvent = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightEvent.x = 400;
			buttonRightEvent.y = 240 - 3;
			container.addChild(buttonRightEvent);
			
			buttonLeftEvent = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftEvent.x = 230;
			buttonLeftEvent.y = 240 - 3;
			buttonLeftEvent.scaleX = -1;
			container.addChild(buttonLeftEvent);
			
			sliderEvent = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderEvent.x = 300;
			sliderEvent.y = 240;
			container.addChild(sliderEvent);
			
			
			buttonRightCompetitor = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightCompetitor.x = 400;
			buttonRightCompetitor.y = 310 - 3;
			container.addChild(buttonRightCompetitor);
			
			buttonLeftCompetitor = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftCompetitor.x = 230;
			buttonLeftCompetitor.y = 310 - 3;
			buttonLeftCompetitor.scaleX = -1;
			container.addChild(buttonLeftCompetitor);
			
			sliderCompetitor = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderCompetitor.x = 300;
			sliderCompetitor.y = 310;
			container.addChild(sliderCompetitor);
			
			/** customer **/
			buttonRightVariant = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightVariant.x = 770;
			buttonRightVariant.y = 100 - 3;
			container.addChild(buttonRightVariant);
			
			buttonLeftVariant = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftVariant.x = 600;
			buttonLeftVariant.y = 100 - 3;
			buttonLeftVariant.scaleX = -1;
			container.addChild(buttonLeftVariant);
			
			sliderVariant = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderVariant.x = 700;
			sliderVariant.y = 100;
			container.addChild(sliderVariant);
			
			
			buttonRightAddicted = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightAddicted.x = 770;
			buttonRightAddicted.y = 170 - 3;
			container.addChild(buttonRightAddicted);
			
			buttonLeftAddicted = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftAddicted.x = 600;
			buttonLeftAddicted.y = 170 - 3;
			buttonLeftAddicted.scaleX = -1;
			container.addChild(buttonLeftAddicted);
			
			sliderAddicted = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderAddicted.x = 700;
			sliderAddicted.y = 170;
			container.addChild(sliderAddicted);
			
			
			buttonRightBuying = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightBuying.x = 770;
			buttonRightBuying.y = 240 - 3;
			container.addChild(buttonRightBuying);
			
			buttonLeftBuying = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftBuying.x = 600;
			buttonLeftBuying.y = 240 - 3;
			buttonLeftBuying.scaleX = -1;
			container.addChild(buttonLeftBuying);
			
			sliderBuying = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderBuying.x = 700;
			sliderBuying.y = 240;
			container.addChild(sliderBuying);
			
			
			buttonRightEmotion = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightEmotion.x = 770;
			buttonRightEmotion.y = 310 - 3;
			container.addChild(buttonRightEmotion);
			
			buttonLeftEmotion = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftEmotion.x = 600;
			buttonLeftEmotion.y = 310 - 3;
			buttonLeftEmotion.scaleX = -1;
			container.addChild(buttonLeftEmotion);
			
			sliderEmotion = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderEmotion.x = 700;
			sliderEmotion.y = 310;
			container.addChild(sliderEmotion);
			
			addChild(container);
			
			addEventListener(TouchEvent.TOUCH, onSliderTouched);
		}
		
		private function onSliderTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(sliderPopulation, TouchPhase.MOVED))
			{
				if(sliderPopulation.x >= worldLeft && sliderPopulation.x <= worldRight){
					sliderPopulation.x = touch.getTouch(this).getLocation(this).x - sliderPopulation.width * 0.5;
				}
				if(sliderPopulation.x < worldLeft)
				{
					sliderPopulation.x = worldLeft;
				}
				if(sliderPopulation.x > worldRight)
				{
					sliderPopulation.x = worldRight;
				}
				Data.valuePopulation = 1000  * (sliderPopulation.x - worldLeft) / (170 - sliderPopulation.width);
				Data.valuePopulation-=int(Data.valuePopulation % 20);
			}
			
			if (touch.getTouch(sliderWheater, TouchPhase.MOVED))
			{
				if(sliderWheater.x >= worldLeft && sliderWheater.x <= worldRight){
					sliderWheater.x = touch.getTouch(this).getLocation(this).x - sliderWheater.width * 0.5;
				}
				if(sliderWheater.x < worldLeft)
				{
					sliderWheater.x = worldLeft;
				}
				if(sliderWheater.x > worldRight)
				{
					sliderWheater.x = worldRight;
				}
				Data.valueWeather = 10  * (sliderWheater.x - worldLeft) / (170 - sliderWheater.width);
			}
			
			if (touch.getTouch(sliderEvent, TouchPhase.MOVED))
			{
				if(sliderEvent.x >= worldLeft && sliderEvent.x <= worldRight){
					sliderEvent.x = touch.getTouch(this).getLocation(this).x - sliderEvent.width * 0.5;
				}
				if(sliderEvent.x < worldLeft)
				{
					sliderEvent.x = worldLeft;
				}
				if(sliderEvent.x > worldRight)
				{
					sliderEvent.x = worldRight;
				}
				Data.valueEvent = 10  * (sliderEvent.x - worldLeft) / (170 - sliderEvent.width);
			}
			
			if (touch.getTouch(sliderCompetitor, TouchPhase.MOVED))
			{
				if(sliderCompetitor.x >= worldLeft && sliderCompetitor.x <= worldRight){
					sliderCompetitor.x = touch.getTouch(this).getLocation(this).x - sliderCompetitor.width * 0.5;
				}
				if(sliderCompetitor.x < worldLeft)
				{
					sliderCompetitor.x = worldLeft;
				}
				if(sliderCompetitor.x > worldRight)
				{
					sliderCompetitor.x = worldRight;
				}
				Data.valueCompetitor = 10  * (sliderCompetitor.x - worldLeft) / (170 - sliderCompetitor.width);
			}
			
			if (touch.getTouch(sliderVariant, TouchPhase.MOVED))
			{
				if(sliderVariant.x >= customerLeft && sliderVariant.x <= customerRight){
					sliderVariant.x = touch.getTouch(this).getLocation(this).x - sliderVariant.width * 0.5;
				}
				if(sliderVariant.x < customerLeft)
				{
					sliderVariant.x = customerLeft;
				}
				if(sliderVariant.x > customerRight)
				{
					sliderVariant.x = customerRight;
				}
				Data.valueVariant = 10  * (sliderVariant.x - customerLeft) / (170 - sliderVariant.width);
			}
			
			if (touch.getTouch(sliderAddicted, TouchPhase.MOVED))
			{
				if(sliderAddicted.x >= customerLeft && sliderAddicted.x <= customerRight){
					sliderAddicted.x = touch.getTouch(this).getLocation(this).x - sliderAddicted.width * 0.5;
				}
				if(sliderAddicted.x < customerLeft)
				{
					sliderAddicted.x = customerLeft;
				}
				if(sliderAddicted.x > customerRight)
				{
					sliderAddicted.x = customerRight;
				}
				Data.valueAddicted = 10  * (sliderAddicted.x - customerLeft) / (170 - sliderAddicted.width);
			}
			
			if (touch.getTouch(sliderBuying, TouchPhase.MOVED))
			{
				if(sliderBuying.x >= customerLeft && sliderBuying.x <= customerRight){
					sliderBuying.x = touch.getTouch(this).getLocation(this).x - sliderBuying.width * 0.5;
				}
				if(sliderBuying.x < customerLeft)
				{
					sliderBuying.x = customerLeft;
				}
				if(sliderBuying.x > customerRight)
				{
					sliderBuying.x = customerRight;
				}
				Data.valueBuying = 10  * (sliderBuying.x - customerLeft) / (170 - sliderBuying.width);
			}
			
			if (touch.getTouch(sliderEmotion, TouchPhase.MOVED))
			{
				if(sliderEmotion.x >= customerLeft && sliderEmotion.x <= customerRight){
					sliderEmotion.x = touch.getTouch(this).getLocation(this).x - sliderEmotion.width * 0.5;
				}
				if(sliderEmotion.x < customerLeft)
				{
					sliderEmotion.x = customerLeft;
				}
				if(sliderEmotion.x > customerRight)
				{
					sliderEmotion.x = customerRight;
				}
				Data.valueEmotion = 10  * (sliderEmotion.x - customerLeft) / (170 - sliderEmotion.width);
			}
			
			
			if (touch.getTouch(buttonRightPopulation, TouchPhase.ENDED))
			{
				if((Data.valuePopulation+20)<=1000){
					Data.valuePopulation+=20;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftPopulation, TouchPhase.ENDED))
			{
				if((Data.valuePopulation-20)>=0){
					Data.valuePopulation-=20;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightWheater, TouchPhase.ENDED))
			{
				if(Data.valueWeather<10){
					Data.valueWeather++;
				}		
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftWheater, TouchPhase.ENDED))
			{
				if(Data.valueWeather>0){
					Data.valueWeather--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightEvent, TouchPhase.ENDED))
			{
				if(Data.valueEvent<10){
					Data.valueEvent++;
				}	
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftEvent, TouchPhase.ENDED))
			{
				if(Data.valueEvent>0){
					Data.valueEvent--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightVariant, TouchPhase.ENDED))
			{
				if(Data.valueVariant<10){
					Data.valueVariant++;
				}	
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftVariant, TouchPhase.ENDED))
			{
				if(Data.valueVariant>0){
					Data.valueVariant--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightAddicted, TouchPhase.ENDED))
			{
				if(Data.valueAddicted<10){
					Data.valueAddicted++;
				}	
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftAddicted, TouchPhase.ENDED))
			{
				if(Data.valueAddicted>0){
					Data.valueAddicted--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightBuying, TouchPhase.ENDED))
			{
				if(Data.valueBuying<10){
					Data.valueBuying++;
				}	
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftBuying, TouchPhase.ENDED))
			{
				if(Data.valueBuying>0){
					Data.valueBuying--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightEmotion, TouchPhase.ENDED))
			{
				if(Data.valueEmotion<10){
					Data.valueEmotion++;
				}	
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftEmotion, TouchPhase.ENDED))
			{
				if(Data.valueEmotion>1){
					Data.valueEmotion--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			
			updateSlider();
		}
		
		public function updateSlider():void
		{
			sliderPopulation.x = distance / 1000 * Data.valuePopulation + worldLeft;
			sliderWheater.x = distance / 10 * Data.valueWeather + worldLeft;
			sliderEvent.x = distance / 10 * Data.valueEvent + worldLeft;
			sliderCompetitor.x = distance / 10 * Data.valueCompetitor + worldLeft;	
			
			sliderVariant.x = distance / 10 * Data.valueVariant + customerLeft;
			sliderAddicted.x = distance / 10 * Data.valueAddicted + customerLeft;
			sliderBuying.x = distance / 10 * Data.valueBuying + customerLeft;
			sliderEmotion.x = distance / 10 * Data.valueEmotion + customerLeft;	
		}
		
		override public function openDialog():void
		{
			visible = true;
		}
		
		override public function closeDialog():void
		{
			server.saveGameData();
			visible = false;
		}
				
	}
}