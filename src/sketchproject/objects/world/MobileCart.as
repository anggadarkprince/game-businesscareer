package sketchproject.objects.world
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Expo;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkParticleManager;
	import sketchproject.objects.dialog.TipsDialog;
	import sketchproject.utilities.DayCounter;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import sketchproject.objects.BallonTips;
	import sketchproject.objects.Tooltips;
	
	public class MobileCart extends Sprite
	{
		private static var instance:MobileCart;
		
		private var background:Image;
		private var logo:Image;
		private var advisor:Button;
		
		private var marketShare:Image;
		private var customerTraffict:Image;
		private var emprloyeeMorale:Image;
		private var stressLevel:Image;
		
		private var label:TextField;
		private var date:TextField;		
		private var shop:TextField;
		private var ceo:TextField;
		private var salesToday:TextField;
		private var salesTotal:TextField;
		private var advisorName:TextField;
		
		private var tipsOfTheDay:TipsDialog;
		
		private var ballon:BallonTips;
		private var showTips:Tooltips;
		
		private var myTimer:Timer = new Timer(20000);
		private var fireworkManager:FireworkParticleManager;
		
		
		public function MobileCart()
		{
			super();
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			showTips = Tooltips(Game.overlayStage.getChildByName("tooltips"));
			
			
			tipsOfTheDay = new TipsDialog();
			tipsOfTheDay.x = Starling.current.stage.stageWidth * 0.5;
			tipsOfTheDay.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(tipsOfTheDay);		
			
			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("mobile_cart"));
			addChild(background);
			
			date = new TextField(180, 25, DayCounter.today()+", Day "+DayCounter.dayCounting()+", Year "+DayCounter.yearCounting(), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			date.pivotX = date.width * 0.5;
			date.x = background.width * 0.5;
			date.y = 35;
			date.hAlign = HAlign.CENTER;
			addChild(date);
			
			logo = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.logo));
			logo.x = 20;
			logo.y = 66;
			logo.scaleX = 0.7;
			logo.scaleY = 0.7;
			addChild(logo);
			
			shop = new TextField(200, 25, Data.shop, Assets.getFont(Assets.FONT_SSBOLD).fontName, 17, 0x333333);
			shop.x = logo.x + logo.width + 8;
			shop.y = 61;
			shop.hAlign = HAlign.LEFT;
			addChild(shop);
			
			ceo = new TextField(200, 25, Data.name, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			ceo.x = shop.x;
			ceo.y = 80;
			ceo.hAlign = HAlign.LEFT;
			addChild(ceo);
			
			label = new TextField(150, 25, "Sales Today", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.pivotX = label.width * 0.5;
			label.x = 60;
			label.y = 110;
			label.hAlign = HAlign.CENTER;
			addChild(label);
			
			salesToday = new TextField(150, 25, "IDR "+ValueFormatter.format(Data.salesToday), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0xFFFFFF);
			salesToday.pivotX = salesToday.width * 0.5;
			salesToday.x = label.x;
			salesToday.y = 125;
			salesToday.hAlign = HAlign.CENTER;
			addChild(salesToday);
			
			label = new TextField(150, 25, "Sales Total", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.pivotX = label.width * 0.5;
			label.x = 140;
			label.y = 110;
			label.hAlign = HAlign.CENTER;
			addChild(label);
			
			salesTotal = new TextField(150, 25, "IDR "+ValueFormatter.format(Data.salesTotal), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0xFFFFFF);
			salesTotal.pivotX = salesTotal.width * 0.5;
			salesTotal.x = label.x;
			salesTotal.y = 125;
			salesTotal.hAlign = HAlign.CENTER;
			addChild(salesTotal);
			
			marketShare = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("cart_market_share"));
			marketShare.x = 20;
			marketShare.y = 165;
			addChild(marketShare);
			
			customerTraffict = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("cart_customer_traffict"));
			customerTraffict.x = marketShare.x + marketShare.width + 5;
			customerTraffict.y = 165;
			addChild(customerTraffict);
			
			emprloyeeMorale = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("cart_employee_morale"));
			emprloyeeMorale.x = customerTraffict.x + customerTraffict.width + 5;
			emprloyeeMorale.y = 165;
			addChild(emprloyeeMorale);
			
			stressLevel = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("cart_stress_level"));
			stressLevel.x = emprloyeeMorale.x + emprloyeeMorale.width + 5;
			stressLevel.y = 165;
			addChild(stressLevel);
			
			advisor = new Button(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture(Data.advisor));
			advisor.x = 20;
			advisor.y = 235;
			advisor.scaleX = 0.7;
			advisor.scaleY = 0.7;
			addChild(advisor);
			
			label = new TextField(150, 25, "Business", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.x = advisor.x + advisor.width + 5;
			label.y = 231;
			label.hAlign = HAlign.LEFT;
			addChild(label);
			
			label = new TextField(150, 25, "Advisor", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.x = advisor.x + advisor.width + 5;
			label.y = 245;
			label.hAlign = HAlign.LEFT;
			addChild(label);
			
			advisorName = new TextField(150, 25, Config.Adviser[Data.advisor], Assets.getFont(Assets.FONT_SSBOLD).fontName, 17, 0x333333);
			advisorName.x = advisor.x + advisor.width + 5;
			advisorName.y = 265;
			advisorName.hAlign = HAlign.LEFT;
			addChild(advisorName);
						
			label = new TextField(150, 25, "HIMAX POLYMER Li", Assets.getFont(Assets.FONT_SSBOLD).fontName, 12, 0x333333);
			label.pivotX = label.width * 0.5;
			label.x = background.width * 0.5;
			label.y = 299;
			label.hAlign = HAlign.CENTER;
			addChild(label);
			
			ballon = new BallonTips("Call Me", true, true);
			ballon.x = -15;
			ballon.y = 250;
			ballon.scaleX = 0;
			ballon.scaleY = 0;
			ballon.alpha = 0;
			addChild(ballon);
			
			advisor.addEventListener(Event.TRIGGERED, onTipsRequested);			
			addEventListener(TouchEvent.TOUCH, onTouched);
			
			update();
		}
		
		public static function getInstance():MobileCart
		{
			if(instance == null){
				instance = new MobileCart();
			}
			return instance;
		}
		
		private function onTouched(touch:TouchEvent):void
		{		
			if (touch.getTouch(marketShare, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Your Marketshare "+Config.marketShare[0][0]+ "%";
			}
			else if (touch.getTouch(customerTraffict, TouchPhase.HOVER))
			{
				showTips.showTips();
				var emotion:String;
				if(Data.customerHistory.length != 0)
				{
					emotion = Data.customerHistory[Data.customerHistory.length-1];
				}
				else
				{
					emotion = "Squint";
				}
				showTips.info = "Customer Average "+emotion;
			}
			else if (touch.getTouch(emprloyeeMorale, TouchPhase.HOVER))
			{
				showTips.showTips();
				var morale:int = 0;
				for(var i:int = 0; i<Data.employee.length; i++)
				{
					morale+=Data.employee[i].pem_morale;
				}
				if(Data.employee.length != 0)
				{
					morale = morale/Data.employee.length;
				}
				showTips.info = "Morale Average "+morale;
			}
			else if (touch.getTouch(stressLevel, TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Your Stress "+Data.stress;
			}
			else{
				showTips.hideTips();
			}
		}
		
		public function startAdvisorSignal():void{			
			myTimer.addEventListener(TimerEvent.TIMER, onAdvisorCalled);
			myTimer.start();
		}
		
		public function stopAdvisorSignal():void{
			ballon.alpha = 0;
			label.visible = false;
			myTimer.stop();			
			myTimer.removeEventListener(TimerEvent.TIMER, onAdvisorCalled);	
			removeEventListener(TouchEvent.TOUCH, onTouched);
		}
		
		private function onAdvisorCalled(event:TimerEvent):void
		{			
			if(Math.random() < 0.5){
				shakeTween(ballon, 10);
			}
		}
		
		private function shakeTween(item:DisplayObject, repeatCount:int):void
		{
			TweenMax.to(item,0.2,{x:-55,y:220,scaleX:1, scaleY:1, alpha:1, ease:Bounce.easeInOut});
			TweenMax.to(item,0.1,{repeat:repeatCount-1, y:220+(1+Math.random()*7), x:-55+(1+Math.random()*7), delay:0.5, ease:Expo.easeInOut});
			TweenMax.to(item,0.1,{y:220, x:-55, delay:(repeatCount+5) * .1, delay:0.7, ease:Expo.easeInOut});
			TweenMax.to(item,0.2,{delay:4, onComplete:function():void{
				TweenMax.to(item,0.2,{x:-15, y:250, scaleX:0, scaleY:0, alpha:0, ease:Bounce.easeIn});
			}});
		} 
		
		private function onTipsRequested(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			tipsOfTheDay.generateTips();
			tipsOfTheDay.openDialog();
		}
				
		public function update():void{					
			date.text = DayCounter.today()+", Day "+DayCounter.dayCounting()+", Year "+DayCounter.yearCounting();
			logo.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.logo);
			shop.text = Data.shop;
			ceo.text = Data.name;
			salesToday.text = "IDR "+ValueFormatter.format(Data.salesToday);
			salesTotal.text = "IDR "+ValueFormatter.format(Data.salesTotal)
			advisor.upState = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture(Data.advisor);
			advisorName.text = Config.Adviser[Data.advisor];
			showTips.tipsDirection(Tooltips.TIPS_RIGHT);
		}
	}
}