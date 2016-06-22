package sketchproject.objects.advertising
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.managers.DataManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	import sketchproject.objects.adapter.AdvertisementAdapter;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Manage promotion and advertisement.
	 *
	 * @author Angga
	 */
	public class AdvertisementFrame extends Sprite
	{
		private var label:TextField;
		private var cost:TextField;
		private var advertisementContainer:Sprite;
		private var areaContainer:Sprite;
		private var map:Image;
		private var adverPredict:Quad;
		private var advertisements:Array;
		private var totalCost:int;

		private var tvRate:TextField;
		private var radioRate:TextField;
		private var newspaperRate:TextField;
		private var internetRate:TextField;
		private var eventRate:TextField;
		private var billboardRate:TextField;

		private var agentGenerator:AgentGenerator;
		private var save:DataManager;

		private var predictAgent:Array;

		/**
		 * Default constructor of AdvertismentFrame.
		 */
		public function AdvertisementFrame()
		{
			super();

			agentGenerator = new AgentGenerator();
			save = new DataManager();

			predictAgent = new Array();

			label = new TextField(250, 50, "Effectiveness", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -195;
			addChild(label);

			label = new TextField(300, 50, "Efektivitas rata - rata iklan", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
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

			adverPredict = new Quad(10, 10, 0xa8e933);
			adverPredict.x = -400;
			adverPredict.y = 38;
			addChild(adverPredict);

			tvRate = new TextField(300, 50, "Television", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			tvRate.vAlign = VAlign.TOP;
			tvRate.hAlign = HAlign.LEFT;
			tvRate.x = -380;
			tvRate.y = 35;
			addChild(tvRate);

			adverPredict = new Quad(10, 10, 0xf3bb33);
			adverPredict.x = -400;
			adverPredict.y = 53;
			addChild(adverPredict);

			radioRate = new TextField(300, 50, "Radio", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			radioRate.vAlign = VAlign.TOP;
			radioRate.hAlign = HAlign.LEFT;
			radioRate.x = -380;
			radioRate.y = 50;
			addChild(radioRate);

			adverPredict = new Quad(10, 10, 0xd93b9c);
			adverPredict.x = -400;
			adverPredict.y = 68;
			addChild(adverPredict);

			newspaperRate = new TextField(300, 50, "Newspaper", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			newspaperRate.vAlign = VAlign.TOP;
			newspaperRate.hAlign = HAlign.LEFT;
			newspaperRate.x = -380;
			newspaperRate.y = 65;
			addChild(newspaperRate);

			adverPredict = new Quad(10, 10, 0x5eb9f9);
			adverPredict.x = -250;
			adverPredict.y = 38;
			addChild(adverPredict);

			internetRate = new TextField(300, 50, "Internet", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			internetRate.vAlign = VAlign.TOP;
			internetRate.hAlign = HAlign.LEFT;
			internetRate.x = -230;
			internetRate.y = 35;
			addChild(internetRate);

			adverPredict = new Quad(10, 10, 0xf95e5e);
			adverPredict.x = -250;
			adverPredict.y = 53;
			addChild(adverPredict);

			eventRate = new TextField(300, 50, "Event", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			eventRate.vAlign = VAlign.TOP;
			eventRate.hAlign = HAlign.LEFT;
			eventRate.x = -230;
			eventRate.y = 50;
			addChild(eventRate);

			adverPredict = new Quad(10, 10, 0x8a8a8a);
			adverPredict.x = -250;
			adverPredict.y = 68;
			addChild(adverPredict);

			billboardRate = new TextField(300, 50, "Billboard", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			billboardRate.vAlign = VAlign.TOP;
			billboardRate.hAlign = HAlign.LEFT;
			billboardRate.x = -230;
			billboardRate.y = 65;
			addChild(billboardRate);


			cost = new TextField(320, 50, "Total cost per hari : IDR 5000 K", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			cost.vAlign = VAlign.TOP;
			cost.hAlign = HAlign.LEFT;
			cost.x = -400;
			cost.y = 95;
			addChild(cost);

			label = new TextField(250, 50, "Advertising", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -195;
			addChild(label);

			label = new TextField(250, 50, "Atur jenis promosi dan iklan", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -170;
			addChild(label);

			advertisementContainer = new Sprite();
			advertisementContainer.x = -100;
			advertisementContainer.y = -150;
			addChild(advertisementContainer);

			areaContainer = new Sprite();
			addChild(areaContainer);

			label = new TextField(550, 50, "Efektivitas iklan bergantung nilai konsumsi jenis media promosi oleh konsumen", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = 95;
			addChild(label);

			updateAdvertisement();
			updateAdverPrediction();
		}

		/**
		 * Create list of advertisement by adapter.
		 */
		public function updateAdvertisement():void
		{
			advertisementContainer.removeChildren();
			advertisements = new Array();
			Data.advertisingCost = new Array();

			for (var i:int = 0; i < Config.advertisement.length; i++)
			{
				var advertisement:AdvertisementAdapter = new AdvertisementAdapter(Config.advertisement[i][0], Config.advertisement[i][1], Config.advertisement[i][2]);
				advertisement.x = (i % 2) * 250;
				advertisement.y = Math.floor(i / 2) * 82;
				advertisement.addEventListener(AdvertisementAdapter.ADVERTISEMENT_CHANGED, onAdvertisementChanged);
				advertisementContainer.addChild(advertisement);
				advertisements.push(advertisement);

				Data.advertisingCost.push(new Array(Config.advertisement[i][0], advertisement.getCost()));
			}
			updateAdvertisingCost();
		}

		/**
		 * Update total cost each advertisement, save to posting journal later.
		 *
		 * @param event
		 */
		private function onAdvertisementChanged(event:Event):void
		{
			updateAdvertisingCost();
			for (var i:uint = 0; i < advertisements.length; i++)
			{
				if (Data.advertisingCost[i][0] == AdvertisementAdapter(event.currentTarget).id)
				{
					Data.advertisingCost[i][1] = AdvertisementAdapter(event.currentTarget).getCost();
				}
			}
		}

		/**
		 * Update advertisement cost total and show at the label.
		 */
		private function updateAdvertisingCost():void
		{
			totalCost = 0;
			for (var i:uint = 0; i < advertisements.length; i++)
			{
				totalCost += AdvertisementAdapter(advertisements[i]).getCost();
			}
			cost.text = "Total cost per day IDR " + ValueFormatter.format(totalCost);
			save.saveGameData();
		}

		/**
		 * Update advertisement prediction and effectiveness.
		 */
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

			for (var i:int = 0; i < predictAgent.length; i++)
			{
				agent = predictAgent[i] as Agent;

				tv += Number(agent.adverContactRate.tv);
				radio += Number(agent.adverContactRate.radio);
				newspaper += Number(agent.adverContactRate.newspaper);
				internet += Number(agent.adverContactRate.internet);
				event += Number(agent.adverContactRate.event);
				billboard += Number(agent.adverContactRate.billboard);
			}
			tv = (tv / predictAgent.length) / 10 * 100;
			radio = (radio / predictAgent.length) / 10 * 100;
			newspaper = (newspaper / predictAgent.length) / 10 * 100;
			internet = (internet / predictAgent.length) / 10 * 100;
			event = (event / predictAgent.length) / 10 * 100;
			billboard = (billboard / predictAgent.length) / 10 * 100;

			tvRate.text = "Television " + tv.toFixed(2) + " %";
			radioRate.text = "Radio " + radio.toFixed(2) + " %";
			newspaperRate.text = "Newspaper " + newspaper.toFixed(2) + " %";
			internetRate.text = "Internet " + internet.toFixed(2) + " %";
			eventRate.text = "Event " + event.toFixed(2) + " %";
			billboardRate.text = "Billboard " + billboard.toFixed(2) + " %";

			areaContainer.removeChildren();

			var s:Shape = new Shape();

			s.graphics.beginFill(0xa8e933, 0.6);
			s.graphics.drawCircle(-350, -100, tv / 1.5);
			s.graphics.endFill();

			s.graphics.beginFill(0xf3bb33, 0.6);
			s.graphics.drawCircle(-300, -70, radio / 1.5);
			s.graphics.endFill();

			s.graphics.beginFill(0xd93b9c, 0.6);
			s.graphics.drawCircle(-370, -20, newspaper / 1.5);
			s.graphics.endFill();

			s.graphics.beginFill(0x5eb9f9, 0.6);
			s.graphics.drawCircle(-180, -90, internet / 1.5);
			s.graphics.endFill();

			s.graphics.beginFill(0xf95e5e, 0.6);
			s.graphics.drawCircle(-230, -50, event / 1.5);
			s.graphics.endFill();

			s.graphics.beginFill(0x8a8a8a, 0.6);
			s.graphics.drawCircle(-190, -10, billboard / 1.5);
			s.graphics.endFill();

			areaContainer.addChild(s);
		}
	}
}
