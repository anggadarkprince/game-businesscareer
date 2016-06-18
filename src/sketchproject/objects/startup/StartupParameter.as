package sketchproject.objects.startup
{
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.objects.Tooltips;
	import sketchproject.core.Data;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Setup initial game and consumer parameter.
	 * 
	 * @author Angga
	 */
	public class StartupParameter extends Sprite
	{
		private var labelGameWorld:Image;
		private var labelCustomer:Image;

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
		private var sliderWeather:Image;
		private var sliderEvent:Image;
		private var sliderCompetitor:Image;

		private var sliderVariant:Image;
		private var sliderAddicted:Image;
		private var sliderBuying:Image;
		private var sliderEmotion:Image;

		private var textLabelParameter:Array;

		private var worldLeft:uint;
		private var worldRight:uint;

		private var customerLeft:uint;
		private var customerRight:uint;

		private var distance:uint;

		private var showTips:Tooltips;

		/**
		 * Default constructor of StartupParameter
		 */
		public function StartupParameter()
		{
			super();

			textLabelParameter = ["Population", "Social Variant", "Wheater Chaos", "Addicted Level", "Event Traffict", "Buying Power", "Competitor", "Emotion Chaos"];

			showTips = new Tooltips();
			showTips.tipsDirection(Tooltips.TIPS_LEFT);
			Game.overlayStage.addChild(showTips);

			labelGameWorld = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_gameworld_parameter"));
			labelGameWorld.x = 20;
			labelGameWorld.y = -10;
			addChild(labelGameWorld);

			labelCustomer = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_customer_parameter"));
			labelCustomer.x = 500;
			labelCustomer.y = -10;
			addChild(labelCustomer);

			for (var i:uint = 0; i < 8; i++)
			{
				var gearLabel:Image = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dark_gear"));
				gearLabel.x = 460 * (i % 2) + 20;
				gearLabel.y = 70 * int(i / 2) + 100;
				addChild(gearLabel);

				var labelParameter:TextField = new TextField(150, 20, textLabelParameter[i], Assets.getFont("FontErasITC").fontName, 18, 0x333333);
				labelParameter.x = 460 * (i % 2) + 45;
				labelParameter.y = 70 * int(i / 2) + 100;
				labelParameter.hAlign = HAlign.LEFT;
				addChild(labelParameter);

				var backgroundSet:Quad = new Quad(170, 25, 0xDDDDDD);
				backgroundSet.x = 460 * (i % 2) + 230;
				backgroundSet.y = 70 * int(i / 2) + 100;
				addChild(backgroundSet);
			}

			/** world **/
			buttonRightPopulation = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightPopulation.x = 400;
			buttonRightPopulation.y = 100 - 3;
			addChild(buttonRightPopulation);

			buttonLeftPopulation = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftPopulation.x = 230;
			buttonLeftPopulation.y = 100 - 3;
			buttonLeftPopulation.scaleX = -1;
			addChild(buttonLeftPopulation);

			sliderPopulation = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderPopulation.x = 300;
			sliderPopulation.y = 100;
			addChild(sliderPopulation);


			buttonRightWheater = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightWheater.x = 400;
			buttonRightWheater.y = 170 - 3;
			addChild(buttonRightWheater);

			buttonLeftWheater = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftWheater.x = 230;
			buttonLeftWheater.y = 170 - 3;
			buttonLeftWheater.scaleX = -1;
			addChild(buttonLeftWheater);

			sliderWeather = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderWeather.x = 300;
			sliderWeather.y = 170;
			addChild(sliderWeather);


			buttonRightEvent = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightEvent.x = 400;
			buttonRightEvent.y = 240 - 3;
			addChild(buttonRightEvent);

			buttonLeftEvent = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftEvent.x = 230;
			buttonLeftEvent.y = 240 - 3;
			buttonLeftEvent.scaleX = -1;
			addChild(buttonLeftEvent);

			sliderEvent = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderEvent.x = 300;
			sliderEvent.y = 240;
			addChild(sliderEvent);


			buttonRightCompetitor = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightCompetitor.x = 400;
			buttonRightCompetitor.y = 310 - 3;
			addChild(buttonRightCompetitor);

			buttonLeftCompetitor = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftCompetitor.x = 230;
			buttonLeftCompetitor.y = 310 - 3;
			buttonLeftCompetitor.scaleX = -1;
			addChild(buttonLeftCompetitor);

			sliderCompetitor = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderCompetitor.x = 300;
			sliderCompetitor.y = 310;
			addChild(sliderCompetitor);

			/** customer **/
			buttonRightVariant = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightVariant.x = 860;
			buttonRightVariant.y = 100 - 3;
			addChild(buttonRightVariant);

			buttonLeftVariant = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftVariant.x = 690;
			buttonLeftVariant.y = 100 - 3;
			buttonLeftVariant.scaleX = -1;
			addChild(buttonLeftVariant);

			sliderVariant = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderVariant.x = 700;
			sliderVariant.y = 100;
			addChild(sliderVariant);


			buttonRightAddicted = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightAddicted.x = 860;
			buttonRightAddicted.y = 170 - 3;
			addChild(buttonRightAddicted);

			buttonLeftAddicted = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftAddicted.x = 690;
			buttonLeftAddicted.y = 170 - 3;
			buttonLeftAddicted.scaleX = -1;
			addChild(buttonLeftAddicted);

			sliderAddicted = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderAddicted.x = 700;
			sliderAddicted.y = 170;
			addChild(sliderAddicted);


			buttonRightBuying = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightBuying.x = 860;
			buttonRightBuying.y = 240 - 3;
			addChild(buttonRightBuying);

			buttonLeftBuying = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftBuying.x = 690;
			buttonLeftBuying.y = 240 - 3;
			buttonLeftBuying.scaleX = -1;
			addChild(buttonLeftBuying);

			sliderBuying = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderBuying.x = 700;
			sliderBuying.y = 240;
			addChild(sliderBuying);


			buttonRightEmotion = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightEmotion.x = 860;
			buttonRightEmotion.y = 310 - 3;
			addChild(buttonRightEmotion);

			buttonLeftEmotion = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftEmotion.x = 690;
			buttonLeftEmotion.y = 310 - 3;
			buttonLeftEmotion.scaleX = -1;
			addChild(buttonLeftEmotion);

			sliderEmotion = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("slider_bar"));
			sliderEmotion.x = 700;
			sliderEmotion.y = 310;
			addChild(sliderEmotion);

			addEventListener(TouchEvent.TOUCH, onSliderTouched);

			worldLeft = 230;
			worldRight = 230 + 170 - sliderPopulation.width;
			customerLeft = 690;
			customerRight = 690 + 170 - sliderPopulation.width;
			distance = worldRight - worldLeft;

			updateSlider();
		}

		/**
		 * Event handler when player touch the sprite.
		 * 
		 * @param touch
		 */
		private function onSliderTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(sliderPopulation, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_LEFT);
				showTips.info = "Number of population in game world";
			}
			else if (touch.getTouch(sliderWeather, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_LEFT);
				showTips.info = "How weather affecting population";
			}
			else if (touch.getTouch(sliderEvent, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_LEFT);
				showTips.info = "How many event will be generated";
			}
			else if (touch.getTouch(sliderCompetitor, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_LEFT);
				showTips.info = "How similar competitive market";
			}
			else if (touch.getTouch(sliderVariant, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_RIGHT);
				showTips.info = "Customer personality variant";
			}
			else if (touch.getTouch(sliderAddicted, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_RIGHT);
				showTips.info = "Customer addicted by product";
			}
			else if (touch.getTouch(sliderBuying, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_RIGHT);
				showTips.info = "Customer product buying power";
			}
			else if (touch.getTouch(sliderEmotion, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.tipsDirection(Tooltips.TIPS_RIGHT);
				showTips.info = "Chance of emotion reaction";
			}
			else
			{
				showTips.hideTips();
			}

			if (touch.getTouch(sliderPopulation, TouchPhase.MOVED))
			{
				if (sliderPopulation.x >= worldLeft && sliderPopulation.x <= worldRight)
				{
					sliderPopulation.x = touch.getTouch(this).getLocation(this).x - sliderPopulation.width * 0.5;
				}
				if (sliderPopulation.x < worldLeft)
				{
					sliderPopulation.x = worldLeft;
				}
				if (sliderPopulation.x > worldRight)
				{
					sliderPopulation.x = worldRight;
				}
				Data.valuePopulation = 500 * (sliderPopulation.x - worldLeft) / (170 - sliderPopulation.width);
				Data.valuePopulation -= int(Data.valuePopulation % 20);
			}

			if (touch.getTouch(sliderWeather, TouchPhase.MOVED))
			{
				if (sliderWeather.x >= worldLeft && sliderWeather.x <= worldRight)
				{
					sliderWeather.x = touch.getTouch(this).getLocation(this).x - sliderWeather.width * 0.5;
				}
				if (sliderWeather.x < worldLeft)
				{
					sliderWeather.x = worldLeft;
				}
				if (sliderWeather.x > worldRight)
				{
					sliderWeather.x = worldRight;
				}
				Data.valueWeather = 10 * (sliderWeather.x - worldLeft) / (170 - sliderWeather.width);
			}

			if (touch.getTouch(sliderEvent, TouchPhase.MOVED))
			{
				if (sliderEvent.x >= worldLeft && sliderEvent.x <= worldRight)
				{
					sliderEvent.x = touch.getTouch(this).getLocation(this).x - sliderEvent.width * 0.5;
				}
				if (sliderEvent.x < worldLeft)
				{
					sliderEvent.x = worldLeft;
				}
				if (sliderEvent.x > worldRight)
				{
					sliderEvent.x = worldRight;
				}
				Data.valueEvent = 10 * (sliderEvent.x - worldLeft) / (170 - sliderEvent.width);
			}

			if (touch.getTouch(sliderCompetitor, TouchPhase.MOVED))
			{
				if (sliderCompetitor.x >= worldLeft && sliderCompetitor.x <= worldRight)
				{
					sliderCompetitor.x = touch.getTouch(this).getLocation(this).x - sliderCompetitor.width * 0.5;
				}
				if (sliderCompetitor.x < worldLeft)
				{
					sliderCompetitor.x = worldLeft;
				}
				if (sliderCompetitor.x > worldRight)
				{
					sliderCompetitor.x = worldRight;
				}
				Data.valueCompetitor = 10 * (sliderCompetitor.x - worldLeft) / (170 - sliderCompetitor.width);
			}

			if (touch.getTouch(sliderVariant, TouchPhase.MOVED))
			{
				if (sliderVariant.x >= customerLeft && sliderVariant.x <= customerRight)
				{
					sliderVariant.x = touch.getTouch(this).getLocation(this).x - sliderVariant.width * 0.5;
				}
				if (sliderVariant.x < customerLeft)
				{
					sliderVariant.x = customerLeft;
				}
				if (sliderVariant.x > customerRight)
				{
					sliderVariant.x = customerRight;
				}
				Data.valueVariant = 10 * (sliderVariant.x - customerLeft) / (170 - sliderVariant.width);
			}

			if (touch.getTouch(sliderAddicted, TouchPhase.MOVED))
			{
				if (sliderAddicted.x >= customerLeft && sliderAddicted.x <= customerRight)
				{
					sliderAddicted.x = touch.getTouch(this).getLocation(this).x - sliderAddicted.width * 0.5;
				}
				if (sliderAddicted.x < customerLeft)
				{
					sliderAddicted.x = customerLeft;
				}
				if (sliderAddicted.x > customerRight)
				{
					sliderAddicted.x = customerRight;
				}
				Data.valueAddicted = 10 * (sliderAddicted.x - customerLeft) / (170 - sliderAddicted.width);
			}

			if (touch.getTouch(sliderBuying, TouchPhase.MOVED))
			{
				if (sliderBuying.x >= customerLeft && sliderBuying.x <= customerRight)
				{
					sliderBuying.x = touch.getTouch(this).getLocation(this).x - sliderBuying.width * 0.5;
				}
				if (sliderBuying.x < customerLeft)
				{
					sliderBuying.x = customerLeft;
				}
				if (sliderBuying.x > customerRight)
				{
					sliderBuying.x = customerRight;
				}
				Data.valueBuying = 10 * (sliderBuying.x - customerLeft) / (170 - sliderBuying.width);
			}

			if (touch.getTouch(sliderEmotion, TouchPhase.MOVED))
			{
				if (sliderEmotion.x >= customerLeft && sliderEmotion.x <= customerRight)
				{
					sliderEmotion.x = touch.getTouch(this).getLocation(this).x - sliderEmotion.width * 0.5;
				}
				if (sliderEmotion.x < customerLeft)
				{
					sliderEmotion.x = customerLeft;
				}
				if (sliderEmotion.x > customerRight)
				{
					sliderEmotion.x = customerRight;
				}
				Data.valueEmotion = 10 * (sliderEmotion.x - customerLeft) / (170 - sliderEmotion.width);
			}


			if (touch.getTouch(buttonRightPopulation, TouchPhase.ENDED))
			{
				if ((Data.valuePopulation + 20) <= 500)
				{
					Data.valuePopulation += 20;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftPopulation, TouchPhase.ENDED))
			{
				if ((Data.valuePopulation - 20) >= 0)
				{
					Data.valuePopulation -= 20;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightWheater, TouchPhase.ENDED))
			{
				if (Data.valueWeather < 10)
				{
					Data.valueWeather++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftWheater, TouchPhase.ENDED))
			{
				if (Data.valueWeather > 0)
				{
					Data.valueWeather--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightEvent, TouchPhase.ENDED))
			{
				if (Data.valueEvent < 10)
				{
					Data.valueEvent++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftEvent, TouchPhase.ENDED))
			{
				if (Data.valueEvent > 0)
				{
					Data.valueEvent--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			
			if (touch.getTouch(buttonRightCompetitor, TouchPhase.ENDED))
			{
				if (Data.valueCompetitor < 10)
				{
					Data.valueCompetitor++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftCompetitor, TouchPhase.ENDED))
			{
				if (Data.valueCompetitor > 0)
				{
					Data.valueCompetitor--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightVariant, TouchPhase.ENDED))
			{
				if (Data.valueVariant < 10)
				{
					Data.valueVariant++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftVariant, TouchPhase.ENDED))
			{
				if (Data.valueVariant > 0)
				{
					Data.valueVariant--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightAddicted, TouchPhase.ENDED))
			{
				if (Data.valueAddicted < 10)
				{
					Data.valueAddicted++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftAddicted, TouchPhase.ENDED))
			{
				if (Data.valueAddicted > 0)
				{
					Data.valueAddicted--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightBuying, TouchPhase.ENDED))
			{
				if (Data.valueBuying < 10)
				{
					Data.valueBuying++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftBuying, TouchPhase.ENDED))
			{
				if (Data.valueBuying > 0)
				{
					Data.valueBuying--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightEmotion, TouchPhase.ENDED))
			{
				if (Data.valueEmotion < 10)
				{
					Data.valueEmotion++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftEmotion, TouchPhase.ENDED))
			{
				if (Data.valueEmotion > 1)
				{
					Data.valueEmotion--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			updateSlider();
		}

		/**
		 * Update slider position by value.
		 */
		public function updateSlider():void
		{
			sliderPopulation.x = distance / 500 * Data.valuePopulation + worldLeft;
			sliderWeather.x = distance / 10 * Data.valueWeather + worldLeft;
			sliderEvent.x = distance / 10 * Data.valueEvent + worldLeft;
			sliderCompetitor.x = distance / 10 * Data.valueCompetitor + worldLeft;

			sliderVariant.x = distance / 10 * Data.valueVariant + customerLeft;
			sliderAddicted.x = distance / 10 * Data.valueAddicted + customerLeft;
			sliderBuying.x = distance / 10 * Data.valueBuying + customerLeft;
			sliderEmotion.x = distance / 10 * Data.valueEmotion + customerLeft;
		}

		/**
		 * Update tooltips position.
		 */
		public function update():void
		{
			showTips.x = Starling.current.nativeOverlay.mouseX - 5;
			showTips.y = Starling.current.nativeOverlay.mouseY - 10;
		}

		/**
		 * Release all resources.
		 */
		public function destroy():void
		{
			showTips.removeFromParent(true);
			removeFromParent(true);
		}

	}
}
