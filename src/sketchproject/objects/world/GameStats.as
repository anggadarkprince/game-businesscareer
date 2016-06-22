package sketchproject.objects.world
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Shop;
	import sketchproject.objects.dialog.StatsCustomerDialog;
	import sketchproject.objects.dialog.StatsSalesDialog;
	import sketchproject.objects.dialog.StatsShopDialog;
	import sketchproject.objects.dialog.StatsTrendDialog;
	import sketchproject.utilities.DayCounter;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Show the stats bar in bottom when simulation started.
	 *
	 * @author Angga
	 */
	public class GameStats extends HeadUpDisplay
	{
		public static const SHOP_OPEN:String = "shopOpen";
		public static const SHOP_CLOSE:String = "shopClose";

		private var statsSales:StatsSalesDialog;
		private var statsCustomer:StatsCustomerDialog;
		private var statsShop:StatsShopDialog;
		private var statsTrend:StatsTrendDialog;

		public var clock:Clock;
		private var statsContainer:Sprite;
		private var statsBackground:Image;
		private var buttonShop:Button;
		private var buttonTrend:Button;
		private var buttonSales:Button;
		private var buttonView:Button;
		private var label:TextField;
		private var panelLabel:TextField;
		private var day:TextField;
		private var event:TextField;
		private var district:TextField;

		private var line:Quad;
		private var weatherContainer:Sprite;
		private var todayTemperatureForecast:TextField;
		private var todayIcon:Image;
		private var todayWeatherForecast:TextField;

		private var lineBar:Shape;

		private var marketShare:Array;

		private var lastX:Number = 599.2;
		private var lastY1:Number = 454.3 + 62;
		private var lastY2:Number = 454.3 + 62;
		private var lastY3:Number = 454.3 + 62;
		private var step:uint = 14;

		private var delayClockTick:int = 0;
		private var delayGraph:int = 0;

		private var opening:int;
		private var closing:int;
		private var openingDiscLimit:int;
		private var closingDiscLimit:int;
		private var checkOpen:Boolean = false;
		private var checkClose:Boolean = false;
		private var checkOpeningDiscount:Boolean = false;
		private var checkClosingDiscount:Boolean = false;

		/**
		 * Default constructor of GameStats.
		 */
		public function GameStats()
		{
			super();

			statsCustomer = new StatsCustomerDialog();
			statsCustomer.x = Starling.current.stage.stageWidth * 0.5;
			statsCustomer.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(statsCustomer);

			statsSales = new StatsSalesDialog();
			statsSales.x = Starling.current.stage.stageWidth * 0.5;
			statsSales.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(statsSales);

			statsShop = new StatsShopDialog();
			statsShop.x = Starling.current.stage.stageWidth * 0.5;
			statsShop.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(statsShop);

			statsTrend = new StatsTrendDialog();
			statsTrend.x = Starling.current.stage.stageWidth * 0.5;
			statsTrend.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(statsTrend);

			marketShare = new Array();

			buttonAddCustomer.enabled = false;
			buttonAddPoint.enabled = false;
			buttonAddProfit.enabled = false;
			buttonAddStar.enabled = false;

			zoomContainer.x -= 20;
			zoomContainer.y += 125;
			zoomContainer.visible = false;

			cart.visible = false;

			statsContainer = new Sprite();
			addChild(statsContainer);

			line = new Quad(770, 140, 0xCCCCCC);
			line.x = 115;
			line.y = 420.5;
			line.alpha = 0;
			statsContainer.addChild(line);

			buttonShop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_shops"));
			buttonShop.x = 730.35;
			buttonShop.y = 448.15;
			statsContainer.addChild(buttonShop);

			buttonTrend = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_trend"));
			buttonTrend.x = 730.35;
			buttonTrend.y = 487;
			statsContainer.addChild(buttonTrend);

			buttonSales = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_sales"));
			buttonSales.x = 127.75;
			buttonSales.y = 447.7;
			statsContainer.addChild(buttonSales);

			buttonView = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_view"));
			buttonView.x = 127.75;
			buttonView.y = 485.4;
			statsContainer.addChild(buttonView);

			statsBackground = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("game_stats_background"));
			statsBackground.x = 224.5;
			statsBackground.y = 420.5;
			statsContainer.addChild(statsBackground);

			panelLabel = new TextField(50, 50, "PANEL", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xFFFFFF);
			panelLabel.pivotX = panelLabel.width * 0.5;
			panelLabel.vAlign = VAlign.TOP;
			panelLabel.x = 500;
			panelLabel.y = 422;
			statsContainer.addChild(panelLabel);

			weatherContainer = new Sprite();
			weatherContainer.x = 248.6;
			weatherContainer.y = 443;
			statsContainer.addChild(weatherContainer);

			todayTemperatureForecast = new TextField(50, 50, Data.weather[0][1], Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			todayTemperatureForecast.hAlign = HAlign.LEFT;
			weatherContainer.addChild(todayTemperatureForecast);

			todayIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.weather[0][3]));
			todayIcon.x = 20;
			weatherContainer.addChild(todayIcon);

			todayWeatherForecast = new TextField(100, 50, Data.weather[0][2], Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			todayWeatherForecast.hAlign = HAlign.LEFT;
			todayWeatherForecast.y = 20;
			weatherContainer.addChild(todayWeatherForecast);

			day = new TextField(150, 25, "DAY " + DayCounter.dayCounting() + " YEAR " + DayCounter.yearCounting(), Assets.getFont(Assets.FONT_SSBOLD).fontName, 11, 0x333333);
			day.pivotX = day.width;
			day.hAlign = HAlign.RIGHT;
			day.vAlign = VAlign.TOP;
			day.x = 438;
			day.y = 448.05;
			statsContainer.addChild(day);

			event = new TextField(150, 25, Data.event.length + " EVENTS TODAY", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			event.pivotX = event.width;
			event.hAlign = HAlign.RIGHT;
			event.vAlign = VAlign.TOP;
			event.x = 438;
			event.y = 463.3;
			statsContainer.addChild(event);

			district = new TextField(150, 25, Data.district, Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			district.pivotX = district.width;
			district.hAlign = HAlign.RIGHT;
			district.vAlign = VAlign.TOP;
			district.x = 438;
			district.y = 477.7;
			statsContainer.addChild(district);

			line = new Quad(190, 1, 0x333333);
			line.x = 248.6;
			line.y = 504.65;
			statsContainer.addChild(line);

			label = new TextField(150, 25, "Weather", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 248.6;
			label.y = 504.65;
			statsContainer.addChild(label);

			label = new TextField(150, 25, "Traffic", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.RIGHT;
			label.vAlign = VAlign.TOP;
			label.pivotX = label.width;
			label.x = 438.4;
			label.y = 504.65;
			statsContainer.addChild(label);

			label = new TextField(150, 100, "100%\n\n50%\n\n0%", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 556.05;
			label.y = 452.2;
			statsContainer.addChild(label);

			line = new Quad(145, 65, 0xCCCCCC);
			line.x = 599.2;
			line.y = 454.3;
			statsContainer.addChild(line);

			line = new Quad(145, 1, 0xAAAAAA);
			line.x = 599.2;
			line.y = 474;
			statsContainer.addChild(line);

			line = new Quad(145, 1, 0xAAAAAA);
			line.x = 599.2;
			line.y = 504;
			statsContainer.addChild(line);

			lineBar = new Shape();
			statsContainer.addChild(lineBar);

			clock = new Clock();
			clock.x = 455.05 + clock.width * 0.5 + 3;
			clock.y = 440.55 + clock.height * 0.5 + 10;
			statsContainer.addChild(clock);

			opening = int(Data.schedule[DayCounter.numberDayWeek()][0]);
			closing = int(Data.schedule[DayCounter.numberDayWeek()][1]);
			openingDiscLimit = opening + 2;
			closingDiscLimit = closing - 2;
			clock.hour = 5;

			addEventListener(TouchEvent.TOUCH, onStatsTouched);

			hideStats();
		}

		/**
		 * Show and hide game stats and catch touch on button stats dialog.
		 *
		 * @param touch
		 */
		private function onStatsTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(statsContainer, TouchPhase.HOVER) || touch.getTouch(statsContainer, TouchPhase.BEGAN) || touch.getTouch(statsContainer, TouchPhase.ENDED) || touch.getTouch(statsContainer, TouchPhase.MOVED))
			{
				showStats();
			}
			else
			{
				hideStats();
			}

			if (touch.getTouch(buttonSales, TouchPhase.ENDED))
			{
				statsSales.openDialog();
			}

			if (touch.getTouch(buttonShop, TouchPhase.ENDED))
			{
				//statsShop.openDialog();
			}

			if (touch.getTouch(buttonTrend, TouchPhase.ENDED))
			{
				//statsTrend.openDialog();
			}

			if (touch.getTouch(buttonView, TouchPhase.ENDED))
			{
				//statsCustomer.openDialog();
			}
		}

		/**
		 * Show this stats and move outside the screen.
		 */
		public function showStats():void
		{
			statsContainer.y = 0;
			hudContainer.y = 0;
			panelLabel.visible = false;
		}

		/**
		 * Hide this stats and move in properly position.
		 */
		public function hideStats():void
		{
			hudContainer.y = -200;
			statsContainer.y = 115;
			panelLabel.visible = true;
		}

		private var lastA:int = 0;
		private var lastB:int = 0;
		private var lastC:int = 0;

		/**
		 * Update the clock ticks and animation.
		 */
		override public function update():void
		{
			delayClockTick++;
			delayGraph++;

			if (delayClockTick == 20)
			{
				clock.update();

				statsSales.update();

				if (!checkOpen && clock.hour == opening)
				{
					checkOpen = true;
					trace("open shop at " + opening);
					if (Data.discountFirst)
					{
						trace("opening with discount 5% for 2 hours until " + openingDiscLimit);
							// cut the opening price
					}
					else
					{
						trace("opening without discount");
						checkOpeningDiscount = true;
					}
					dispatchEventWith(SHOP_OPEN);
				}

				if (!checkClose && clock.hour == closing)
				{
					checkClose = true;
					trace("closing discount ended");
					trace("close shop at " + closing);
					// restore the closing price
					dispatchEventWith(SHOP_CLOSE);
				}

				if (!checkOpeningDiscount && clock.hour == openingDiscLimit)
				{
					checkOpeningDiscount = true;
					trace("opening discount ended");
						// restore the opening price
				}

				if (!checkClosingDiscount && clock.hour == closingDiscLimit)
				{
					checkClosingDiscount = true;
					if (Data.discountLast)
					{
						trace("closing with discount 10% for 2 hours from " + closingDiscLimit + " until closed");
							// cut the closing price
					}
					else
					{
						trace("closing without discount");
					}
				}

				delayClockTick = 0;
			}

			if (delayGraph == 50)
			{
				lastX = 599.2;
				lastY1 = 454.3 + 62;
				lastY2 = 454.3 + 62;
				lastY3 = 454.3 + 62;

				// change with real marketplace
				var a:int = Shop(WorldManager.instance.listShop[0]).marketshare; //Math.ceil(Math.random() * 100);
				var c:int = Shop(WorldManager.instance.listShop[1]).marketshare; //Math.ceil(Math.random() * (100 - a));
				var b:int = Shop(WorldManager.instance.listShop[2]).marketshare; //100 - (a + b);

				if (lastA != a || lastB != b || lastC != c)
				{

					lastA = a;
					lastB = b;
					lastC = c;

					marketShare.push(new Array(a, b, c));

					if (marketShare.length > 10)
					{
						lastY1 = 454.3 + 62 - (60 / 100 * marketShare[0][0]);
						lastY2 = 454.3 + 62 - (60 / 100 * marketShare[0][1]);
						lastY3 = 454.3 + 62 - (60 / 100 * marketShare[0][2]);
						marketShare.shift();
					}

					lineBar.graphics.clear();

					for (var i:uint = 0, l:uint = marketShare.length; i < l; i++)
					{
						lineBar.graphics.lineStyle(3, 0xff5053);
						lineBar.graphics.moveTo(lastX, lastY1);
						lastY1 = 454.3 + 62 - (60 / 100 * marketShare[i][0]);
						lineBar.graphics.lineTo(lastX + step, lastY1);

						lineBar.graphics.lineStyle(3, 0x06cffd);
						lineBar.graphics.moveTo(lastX, lastY2);
						lastY2 = 454.3 + 62 - (60 / 100 * marketShare[i][1]);
						lineBar.graphics.lineTo(lastX + step, lastY2);

						lineBar.graphics.lineStyle(3, 0x96ce00);
						lineBar.graphics.moveTo(lastX, lastY3);
						lastY3 = 454.3 + 62 - (60 / 100 * marketShare[i][2]);
						lineBar.graphics.lineTo(lastX + step, lastY3);

						lastX += step;
					}
				}

				delayGraph = 0;
			}

			super.update();
		}

		/**
		 * Destroy all stats resources.
		 */
		public override function destroy():void
		{
			statsCustomer.removeFromParent();
			statsSales.removeFromParent();
			statsShop.removeFromParent();
			statsTrend.removeFromParent();
			super.destroy();
		}
	}
}
