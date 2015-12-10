package sketchproject.objects.employee
{
	import feathers.controls.Check;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.DataManager;
	import sketchproject.managers.FireworkParticleManager;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ProgramFrame extends Sprite
	{
		private var background:Image;
		private var buttonOffer:Button;
		private var label:TextField;
		private var fireworkManager:FireworkParticleManager;
		
		private var baseAmount:TextField;
		private var costEmployee:TextField;
		private var costPerMonth:TextField;
		private var totalCost:TextField;
		
		private var performance:Check;
		private var career:Check;
		private var policies:Check;
		private var personalization:Check;
		private var management:Check;
		
		private var health:Check;
		private var education:Check;
		private var finance:Check;
		private var practice:Check;
		
		private var programList:Array;
				
		private var server:DataManager;
		
		public function ProgramFrame()
		{
			super();
			
			new MetalWorksDesktopTheme();
			
			server = new DataManager();
			
			programList = new Array();
						
			fireworkManager = FireworkParticleManager.getInstance(Game.overlayStage);
			
			background = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("paper"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;	
			background.y = -45;
			addChild(background);
			
			background = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_franda_stefanus"));
			background.x = -320
			background.y = -195;
			addChild(background);
			
			background = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_david_kurnia"));
			background.x = -430
			background.y = -200;
			addChild(background);
			
			label = new TextField(100, 50, "Incentive", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -170;
			addChild(label);
			
			label = new TextField(250, 50, "Boost and motivate your employees and improve productivity", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -145;
			addChild(label);
			
			label = new TextField(250, 50, "Performance & reward programs", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -100;
			addChild(label);
			
			performance = new Check();
			performance.x = 60;
			performance.y = -100;
			performance.name = "performance";
			programList.push(performance);
			performance.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(performance);
			
			label = new TextField(250, 50, "Career & promotion", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -80;
			addChild(label);
			
			career = new Check();
			career.x = 60;
			career.y = -80;
			career.name = "career";
			programList.push(career);
			career.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(career);
			
			label = new TextField(250, 50, "Cultural Diversity Policies", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -60;
			addChild(label);
			
			policies = new Check();
			policies.x = 60;
			policies.y = -60;
			policies.name = "policies";
			programList.push(policies);
			policies.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(policies);
			
			label = new TextField(250, 50, "Personalization", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -40;
			addChild(label);
			
			personalization = new Check();
			personalization.x = 60;
			personalization.y = -40;
			personalization.name = "personalization";
			programList.push(personalization);
			personalization.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(personalization);
			
			label = new TextField(250, 50, "Management & Communication", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = -20;
			addChild(label);
			
			management = new Check();
			management.x = 60;
			management.y = -20;
			management.name = "management";
			programList.push(management);
			management.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(management);
			
			label = new TextField(250, 50, "Total Incentive & Benefit per day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -150;
			label.y = 30;
			addChild(label);
			
			totalCost = new TextField(230, 50, "IDR 500000", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 20, 0x333333);
			totalCost.hAlign = HAlign.RIGHT;
			totalCost.vAlign = VAlign.TOP;
			totalCost.x = -150;
			totalCost.y = 50;
			addChild(totalCost);
			
			label = new TextField(100, 50, "Benefits", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = -170;
			addChild(label);
			
			label = new TextField(250, 50, "Basic benefit include medical and insurance their family to improve morale", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = -145;
			addChild(label);
			
			label = new TextField(250, 50, "Health & Insurance", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = -100;
			addChild(label);
			
			health = new Check();
			health.x = 350;
			health.y = -100;
			health.name = "health";
			programList.push(health);
			health.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(health);
			
			label = new TextField(250, 50, "Education Support", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = -80;
			addChild(label);
			
			education = new Check();
			education.x = 350;
			education.y = -80;
			education.name = "education";
			programList.push(education);
			education.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(education);
			
			label = new TextField(250, 50, "Additional Reward", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = -60;
			addChild(label);
			
			finance = new Check();
			finance.x = 350;
			finance.y = -60;
			finance.name = "finance";
			programList.push(finance);
			finance.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(finance);
			
			label = new TextField(250, 50, "Company practice", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = -40;
			addChild(label);
			
			practice = new Check();
			practice.x = 350;
			practice.y = -40;
			practice.name = "practice";
			programList.push(practice);
			practice.addEventListener(starling.events.Event.CHANGE, onProgramChanged);
			addChild(practice);
			
			label = new TextField(250, 50, "Base Amount", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = 0;
			addChild(label);
			
			baseAmount = new TextField(220, 50, "IDR 100000", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			baseAmount.hAlign = HAlign.RIGHT;
			baseAmount.vAlign = VAlign.TOP;
			baseAmount.x = 150;
			baseAmount.y = 0;
			addChild(baseAmount);
			
			label = new TextField(250, 50, "Cost per employee", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = 20;
			addChild(label);
			
			costEmployee = new TextField(220, 50, "IDR 100000", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			costEmployee.hAlign = HAlign.RIGHT;
			costEmployee.vAlign = VAlign.TOP;
			costEmployee.x = 150;
			costEmployee.y = 20;
			addChild(costEmployee);
			
			label = new TextField(250, 50, "Total cost per month", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 130;
			label.y = 40;
			addChild(label);
			
			costPerMonth = new TextField(220, 50, "IDR 100000", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			costPerMonth.hAlign = HAlign.RIGHT;
			costPerMonth.vAlign = VAlign.TOP;
			costPerMonth.x = 150;
			costPerMonth.y = 40;
			addChild(costPerMonth);
			
			updateProgram();
		}
		
		private function onProgramChanged(event:starling.events.Event):void
		{			
			switch(Check(event.target).name){
				case "performance":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(performance.isSelected){
						Data.programCost += 1000;
						Data.program[0] = 1;
					}
					else{
						Data.programCost -= 1000;
						Data.program[0] = 0;
					}
					break;
				case "career":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(career.isSelected){
						Data.programCost += 1200;
						Data.program[1] = 1;
					}
					else{
						Data.programCost -= 1200;
						Data.program[1] = 0;
					}
					break;
				case "policies":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(policies.isSelected){
						Data.programCost += 1500;
						Data.program[2] = 1;
					}
					else{
						Data.programCost -= 1500;
						Data.program[2] = 0;
					}
					break;
				case "personalization":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(personalization.isSelected){
						Data.programCost += 500;
						Data.program[3] = 1;
					}
					else{
						Data.programCost -= 500;
						Data.program[3] = 0;
					}
					break;
				case "management":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(management.isSelected){
						Data.programCost += 1200;
						Data.program[4] = 1;
					}
					else{
						Data.programCost -= 1200;
						Data.program[4] = 0;
					}
					break;
				
				case "health":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(health.isSelected){
						Data.programCost += 1100;
						Data.program[5] = 1;
					}
					else{
						Data.programCost -= 1100;
						Data.program[5] = 0;
					}
					break;
				case "education":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(education.isSelected){
						Data.programCost += 1600;
						Data.program[6] = 1;
					}
					else{
						Data.programCost -= 1600;
						Data.program[6] = 0;
					}
					break;
				case "finance":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(finance.isSelected){
						Data.programCost += 1700;
						Data.program[7] = 1;
					}
					else{
						Data.programCost -= 1700;
						Data.program[7] = 0;
					}
					break;
				case "practice":
					//Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
					if(practice.isSelected){
						Data.programCost += 700;
						Data.program[8] = 1;
					}
					else{
						Data.programCost -= 700;
						Data.program[8] = 0;
					}
					break;
			}
			updateCost();
		}
		
		public function updateProgram():void{
			for(var i:int = 0; i < Data.program.length; i++){
				if(Data.program[i]){
					Check(programList[i]).isSelected = true;
				}
				else{
					Check(programList[i]).isSelected = false;
				}
			}
			updateCost();
		}
						
		public function updateCost():void{
			baseAmount.text = "IDR "+ValueFormatter.format(10000);
			costEmployee.text = "IDR "+ValueFormatter.format(Data.programCost*Data.employee.length);
			costPerMonth.text = "IDR "+ValueFormatter.format(Data.programCost*Data.employee.length*30+int(baseAmount.text));
			totalCost.text = "IDR "+ValueFormatter.format(Data.programCost*Data.employee.length+10000);
			
			server.saveGameData();
		}
	}
}