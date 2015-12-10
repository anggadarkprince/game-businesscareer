package sketchproject.screens
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	import sketchproject.utilities.DayCounter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class IssuesScreen extends GameScreen
	{
		private var headline:Image;
		private var date:TextField;
		private var shopingStreet:TextField;
		private var event:TextField;
		private var locationInfo:TextField;
		
		private var playerShop:TextField;
		private var playerShopInfo:TextField;
		private var competitor1Shop:TextField;
		private var competitor1ShopInfo:TextField;
		private var competitor2Shop:TextField;
		private var competitor2ShopInfo:TextField;
		
		private var todayWeatherForecast:TextField;
		private var todayTemperatureForecast:TextField;
		private var tomorowWeatherForecast:TextField;
		private var tomorowTemperatureForecast:TextField;
		private var datWeatherForecast:TextField;
		private var datTemperatureForecast:TextField;

		private var todayIcon:Image;
		private var tomorowIcon:Image;
		private var datIcon:Image;
		
		private var location:Image;
		private var nextLocation:Button;
		private var prevLocation:Button;
		
		private var logoPlayer:Image;
		private var logoCompetitor1:Image;
		private var logoCompetitor2:Image;
		
		private var characterBackground:Image;

		private var indexLocation:int;
		
		private var agentGenerator:AgentGenerator;
		
		private var predictAgent:Array;
		
		public function IssuesScreen()
		{
			super();
			
			super.hideBase();

			indexLocation = 0;
			
			agentGenerator = new AgentGenerator();
			
			predictAgent = new Array();
			
			headline = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("newspaper"));
			headline.pivotX = headline.width * 0.5;
			headline.pivotY = headline.height * 0.5;	
			addChild(headline);
			
			date = new TextField(150, 50, "Day 1 Year 1", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0xFFFFFF);
			date.x = 310;
			date.y = -260;
			date.hAlign = HAlign.RIGHT;
			addChild(date);
			
			characterBackground = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("advisor_shangrila"));
			characterBackground.x = 320;
			characterBackground.y = -180;
			addChild(characterBackground);
			
			todayTemperatureForecast = new TextField(50, 50, "60", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			todayTemperatureForecast.hAlign = HAlign.LEFT;
			todayTemperatureForecast.x = -455;
			todayTemperatureForecast.y = -120;
			addChild(todayTemperatureForecast);
			
			todayIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("weather_rain"));
			todayIcon.x = -435;
			todayIcon.y = -120;
			addChild(todayIcon);
			
			todayWeatherForecast = new TextField(100, 50, "Sunny", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			todayWeatherForecast.hAlign = HAlign.LEFT;
			todayWeatherForecast.x = -455;
			todayWeatherForecast.y = -100;
			addChild(todayWeatherForecast);
			
			tomorowTemperatureForecast = new TextField(50, 50, "60", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			tomorowTemperatureForecast.hAlign = HAlign.LEFT;
			tomorowTemperatureForecast.x = -375;
			tomorowTemperatureForecast.y = -120;
			addChild(tomorowTemperatureForecast);
			
			tomorowIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("weather_sunny"));
			tomorowIcon.x = -355;
			tomorowIcon.y = -120;
			addChild(tomorowIcon);
			
			tomorowWeatherForecast = new TextField(100, 50, "Clammy", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			tomorowWeatherForecast.hAlign = HAlign.LEFT;
			tomorowWeatherForecast.x = -375;
			tomorowWeatherForecast.y = -100;
			addChild(tomorowWeatherForecast);
			
			datTemperatureForecast = new TextField(50, 50, "60", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			datTemperatureForecast.hAlign = HAlign.LEFT;
			datTemperatureForecast.x = -275;
			datTemperatureForecast.y = -120;
			addChild(datTemperatureForecast);
			
			datIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("weather_sunny"));
			datIcon.x = -255;
			datIcon.y = -120;
			addChild(datIcon);
			
			datWeatherForecast = new TextField(100, 50, "Overcast", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			datWeatherForecast.hAlign = HAlign.LEFT;
			datWeatherForecast.x = -275;
			datWeatherForecast.y = -100;
			addChild(datWeatherForecast);
			
			
			shopingStreet = new TextField(500, 70, "Vinichles are not permitted on Main Street in the Shopping Distric todah, as we create an outdor mail from 10am to 5px. Music and entertainment will be provided at not change. have a great day!", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			shopingStreet.hAlign = HAlign.LEFT;
			shopingStreet.vAlign = VAlign.TOP;
			shopingStreet.x = -160;
			shopingStreet.y = -150;
			addChild(shopingStreet);
			
			event = new TextField(450, 70, "1. Soccer Tournament in Sport Center Today Morning Phase\n2. Badminton Tournament in Sport Center at 14.00 - 16.00", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			event.hAlign = HAlign.LEFT;
			event.vAlign = VAlign.TOP;
			event.x = -160;
			event.y = -54;
			addChild(event);
						
			locationInfo = new TextField(300, 70, "Vinichles are not permitted on Main Street in the Shopping Distric todah, as we create an outdor mail from 10am to 5pm. Music and entertainment will be provided at not change. have a great day!", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			locationInfo.hAlign = HAlign.LEFT;
			locationInfo.vAlign = VAlign.TOP;
			locationInfo.x = 40;
			locationInfo.y = 50;
			addChild(locationInfo);
			
			location = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("location_airport"));
			location.x = -145;
			location.y = 50;
			addChild(location);
			
			prevLocation = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			prevLocation.pivotX = prevLocation.width * 0.5;
			prevLocation.pivotY = prevLocation.height * 0.5;
			prevLocation.x = -145;
			prevLocation.y = 85;
			prevLocation.scaleX = -1;
			addChild(prevLocation);
			
			nextLocation = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			nextLocation.pivotX = prevLocation.width * 0.5;
			nextLocation.pivotY = prevLocation.height * 0.5;
			nextLocation.x = 15;
			nextLocation.y = 85;
			addChild(nextLocation);
			
			playerShop = new TextField(200, 70, Data.shop, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			playerShop.hAlign = HAlign.LEFT;
			playerShop.vAlign = VAlign.TOP;
			playerShop.x = -395;
			playerShop.y = -5;
			addChild(playerShop);
			
			playerShopInfo = new TextField(200, 70, "Price AVG IDR 3 K - Quality AVG Good", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 11, 0x333333);
			playerShopInfo.hAlign = HAlign.LEFT;
			playerShopInfo.vAlign = VAlign.TOP;
			playerShopInfo.x = -395;
			playerShopInfo.y = 10;
			addChild(playerShopInfo);
			
			competitor1Shop = new TextField(200, 70, "Competitor A", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			competitor1Shop.hAlign = HAlign.LEFT;
			competitor1Shop.vAlign = VAlign.TOP;
			competitor1Shop.x = -395;
			competitor1Shop.y = 40;
			addChild(competitor1Shop);
			
			competitor1ShopInfo = new TextField(200, 70, "Price AVG IDR 3 K - Quality AVG Good", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 11, 0x333333);
			competitor1ShopInfo.hAlign = HAlign.LEFT;
			competitor1ShopInfo.vAlign = VAlign.TOP;
			competitor1ShopInfo.x = -395;
			competitor1ShopInfo.y = 55;
			addChild(competitor1ShopInfo);
			
			competitor2Shop = new TextField(200, 70, "Competitor B", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			competitor2Shop.hAlign = HAlign.LEFT;
			competitor2Shop.vAlign = VAlign.TOP;
			competitor2Shop.x = -395;
			competitor2Shop.y = 85;
			addChild(competitor2Shop);
			
			competitor2ShopInfo = new TextField(200, 70, "Price AVG IDR 3 K - Quality AVG Good", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 11, 0x333333);
			competitor2ShopInfo.hAlign = HAlign.LEFT;
			competitor2ShopInfo.vAlign = VAlign.TOP;
			competitor2ShopInfo.x = -395;
			competitor2ShopInfo.y = 100;
			addChild(competitor2ShopInfo);
			
			logoPlayer = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.logo));
			logoPlayer.x = -450;
			logoPlayer.y = -5;
			logoPlayer.scaleX = 0.75;
			logoPlayer.scaleY = 0.75;
			addChild(logoPlayer);
			
			logoCompetitor1 = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.logo));
			logoCompetitor1.x = -450;
			logoCompetitor1.y = 40;
			logoCompetitor1.scaleX = 0.75;
			logoCompetitor1.scaleY = 0.75;
			addChild(logoCompetitor1);
			
			logoCompetitor2 = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.logo));
			logoCompetitor2.x = -450;
			logoCompetitor2.y = 85;
			logoCompetitor2.scaleX = 0.75;
			logoCompetitor2.scaleY = 0.75;
			addChild(logoCompetitor2);
			
			prevLocation.addEventListener(Event.TRIGGERED, onPreviousLocation);
			nextLocation.addEventListener(Event.TRIGGERED, onNextLocation);
			
			var logo1:String = "";
			var logo2:String = "";
			do{
				logo1 = "logo"+Math.ceil(Math.random()*4);
				logo2 = "logo"+Math.ceil(Math.random()*4);
			}
			while(logo1 == Data.logo || logo2 == Data.logo || logo1 == logo2);	
			
			logoCompetitor1.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(logo1);
			logoCompetitor2.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(logo2);
			
			updateNewsIssues();
		}
		
		private function onNextLocation(event:Event):void
		{		
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			if(indexLocation < Config.district.length-1){
				indexLocation++;
			}		
			else{
				indexLocation = 0;
			}
			updateDistrictInfo();			
		}
		
		private function onPreviousLocation(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			if(indexLocation > 0){
				indexLocation--;
			}
			else{
				indexLocation = Config.district.length-1;
			}
			updateDistrictInfo();
		}
		
		public function updateDistrictInfo():void
		{
			locationInfo.text = Config.district[indexLocation][3];
			location.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Config.district[indexLocation][2]);
		}
		
		public function updateNewsIssues():void{
			
			date.text = "Day "+DayCounter.dayCounting()+", Year "+DayCounter.yearCounting();
			
			todayTemperatureForecast.text = Data.weather[0][1];
			todayWeatherForecast.text = Data.weather[0][2];
			todayIcon.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.weather[0][3]);
			
			tomorowTemperatureForecast.text = Data.weather[1][1];
			tomorowWeatherForecast.text = Data.weather[1][2];
			tomorowIcon.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.weather[1][3]);
			
			datTemperatureForecast.text = Data.weather[2][1];
			datWeatherForecast.text = Data.weather[2][2];
			datIcon.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.weather[2][3]);
			
			if(Data.event.length > 0)
			{
				event.text = "";
				for(var i:int = 0; i<Data.event.length; i++){
					event.text += (i+1)+". Event "+Data.event[i][1]+", start at "+Data.event[i][2]+" - "+Data.event[i][3]+",'Education : "+int(Data.event[i][6][0])+"', 'Art : "+int(Data.event[i][6][1])+"','Athletic : "+int(Data.event[i][6][2])+"'\n";
				}
			}
			else
			{
				event.text = "No Event Today";
			}
			
			updateDistrictInfo();
			
			agentGenerator.generatePopulation(predictAgent, Data.valuePopulation);
			agentGenerator.generateSocialVariant(predictAgent, Data.valueVariant);
			var agent:Agent;
			
			var education:int = 0;
			var art:int = 0;
			var athletic:int = 0;
			
			var decoration:int = 0;
			var scent:int = 0;
			var cleaness:int = 0;
			
			for(i=0;i<predictAgent.length;i++){
				agent = predictAgent[i] as Agent;
				
				education += agent.education;
				art += agent.art;
				athletic += agent.athletic;
				
				decoration += int(agent.decorationMatch.modern);
				decoration += int(agent.decorationMatch.colorfull);
				decoration += int(agent.decorationMatch.vintage);
				
				cleaness += int(agent.cleanessMatch.product);
				cleaness += int(agent.cleanessMatch.place);
				
				scent += int(agent.scentMatch.ginger);
				scent += int(agent.scentMatch.jasmine);
				scent += int(agent.scentMatch.rosemary);
					
			}
			
			education = education/predictAgent.length;
			art = art/predictAgent.length;
			athletic = athletic/predictAgent.length;
			
			decoration = decoration/3/predictAgent.length;
			cleaness = cleaness/2/predictAgent.length;
			scent = scent/3/predictAgent.length;
			
			shopingStreet.text = "Trend ketertarikan event dengan rata - rata kemiripan \nEducation : "+education+"  Art : "+art+"  Athletic : "+athletic+",";
			shopingStreet.text = shopingStreet.text+" dan trend ketertarikan toko rata - rata kemiripan\nDecoration : "+decoration+"  Cleaness : "+cleaness+",  Scent : "+scent+"";
		}
		
	}
}