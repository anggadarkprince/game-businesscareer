package sketchproject.screens
{
	import com.greensock.TweenMax;
	
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.objects.finance.BalanceSheet;
	import sketchproject.objects.finance.CashFlow;
	import sketchproject.objects.finance.GeneralJournal;
	import sketchproject.objects.finance.GeneralLedger;
	import sketchproject.objects.finance.ProfitChart;
	import sketchproject.objects.finance.ProfitLoss;
	import sketchproject.objects.finance.TrialBalance;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class FinanceScreen extends GameScreen
	{
		public static const REPORT_READY:String = "reportLoaded";
		
		private var menu:Image;
		private var selectMenu:Image;
		private var buttonGeneraJournal:Quad;
		private var buttonGeneralLedger:Quad;
		private var buttonTrialBalance:Quad;
		private var buttonBalanceSheet:Quad;
		private var buttonProfitLoss:Quad;
		private var buttonCashFlow:Quad;
		private var buttonProfitChart:Quad;
		private var baseContent:Shape;
		
		// content
		private var generalJournal:GeneralJournal;
		private var generalLedger:GeneralLedger;
		private var trialBalance:TrialBalance;
		private var balanceSheet:BalanceSheet;
		private var profitLoss:ProfitLoss;
		private var cashFlow:CashFlow;
		private var profitChart:ProfitChart;
		private var label:TextField;
		private var cashMoney:TextField;
		private var businessActiva:TextField;
		private var netIncome:TextField;
		
		private var track:Image;
		private var slider:Image;
		private var contentMask:Quad;
		private var mask:Sprite;
		
		private var content:Sprite;
		
		private var generalJournalLoad:Boolean = true;
		private var generalLedgerLoad:Boolean = false;
		private var trialBalanceLoad:Boolean = false;
		private var balanceSheetLoad:Boolean = false;
		private var profitLossLoad:Boolean = false;
		private var cashFlowLoad:Boolean = false;
		private var profitChartLoad:Boolean = false;
		
		private var myTimer:Timer = new Timer(1000);
		
		public function FinanceScreen()
		{
			super();
			
			baseContent = new Shape();
			baseContent.graphics.clear();
			baseContent.graphics.beginFill(0xFFFFFF);
			baseContent.graphics.lineStyle(1, 0xFFFFFF, 0.5);
			baseContent.graphics.drawRoundRect(-250, -192.6, 700, 305, 10);
			baseContent.graphics.endFill();
			addChild(baseContent);
			
			track = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("help_slider_track"));
			track.pivotX = track.width * 0.5;
			track.x = 365;
			track.y = -190;
			addChild(track);
			
			slider = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("help_slider"));
			slider.pivotX = slider.width * 0.5;
			slider.pivotY = slider.height * 0.5;
			slider.x = 365;
			slider.y = -190 + (slider.height * 0.5);
			addChild(slider);
			
			contentMask = new Quad(570,300,0xCCCCCC);
			contentMask.x = -220;
			contentMask.y = -190;
			addChild(contentMask);
			
			
			
			generalJournal = new GeneralJournal();
			generalJournal.x = -215;
			generalJournal.y = -185;
			generalJournal.visible = false;
			generalJournal.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(generalJournal);
			
			generalLedger = new GeneralLedger();
			generalLedger.x = -215;
			generalLedger.y = -185;
			generalLedger.visible = false;
			generalLedger.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(generalLedger);
			
			trialBalance = new TrialBalance();
			trialBalance.x = -215;
			trialBalance.y = -185;
			trialBalance.visible = false;
			trialBalance.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(trialBalance);
			
			balanceSheet = new BalanceSheet();
			balanceSheet.x = -215;
			balanceSheet.y = -185;
			balanceSheet.visible = false;
			balanceSheet.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(balanceSheet);
			
			profitLoss = new ProfitLoss();
			profitLoss.x = -215;
			profitLoss.y = -185;
			profitLoss.visible = false;
			profitLoss.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(profitLoss);
			
			cashFlow = new CashFlow();
			cashFlow.x = -215;
			cashFlow.y = -185;
			cashFlow.visible = false;
			cashFlow.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(cashFlow);
			
			profitChart = new ProfitChart();
			profitChart.x = -215;
			profitChart.y = -185;
			profitChart.visible = false;
			profitChart.addEventListener(FinanceScreen.REPORT_READY, loadedHandler);
			addChild(profitChart);
			
			
			mask = new Sprite();
			mask.addChild(generalJournal);
			mask.addChild(generalLedger);
			mask.addChild(trialBalance);
			mask.addChild(balanceSheet);
			mask.addChild(profitLoss);
			mask.addChild(cashFlow);
			mask.addChild(profitChart);
			mask.clipRect = new Rectangle(-220, -185, 570, 290);
			addChild(mask);			
			
			
						
			menu = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("report_menu_background"));
			menu.x = -455;
			menu.y = -200;
			addChild(menu);
			
			selectMenu = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("report_select"));
			selectMenu.x = -455.75;
			selectMenu.y = -185;
			selectMenu.scaleX = 0.9;
			selectMenu.scaleY = 0.9;
			addChild(selectMenu);
			
			menu = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("report_menu"));
			menu.x = -419.25;
			menu.y = -178.9;
			addChild(menu);
			
			menu = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("advisor_fitri_aisyah"));
			menu.x = 375;
			menu.y = -200;
			addChild(menu);
			
			buttonGeneraJournal = new Quad(180, 30);
			buttonGeneraJournal.x = -430;
			buttonGeneraJournal.y = -175;
			buttonGeneraJournal.alpha = 0;			
			addChild(buttonGeneraJournal);
			
			buttonGeneralLedger = new Quad(180, 30);
			buttonGeneralLedger.x = -430;
			buttonGeneralLedger.y = -133;
			buttonGeneralLedger.alpha = 0;
			addChild(buttonGeneralLedger);
			
			buttonTrialBalance = new Quad(180, 30);
			buttonTrialBalance.x = -430;
			buttonTrialBalance.y = -93;
			buttonTrialBalance.alpha = 0;
			addChild(buttonTrialBalance);
			
			buttonBalanceSheet = new Quad(180, 30);
			buttonBalanceSheet.x = -430;
			buttonBalanceSheet.y = -50;
			buttonBalanceSheet.alpha = 0;
			addChild(buttonBalanceSheet);
			
			buttonProfitLoss = new Quad(180, 30);
			buttonProfitLoss.x = -430;
			buttonProfitLoss.y = -8;
			buttonProfitLoss.alpha = 0;
			addChild(buttonProfitLoss);
			
			buttonCashFlow = new Quad(180, 30);
			buttonCashFlow.x = -430;
			buttonCashFlow.y = 30;
			buttonCashFlow.alpha = 0;
			addChild(buttonCashFlow);
			
			buttonProfitChart = new Quad(180, 30);
			buttonProfitChart.x = -430;
			buttonProfitChart.y = 67;
			buttonProfitChart.alpha = 0;
			addChild(buttonProfitChart);
			
			label = new TextField(100, 50, "Cash Money", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -200;
			label.y = 125;
			addChild(label);
			
			cashMoney = new TextField(300, 50, "IDR 5000 K", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 17, 0x333333);
			cashMoney.vAlign = VAlign.TOP;
			cashMoney.hAlign = HAlign.LEFT;
			cashMoney.x = -200;
			cashMoney.y = 140;
			addChild(cashMoney);
			
			label = new TextField(100, 50, "Retain Earning", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -20;
			label.y = 125;
			addChild(label);
			
			businessActiva = new TextField(300, 50, "IDR 5000 K", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 17, 0x333333);
			businessActiva.vAlign = VAlign.TOP;
			businessActiva.hAlign = HAlign.LEFT;
			businessActiva.x = -20;
			businessActiva.y = 140;
			addChild(businessActiva);
			
			label = new TextField(100, 50, "Net Income", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 150;
			label.y = 125;
			addChild(label);
			
			netIncome = new TextField(300, 50, "IDR 5000 K", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 17, 0x333333);
			netIncome.vAlign = VAlign.TOP;
			netIncome.hAlign = HAlign.LEFT;
			netIncome.x = 150;
			netIncome.y = 140;
			addChild(netIncome);
			
			addEventListener(TouchEvent.TOUCH, menuTouch);
			
			content = generalJournal;
			
			myTimer.addEventListener(TimerEvent.TIMER, update);
		}
		
		public function startRetrieveFinance():void
		{	
			Game.loadingScreen.show();
			
			balanceSheet.isLoaded = false;
			cashFlow.isLoaded = false;
			generalJournal.isLoaded = false;
			generalLedger.isLoaded = false;
			profitChart.isLoaded = false;
			profitLoss.isLoaded = false;
			trialBalance.isLoaded = false;
			
			myTimer.start();
		}
		
		public function update(event:TimerEvent):void
		{
			if(generalJournalLoad)
			{
				generalJournalLoad = false;
				generalLedgerLoad = true;
				generalJournal.updateReport();
			}
			else if(generalLedgerLoad)
			{
				generalLedgerLoad = false;
				trialBalanceLoad = true;
				generalLedger.updateReport();
			}
			else if(trialBalanceLoad)
			{
				trialBalanceLoad = false;
				balanceSheetLoad = true;
				trialBalance.updateReport();
			}
			else if(balanceSheetLoad)
			{
				balanceSheetLoad = false;
				profitLossLoad = true;
				balanceSheet.updateReport();
			}
			else if(profitLossLoad)
			{
				profitLossLoad = false;
				cashFlowLoad = true;
				profitLoss.updateReport();
			}
			else if(cashFlowLoad)
			{
				cashFlowLoad = false;
				profitChartLoad = true;
				cashFlow.updateReport();
			}
			else if(profitChartLoad)
			{
				profitChartLoad = false;
				generalJournalLoad = true;
				myTimer.stop();
				profitChart.updateReport();
			}
						
		}
		
		private function loadedHandler(event:Event):void
		{
			trace(balanceSheet.isLoaded,cashFlow.isLoaded,generalJournal.isLoaded,generalLedger.isLoaded,profitChart.isLoaded,profitLoss.isLoaded,trialBalance.isLoaded);
			if(balanceSheet.isLoaded && cashFlow.isLoaded && generalJournal.isLoaded && generalLedger.isLoaded && profitChart.isLoaded && profitLoss.isLoaded && trialBalance.isLoaded)
			{
				switchReport(generalJournal);
				selectMenu.y = buttonGeneraJournal.y-10
				cashMoney.text = "IDR "+ValueFormatter.format(Data.cash);
				businessActiva.text = "IDR "+ValueFormatter.format(balanceSheet.getActiva());
				netIncome.text = "IDR "+ValueFormatter.format(profitLoss.getNetIncome());
				
				Game.loadingScreen.hide();
			}
		}
		
		private function menuTouch(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonGeneraJournal, TouchPhase.ENDED))
			{
				contentMask.alpha = 1;
				TweenMax.to(selectMenu,0.3,{y:buttonGeneraJournal.y-10});
				switchReport(generalJournal);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);				
			}	
			if (touch.getTouch(buttonGeneralLedger, TouchPhase.ENDED))
			{
				contentMask.alpha = 1;
				TweenMax.to(selectMenu,0.3,{y:buttonGeneralLedger.y-10});
				switchReport(generalLedger);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonTrialBalance, TouchPhase.ENDED))
			{
				contentMask.alpha = 1;
				TweenMax.to(selectMenu,0.3,{y:buttonTrialBalance.y-10});
				switchReport(trialBalance);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonBalanceSheet, TouchPhase.ENDED))
			{
				contentMask.alpha = 1;
				TweenMax.to(selectMenu,0.3,{y:buttonBalanceSheet.y-10});
				switchReport(balanceSheet);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonProfitLoss, TouchPhase.ENDED))
			{
				contentMask.alpha = 1;
				TweenMax.to(selectMenu,0.3,{y:buttonProfitLoss.y-10});
				switchReport(profitLoss);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonCashFlow, TouchPhase.ENDED))
			{
				contentMask.alpha = 1;
				TweenMax.to(selectMenu,0.3,{y:buttonCashFlow.y-10});
				switchReport(cashFlow);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonProfitChart, TouchPhase.ENDED))
			{
				contentMask.alpha = 0;
				TweenMax.to(selectMenu,0.3,{y:buttonProfitChart.y-10});
				switchReport(profitChart);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			
			if (touch.getTouch(slider, TouchPhase.MOVED)) {
				if(slider.y >= track.y + (slider.height * 0.5) && slider.y <= (track.y + track.height) - (slider.height * 0.5)){
					slider.y = touch.getTouch(this).getLocation(this).y;
				}
				if(slider.y < track.y + (slider.height * 0.5)) {
					slider.y = track.y + (slider.height * 0.5);
				}
				if(slider.y > track.y + track.height - (slider.height * 0.5)) {
					slider.y = track.y + track.height - (slider.height * 0.5);
				}
				updateContentPosition();
			}
		}
		
		private function switchReport(activeReport:Sprite):void
		{	
			generalJournal.visible = false;
			generalLedger.visible = false;
			trialBalance.visible = false;
			balanceSheet.visible = false;
			profitLoss.visible = false;
			cashFlow.visible = false;
			profitChart.visible = false;
			
			activeReport.visible = true;
			verifyHeight(activeReport);
		}
		
		
		/**
		 * Update content position
		 * @return void
		 */
		private function updateContentPosition():void {
			var scrollPercent:Number =  100 / (track.height - slider.height)  * (slider.y - track.y - (slider.height * 0.5));
			var newContentY:Number = (contentMask.y + 5) + ((contentMask.height-10) - content.height) / 100 * scrollPercent;
			content.y = newContentY;
		}
		
		/**
		 * Check if scrollbar is necessary
		 * @return void
		 */
		private function verifyHeight(sprite:Sprite):void {
			content = sprite;
			content.y = -185;
			slider.y = -190 + (slider.height * 0.5);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			if (contentMask.height >= content.height) {
				slider.visible = false;
				track.visible = false;
			}
			else {
				slider.visible = true;
				track.visible = true;
			}
		}
	}
}