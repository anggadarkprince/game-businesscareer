package sketchproject.objects.startup
{
	import feathers.controls.TextInput;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.objects.Tooltips;
	import sketchproject.objects.world.AvatarController;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class StartupConfiguration extends Sprite
	{
		private var labelMenu:TextField;
		
		private var inputName:TextInput;
		private var inputMotivation:TextInput;
		private var inputRestaurantName:TextInput;
		private var businessLogo:uint;
		private var businessAdvisor:uint;
		
		private var logoCheck:Image;
		private var advisorCheck:Image;
				
		private var logo:Image;
		private var advisor:Image;
		
		private var selectedLogo:Quad;
		private var selectedAdvisor:Quad;
		
		private var avatarControl:AvatarController;
		private var showTips:Tooltips;
				
		public function StartupConfiguration()
		{
			super();
			
			showTips = new Tooltips();
			showTips.tipsDirection(Tooltips.TIPS_LEFT);
			Game.overlayStage.addChild(showTips);
			
			new MetalWorksDesktopTheme();
			
			var line:Quad = new Quad(3,340,0x333333);
			line.x = 240;
			line.y = 10;
			addChild(line);
			line = new Quad(3,340,0x333333);
			line.x = 580;
			line.y = 10;
			addChild(line);
			
			businessLogo = 1;
			businessAdvisor = 1;
						
			labelMenu = new TextField(200, 50, "C.E.O Name", Assets.getFont(Assets.FONT_ITCERAS).fontName, 18, 0x333333);
			labelMenu.y = 70;
			labelMenu.hAlign = HAlign.LEFT;
			addChild(labelMenu);
			
			inputName = new TextInput();
			inputName.prompt = "Put your name here";
			inputName.width = 200;
			inputName.height = 30;
			inputName.y = 110;			
			inputName.text = Data.name;
			addChild(inputName);			
						
			labelMenu = new TextField(200, 50, "Your Motivation", Assets.getFont(Assets.FONT_ITCERAS).fontName, 18, 0x333333);
			labelMenu.y = 150;
			labelMenu.hAlign = HAlign.LEFT;
			addChild(labelMenu);
			
			inputMotivation = new TextInput();
			inputMotivation.prompt = "Put your business motivation";
			inputMotivation.width = 200;
			inputMotivation.height = 30;
			inputMotivation.y = 190;			
			inputMotivation.text = "Brand new day"
			addChild(inputMotivation);	
									
			labelMenu = new TextField(200, 50, "Restaurant Name", Assets.getFont(Assets.FONT_ITCERAS).fontName, 18, 0x333333);
			labelMenu.x = 270;
			labelMenu.y = 0;
			labelMenu.hAlign = HAlign.LEFT;
			addChild(labelMenu);
			
			inputRestaurantName = new TextInput();
			inputRestaurantName.prompt = "Put your shop name";
			inputRestaurantName.width = 280;
			inputRestaurantName.height = 30;
			inputRestaurantName.x = 270;
			inputRestaurantName.y = 40;
			inputRestaurantName.text = Data.nickname+ " Shop";
			addChild(inputRestaurantName);	
						
			labelMenu = new TextField(200, 50, "Business Logo", Assets.getFont(Assets.FONT_ITCERAS).fontName, 18, 0x333333);
			labelMenu.x = 270;
			labelMenu.y = 75;
			labelMenu.hAlign = HAlign.LEFT;
			addChild(labelMenu);
			
			labelMenu = new TextField(200, 50, "Business Advisor", Assets.getFont(Assets.FONT_ITCERAS).fontName, 18, 0x333333);
			labelMenu.x = 270;
			labelMenu.y = 190;
			labelMenu.hAlign = HAlign.LEFT;
			addChild(labelMenu);
			
			labelMenu = new TextField(200, 50, "Avatar Design", Assets.getFont(Assets.FONT_ITCERAS).fontName, 18, 0x333333);
			labelMenu.x = 760;
			labelMenu.y = 0;
			labelMenu.hAlign = HAlign.LEFT;
			addChild(labelMenu);
			
			avatarControl = AvatarController.getInstance();
			avatarControl.x = 620;
			avatarControl.y = 60;
			addChild(avatarControl);
												
			selectedLogo = new Quad(62,62,0xc0251e);
			selectedLogo.x = 275;
			selectedLogo.y = 115;
			addChild(selectedLogo);
			
			selectedAdvisor = new Quad(92,92,0xc0251e);
			selectedAdvisor.x = 275;
			selectedAdvisor.y = 232;
			addChild(selectedAdvisor);
									
			for(var j:uint = 0; j< 4; j++) 
			{
				logo = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("logo"+(j+1)));
				logo.x = (j * (logo.width + 17)) + 280;
				logo.y =  119;
				logo.name = "logo"+(j+1);
				addChild(logo);
				logo.addEventListener(TouchEvent.TOUCH, logoOnTouch);
			}
			
			logoCheck = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			logoCheck.x = logo.x;
			logoCheck.y = 165;
			addChild(logoCheck);			
			
			for(var k:uint = 0; k < 3; k++)	
			{
				advisor = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("advisor"+(k+1)));
				advisor.x = (k * (advisor.width + 12)) + 280;
				advisor.y =  238;
				advisor.name = "advisor"+(k+1);
				addChild(advisor);
				advisor.addEventListener(TouchEvent.TOUCH, advisorOnTouch);
			}
			
			advisorCheck = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			advisorCheck.x = advisor.x;
			advisorCheck.y = 310;
			addChild(advisorCheck);
						
			setup();
		}
				
		
		/**
		 * event when logo touched / selected
		 * update [data]{logo} player 
		 * update [selectedLogo] x position to target has touched
		 * update [logoCheck] x position to target has touched
		 * play sfx to sound channel
		 * 
		 * change tips info and set visible
		 * show tips ["your business logo1|logo2|logo3"]
		 * 
		 * @params touch passing touch event
		 * @return void
		 */
		private function logoOnTouch(touch:TouchEvent):void 
		{
			if (touch.getTouch(Image(touch.target), TouchPhase.ENDED)) 
			{
				Data.logo = Image(touch.target).name;
				selectedLogo.x = Image(touch.target).x - 5;
				logoCheck.x = Image(touch.target).x + Image(touch.target).width * 0.5 - logoCheck.width * 0.5;
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}		
			
			if (touch.getTouch(Image(touch.target), TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Your Business "+Image(touch.target).name;
			}			
			else
			{
				showTips.hideTips();
			}
		}
		
		private function advisorOnTouch(touch:TouchEvent):void 
		{
			if (touch.getTouch(Image(touch.target), TouchPhase.ENDED)) 
			{
				Data.advisor = Image(touch.target).name;
				selectedAdvisor.x = Image(touch.target).x - 6.7;
				advisorCheck.x = Image(touch.target).x + Image(touch.target).width * 0.5 - logoCheck.width * 0.5;
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}	
			
			if (touch.getTouch(Image(touch.target), TouchPhase.HOVER))
			{
				showTips.showTips();
				showTips.info = "Your Advisor : "+Config.Adviser[Image(touch.target).name];
			}			
			else
			{
				showTips.hideTips();
			}
		}
		
		public function setup():void 
		{
			selectedLogo.x = getChildByName(Data.logo).x - 5;
			selectedAdvisor.x = getChildByName(Data.advisor).x - 6.7;
			
			logoCheck.x = getChildByName(Data.logo).x + getChildByName(Data.logo).width * 0.5 - logoCheck.width * 0.5;
			advisorCheck.x = getChildByName(Data.advisor).x + getChildByName(Data.advisor).width * 0.5 - logoCheck.width * 0.5;			
		}
		
		public function isCompleted():Boolean
		{
			if(inputName.text.length == 0 || inputMotivation.text.length == 0 || inputRestaurantName.text.length == 0){
				return false;
			}
			return true;
		}
				
		public function update():void
		{
			showTips.update();
			
			Data.avatarName = inputName.text;
			Data.motivation = inputMotivation.text;
			Data.shop = inputRestaurantName.text;
		}
		
		public function destroy():void
		{			
			avatarControl.removeFromParent(false);
			showTips.removeFromParent(true);
			removeFromParent(true);
		}
	}
}