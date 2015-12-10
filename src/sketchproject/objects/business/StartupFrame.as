package sketchproject.objects.business
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.DataManager;
	import sketchproject.objects.dialog.StartupDialog;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class StartupFrame extends Sprite
	{
		private var buttonBusinessPlan:Button;
		private var buttonPersonalObjective:Button;
		private var buttonGameParameter:Button;
		private var buttonSeedFinancing:Button;
		
		private var characterBackground:Image;
		
		private var label:TextField;
		
		private var startupBusinessPlan:StartupDialog;
		private var startupPersonalObjective:StartupDialog;
		private var startupFinance:StartupDialog;
		private var startupParameter:StartupDialog;
		
		private var buttonAddGinger:Button;
		private var buttonSubstractGinger:Button;
		private var buttonAddJasmine:Button;
		private var buttonSubstractJasmine:Button;
		private var buttonAddRosemary:Button;
		private var buttonSubstractRosemary:Button;
		
		private var buttonAddModern:Button;
		private var buttonSubstractModern:Button;
		private var buttonAddColorful:Button;
		private var buttonSubstractColorful:Button;
		private var buttonAddVintage:Button;
		private var buttonSubstractVintage:Button;
		
		private var buttonAddProduct:Button;
		private var buttonSubstractProduct:Button;
		private var buttonAddPlace:Button;
		private var buttonSubstractPlace:Button;
		
		private var attributeContainer:Sprite;
		private var strip:DisplayObject;
		private var save:DataManager;
		
		
		public function StartupFrame()
		{
			super();
			
			save = new DataManager();
			
			label = new TextField(250, 50, "Startup", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -430;
			label.y = -200;
			addChild(label);
			
			startupBusinessPlan = new StartupDialog(StartupDialog.STARTUP_BUSINESS);
			startupBusinessPlan.x = Starling.current.stage.stageWidth * 0.5;
			startupBusinessPlan.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(startupBusinessPlan);
			
			startupPersonalObjective = new StartupDialog(StartupDialog.STARTUP_OBJECTIVE);
			startupPersonalObjective.x = Starling.current.stage.stageWidth * 0.5;
			startupPersonalObjective.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(startupPersonalObjective);
			
			startupFinance = new StartupDialog(StartupDialog.STARTUP_FINANCE);
			startupFinance.x = Starling.current.stage.stageWidth * 0.5;
			startupFinance.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(startupFinance);
			
			startupParameter = new StartupDialog(StartupDialog.STARTUP_PARAMETER);
			startupParameter.x = Starling.current.stage.stageWidth * 0.5;
			startupParameter.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(startupParameter);
			
			
			buttonBusinessPlan = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_startup_business_plan"));
			buttonBusinessPlan.pivotX = buttonBusinessPlan.width * 0.5;
			buttonBusinessPlan.pivotY = buttonBusinessPlan.height * 0.5;
			buttonBusinessPlan.x = -370;
			buttonBusinessPlan.y = -100;
			addChild(buttonBusinessPlan);
			
			buttonPersonalObjective = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_startup_personal_objective"));
			buttonPersonalObjective.pivotX = buttonPersonalObjective.width * 0.5;
			buttonPersonalObjective.pivotY = buttonPersonalObjective.height * 0.5;
			buttonPersonalObjective.x = -225;
			buttonPersonalObjective.y = -100;
			addChild(buttonPersonalObjective);
			
			buttonGameParameter = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_startup_game_parameter"));
			buttonGameParameter.pivotX = buttonGameParameter.width * 0.5;
			buttonGameParameter.pivotY = buttonGameParameter.height * 0.5;
			buttonGameParameter.x = -370;
			buttonGameParameter.y = 30;
			addChild(buttonGameParameter);
			
			buttonSeedFinancing = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_startup_seed_financing"));
			buttonSeedFinancing.pivotX = buttonSeedFinancing.width * 0.5;
			buttonSeedFinancing.pivotY = buttonSeedFinancing.height * 0.5;
			buttonSeedFinancing.x = -225;
			buttonSeedFinancing.y = 30;
			addChild(buttonSeedFinancing);
						
			
			label = new TextField(250, 50, "Decoration", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -130;
			label.y = -200;
			//addChild(label);
			
			label = new TextField(250, 50, "Decoration Item", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -130;
			label.y = -210;
			//addChild(label);
			
			label = new TextField(250, 50, "Modern", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = -180;
			addChild(label);
			
			buttonAddModern = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddModern.pivotX = buttonAddModern.width * 0.5;
			buttonAddModern.pivotY = buttonAddModern.height * 0.5;
			buttonAddModern.x = 200;
			buttonAddModern.y = -170;
			buttonAddModern.scaleX = 0.7;
			buttonAddModern.scaleY = 0.7;
			addChild(buttonAddModern);
			
			buttonSubstractModern = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractModern.pivotX = buttonSubstractModern.width * 0.5;
			buttonSubstractModern.pivotY = buttonSubstractModern.height * 0.5;
			buttonSubstractModern.x = 20;
			buttonSubstractModern.y = -170;
			buttonSubstractModern.scaleX = 0.7;
			buttonSubstractModern.scaleY = 0.7;
			addChild(buttonSubstractModern);
			
			label = new TextField(250, 50, "Colorful", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = -150;
			addChild(label);
			
			buttonAddColorful = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddColorful.pivotX = buttonAddColorful.width * 0.5;
			buttonAddColorful.pivotY = buttonAddColorful.height * 0.5;
			buttonAddColorful.x = 200;
			buttonAddColorful.y = -140;
			buttonAddColorful.scaleX = 0.7;
			buttonAddColorful.scaleY = 0.7;
			addChild(buttonAddColorful);
			
			buttonSubstractColorful = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractColorful.pivotX = buttonSubstractColorful.width * 0.5;
			buttonSubstractColorful.pivotY = buttonSubstractColorful.height * 0.5;
			buttonSubstractColorful.x = 20;
			buttonSubstractColorful.y = -140;
			buttonSubstractColorful.scaleX = 0.7;
			buttonSubstractColorful.scaleY = 0.7;
			addChild(buttonSubstractColorful);
			
			label = new TextField(250, 50, "Vintage", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = -120;
			addChild(label);
			
			buttonAddVintage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddVintage.pivotX = buttonAddVintage.width * 0.5;
			buttonAddVintage.pivotY = buttonAddVintage.height * 0.5;
			buttonAddVintage.x = 200;
			buttonAddVintage.y = -110;
			buttonAddVintage.scaleX = 0.7;
			buttonAddVintage.scaleY = 0.7;
			addChild(buttonAddVintage);
			
			buttonSubstractVintage = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractVintage.pivotX = buttonSubstractVintage.width * 0.5;
			buttonSubstractVintage.pivotY = buttonSubstractVintage.height * 0.5;
			buttonSubstractVintage.x = 20;
			buttonSubstractVintage.y = -110;
			buttonSubstractVintage.scaleX = 0.7;
			buttonSubstractVintage.scaleY = 0.7;
			addChild(buttonSubstractVintage);
			
			label = new TextField(250, 50, "Scent", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -130;
			label.y = -85;
			//addChild(label);
			
			label = new TextField(250, 50, "Scent Item", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -130;
			label.y = -95;
			//addChild(label);
			
			label = new TextField(250, 50, "Ginger", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = -65;
			addChild(label);
			
			buttonAddGinger = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddGinger.pivotX = buttonAddGinger.width * 0.5;
			buttonAddGinger.pivotY = buttonAddGinger.height * 0.5;
			buttonAddGinger.x = 200;
			buttonAddGinger.y = -55;
			buttonAddGinger.scaleX = 0.7;
			buttonAddGinger.scaleY = 0.7;
			addChild(buttonAddGinger);
			
			buttonSubstractGinger = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractGinger.pivotX = buttonSubstractGinger.width * 0.5;
			buttonSubstractGinger.pivotY = buttonSubstractGinger.height * 0.5;
			buttonSubstractGinger.x = 20;
			buttonSubstractGinger.y = -55;
			buttonSubstractGinger.scaleX = 0.7;
			buttonSubstractGinger.scaleY = 0.7;
			addChild(buttonSubstractGinger);
			
			label = new TextField(250, 50, "Jasmine", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = -35;
			addChild(label);
			
			buttonAddJasmine = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddJasmine.pivotX = buttonAddJasmine.width * 0.5;
			buttonAddJasmine.pivotY = buttonAddJasmine.height * 0.5;
			buttonAddJasmine.x = 200;
			buttonAddJasmine.y = -25;
			buttonAddJasmine.scaleX = 0.7;
			buttonAddJasmine.scaleY = 0.7;
			addChild(buttonAddJasmine);
			
			buttonSubstractJasmine = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractJasmine.pivotX = buttonSubstractJasmine.width * 0.5;
			buttonSubstractJasmine.pivotY = buttonSubstractJasmine.height * 0.5;
			buttonSubstractJasmine.x = 20;
			buttonSubstractJasmine.y = -25;
			buttonSubstractJasmine.scaleX = 0.7;
			buttonSubstractJasmine.scaleY = 0.7;
			addChild(buttonSubstractJasmine);
			
			label = new TextField(250, 50, "Rosemary", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = -5;
			addChild(label);
			
			buttonAddRosemary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddRosemary.pivotX = buttonAddRosemary.width * 0.5;
			buttonAddRosemary.pivotY = buttonAddRosemary.height * 0.5;
			buttonAddRosemary.x = 200;
			buttonAddRosemary.y = 5;
			buttonAddRosemary.scaleX = 0.7;
			buttonAddRosemary.scaleY = 0.7;
			addChild(buttonAddRosemary);
			
			buttonSubstractRosemary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractRosemary.pivotX = buttonSubstractRosemary.width * 0.5;
			buttonSubstractRosemary.pivotY = buttonSubstractRosemary.height * 0.5;
			buttonSubstractRosemary.x = 20;
			buttonSubstractRosemary.y = 5;
			buttonSubstractRosemary.scaleX = 0.7;
			buttonSubstractRosemary.scaleY = 0.7;
			addChild(buttonSubstractRosemary);
			
			label = new TextField(250, 50, "Cleaness", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -130;
			label.y = 30;
			//addChild(label);
			
			label = new TextField(250, 50, "Cleaness Item", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -130;
			label.y = 20;
			//addChild(label);
						
			label = new TextField(250, 50, "Product", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = 50;
			addChild(label);
			
			buttonAddProduct = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddProduct.pivotX = buttonAddProduct.width * 0.5;
			buttonAddProduct.pivotY = buttonAddProduct.height * 0.5;
			buttonAddProduct.x = 200;
			buttonAddProduct.y = 60;
			buttonAddProduct.scaleX = 0.7;
			buttonAddProduct.scaleY = 0.7;
			addChild(buttonAddProduct);
			
			buttonSubstractProduct = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractProduct.pivotX = buttonSubstractProduct.width * 0.5;
			buttonSubstractProduct.pivotY = buttonSubstractProduct.height * 0.5;
			buttonSubstractProduct.x = 20;
			buttonSubstractProduct.y = 60;
			buttonSubstractProduct.scaleX = 0.7;
			buttonSubstractProduct.scaleY = 0.7;
			addChild(buttonSubstractProduct);
			
			label = new TextField(250, 50, "Place", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -110;
			label.y = 80;
			addChild(label);
			
			buttonAddPlace = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			buttonAddPlace.pivotX = buttonAddPlace.width * 0.5;
			buttonAddPlace.pivotY = buttonAddPlace.height * 0.5;
			buttonAddPlace.x = 200;
			buttonAddPlace.y = 90;
			buttonAddPlace.scaleX = 0.7;
			buttonAddPlace.scaleY = 0.7;
			addChild(buttonAddPlace);
			
			buttonSubstractPlace = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			buttonSubstractPlace.pivotX = buttonSubstractPlace.width * 0.5;
			buttonSubstractPlace.pivotY = buttonSubstractPlace.height * 0.5;
			buttonSubstractPlace.x = 20;
			buttonSubstractPlace.y = 90;
			buttonSubstractPlace.scaleX = 0.7;
			buttonSubstractPlace.scaleY = 0.7;
			addChild(buttonSubstractPlace);
						
			attributeContainer = new Sprite();
			attributeContainer.x = 35;
			attributeContainer.y = -180;
			attributeContainer.scaleX = 0.85;
			attributeContainer.scaleY = 0.73;
			addChild(attributeContainer);
			
			characterBackground = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("advisor_fitri_aisyah"));
			characterBackground.x = 280;
			characterBackground.y = -200;
			addChild(characterBackground);
			
			addEventListener(TouchEvent.TOUCH, onStartupTouched);
			
			updateAttribute();
		}
		
		private function onStartupTouched(touch:TouchEvent):void
		{
			if(touch.getTouch(buttonBusinessPlan, TouchPhase.ENDED)){
				startupBusinessPlan.openDialog();
			}
			
			if(touch.getTouch(buttonPersonalObjective, TouchPhase.ENDED)){
				startupPersonalObjective.openDialog();
			}
			
			if(touch.getTouch(buttonSeedFinancing, TouchPhase.ENDED)){
				startupFinance.openDialog();
			}
			
			if(touch.getTouch(buttonGameParameter, TouchPhase.ENDED)){
				startupParameter.openDialog();
			}
			
			
			
			if(touch.getTouch(buttonAddModern, TouchPhase.ENDED)){
				if(Data.decoration[0] < 10){
					Data.decoration[0]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractModern, TouchPhase.ENDED)){
				if(Data.decoration[0] > 0){
					Data.decoration[0]--;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonAddColorful, TouchPhase.ENDED)){
				if(Data.decoration[1] < 10){
					Data.decoration[1]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractColorful, TouchPhase.ENDED)){
				if(Data.decoration[1] > 0){
					Data.decoration[1]--;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonAddVintage, TouchPhase.ENDED)){
				if(Data.decoration[2] < 10){
					Data.decoration[2]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractVintage, TouchPhase.ENDED)){
				if(Data.decoration[2] > 0){
					Data.decoration[2]--;
					updateAttribute();
				}
			}
			
			if(touch.getTouch(buttonAddGinger, TouchPhase.ENDED)){
				if(Data.scent[0] < 10){
					Data.scent[0]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractGinger, TouchPhase.ENDED)){
				if(Data.scent[0] > 0){
					Data.scent[0]--;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonAddJasmine, TouchPhase.ENDED)){
				if(Data.scent[1] < 10){
					Data.scent[1]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractJasmine, TouchPhase.ENDED)){
				if(Data.scent[1] > 0){
					Data.scent[1]--;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonAddRosemary, TouchPhase.ENDED)){
				if(Data.scent[2] < 10){
					Data.scent[2]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractRosemary, TouchPhase.ENDED)){
				if(Data.scent[2] > 0){
					Data.scent[2]--;
					updateAttribute();
				}
			}
			
			if(touch.getTouch(buttonAddProduct, TouchPhase.ENDED)){
				if(Data.cleanness[0] < 10){
					Data.cleanness[0]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractProduct, TouchPhase.ENDED)){
				if(Data.cleanness[0] > 0){
					Data.cleanness[0]--;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonAddPlace, TouchPhase.ENDED)){
				if(Data.cleanness[1] < 10){
					Data.cleanness[1]++;
					updateAttribute();
				}
			}
			if(touch.getTouch(buttonSubstractPlace, TouchPhase.ENDED)){
				if(Data.cleanness[1] > 0){
					Data.cleanness[1]--;
					updateAttribute();
				}
			}
			
		}
		
		public function updateAttribute():void{
			attributeContainer.removeChildren();
			for(var i:int=0; i<10;i++){				
				if(i<Data.decoration[0]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				attributeContainer.addChild(strip);
				
				if(i<Data.decoration[1]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 40;
				attributeContainer.addChild(strip);
				
				if(i<Data.decoration[2]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 80;
				attributeContainer.addChild(strip);
				
				if(i<Data.scent[0]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 157;
				attributeContainer.addChild(strip);
				
				if(i<Data.scent[1]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 197;
				attributeContainer.addChild(strip);
				
				if(i<Data.scent[2]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 237;
				attributeContainer.addChild(strip);
				
				if(i<Data.cleanness[0]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 315;
				attributeContainer.addChild(strip);
				
				if(i<Data.cleanness[1]){
					strip = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("progress_option"));				
				}
				else {
					strip = new Quad(14,29,0xCCCCCC);
				}
				strip.x = (i * (strip.width + 4));
				strip.y = 355;
				attributeContainer.addChild(strip);
			}
			
			save.saveGameData();
		}
	}
}