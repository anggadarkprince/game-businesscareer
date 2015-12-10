package sketchproject.objects.advertising
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	import sketchproject.objects.adapter.AdvertisementAdapter;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class AdvertisementFrame extends Sprite
	{
		private var label:TextField;
		private var cost:TextField;
		private var adverList:Sprite;
		private var map:Image;
		private var adverPredict:Quad;
		private var advertisement:Array;
		private var totalCost:int;
		
		private var tvRate:TextField;
		private var radioRate:TextField;
		private var newspaperRate:TextField;
		private var internetRate:TextField;
		private var eventRate:TextField;
		private var billboardRate:TextField;
		
		private var agentGenerator:AgentGenerator;
		
		private var predictAgent:Array;
		
		public function AdvertisementFrame()
		{
			super();
			
			agentGenerator = new AgentGenerator();
			
			predictAgent = new Array();
			
			label = new TextField(250, 50, "Effectiveness", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -190;
			addChild(label);
			
			label = new TextField(300, 50, "Average Advertising effectiveness on map", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -170;
			addChild(label);
			
			map = new Image(Assets.getTexture("GameWorld"));
			map.width = 270;
			map.height = 150;
			map.x = -400;
			map.y = -125;
			addChild(map);
			
			adverPredict = new Quad(10,10,0xa8e933);
			adverPredict.x = -400;
			adverPredict.y = 38;
			addChild(adverPredict);
			
			tvRate = new TextField(300, 50, "Television", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			tvRate.vAlign = VAlign.TOP;
			tvRate.hAlign = HAlign.LEFT;
			tvRate.x = -380;
			tvRate.y = 35;
			addChild(tvRate);
			
			adverPredict = new Quad(10,10,0xf3bb33);
			adverPredict.x = -400;
			adverPredict.y = 53;
			addChild(adverPredict);
			
			radioRate = new TextField(300, 50, "Radio", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			radioRate.vAlign = VAlign.TOP;
			radioRate.hAlign = HAlign.LEFT;
			radioRate.x = -380;
			radioRate.y = 50;
			addChild(radioRate);
			
			adverPredict = new Quad(10,10,0xd93b9c);
			adverPredict.x = -400;
			adverPredict.y = 68;
			addChild(adverPredict);
			
			newspaperRate = new TextField(300, 50, "Newspaper", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			newspaperRate.vAlign = VAlign.TOP;
			newspaperRate.hAlign = HAlign.LEFT;
			newspaperRate.x = -380;
			newspaperRate.y = 65;
			addChild(newspaperRate);
			
			adverPredict = new Quad(10,10,0x5eb9f9);
			adverPredict.x = -250;
			adverPredict.y = 38;
			addChild(adverPredict);
			
			internetRate = new TextField(300, 50, "Internet", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			internetRate.vAlign = VAlign.TOP;
			internetRate.hAlign = HAlign.LEFT;
			internetRate.x = -230;
			internetRate.y = 35;
			addChild(internetRate);
			
			adverPredict = new Quad(10,10,0xf95e5e);
			adverPredict.x = -250;
			adverPredict.y = 53;
			addChild(adverPredict);
			
			eventRate = new TextField(300, 50, "Event", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			eventRate.vAlign = VAlign.TOP;
			eventRate.hAlign = HAlign.LEFT;
			eventRate.x = -230;
			eventRate.y = 50;
			addChild(eventRate);
			
			adverPredict = new Quad(10,10,0x8a8a8a);
			adverPredict.x = -250;
			adverPredict.y = 68;
			addChild(adverPredict);
			
			billboardRate = new TextField(300, 50, "Billboard", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			billboardRate.vAlign = VAlign.TOP;
			billboardRate.hAlign = HAlign.LEFT;
			billboardRate.x = -230;
			billboardRate.y = 65;
			addChild(billboardRate);
			
			
			cost = new TextField(320, 50, "Total cost per day IDR 5000 K", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			cost.vAlign = VAlign.TOP;
			cost.hAlign = HAlign.LEFT;
			cost.x = -400;
			cost.y = 95;
			addChild(cost);
			
			label = new TextField(250, 50, "Advertising", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -190;
			addChild(label);
			
			label = new TextField(250, 50, "Please choose advertising detail", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -170;
			addChild(label);
			
			adverList = new Sprite();
			adverList.x = -100;
			adverList.y = -150;
			addChild(adverList);
			
			label = new TextField(400, 50, "Adver effectiveness depends on customer characteristic", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = 95;
			addChild(label);
			
			updateAdvertisement();			
		}
		
		public function updateAdvertisement():void
		{
			adverList.removeChildren();
			advertisement = new Array();
			Data.advertisingCost = new Array();
			
			for(var i:int = 0; i<Config.advertisement.length; i++){
				var adver:AdvertisementAdapter = new AdvertisementAdapter(Config.advertisement[i][0], Config.advertisement[i][1], Config.advertisement[i][2]);
				adver.x = (i%2) * 250;
				adver.y = Math.floor(i/2) * 82;
				adver.addEventListener(AdvertisementAdapter.ADVERTISEMENT_CHANGED, onAdvertisementChanged);
				adverList.addChild(adver);
				advertisement.push(adver);
				
				Data.advertisingCost.push(new Array(Config.advertisement[i][0], adver.getCost()));
			}
			updateAdvertisingCost();
		}
		
		public function updateAdverPrediction():void
		{
			agentGenerator.generatePopulation(predictAgent, Data.valuePopulation);
			agentGenerator.generateSocialVariant(predictAgent, Data.valueVariant);
			
			var agent:Agent;
			
			var tv:Number = 0;
			var radio:Number = 0;
			var newspaper:Number = 0;
			
			var internet:Number = 0;
			var event:Number = 0;
			var billboard:Number = 0;
			
			for(var i:int=0;i<predictAgent.length;i++){
				agent = predictAgent[i] as Agent;
				
				tv += Number(agent.adverContactRate.tv);
				radio += Number(agent.adverContactRate.radio);
				newspaper += Number(agent.adverContactRate.newspaper);
				internet += Number(agent.adverContactRate.internet);
				event += Number(agent.adverContactRate.event);
				billboard += Number(agent.adverContactRate.billboard);
			}
			tv = (tv/predictAgent.length)/10 * 100;
			radio = (radio/predictAgent.length)/10 * 100;
			newspaper = (newspaper/predictAgent.length)/10 * 100;
			internet = (internet/predictAgent.length)/10 * 100;
			event = (event/predictAgent.length)/10 * 100;
			billboard = (billboard/predictAgent.length)/10 * 100;
			
			tvRate.text = "Television "+tv.toFixed(2)+" %";
			radioRate.text = "Radio "+radio.toFixed(2)+" %";
			newspaperRate.text = "Newspaper "+newspaper.toFixed(2)+" %";
			internetRate.text = "Internet "+internet.toFixed(2)+" %";
			eventRate.text = "Event "+event.toFixed(2)+" %";
			billboardRate.text = "Billboard "+billboard.toFixed(2)+" %";
		}
		
		private function onAdvertisementChanged(event:Event):void
		{
			updateAdvertisingCost();
			for(var i:uint = 0; i<advertisement.length;i++)
			{
				if(Data.advertisingCost[i][0] == AdvertisementAdapter(event.currentTarget).id){
					Data.advertisingCost[i][1] = AdvertisementAdapter(event.currentTarget).getCost();
				}				
			}
			
		}
		
		private function updateAdvertisingCost():void
		{
			totalCost = 0;
			for(var i:uint = 0; i<advertisement.length;i++)
			{				
				totalCost += AdvertisementAdapter(advertisement[i]).getCost();
			}
			cost.text = "Total cost per day IDR "+ValueFormatter.format(totalCost);	
			
		}
		
	}
}