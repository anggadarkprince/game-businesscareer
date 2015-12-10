package sketchproject.screens
{
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.objects.world.GameMenu;
	import sketchproject.objects.employee.EmployeeFrame;
	import sketchproject.objects.employee.ProgramFrame;
	import sketchproject.objects.employee.ResumeFrame;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class EmployeeScreen extends GameScreen
	{
		private var resume:ResumeFrame;
		private var employee:EmployeeFrame;
		private var program:ProgramFrame;
		
		private var buttonResumes:Button;
		private var buttonEmployees:Button;
		private var buttonPrograms:Button;
		
		private var hud:GameMenu;
		
		public function EmployeeScreen(hud:GameMenu)
		{
			super();
			
			this.hud = hud;
			
			resume = new ResumeFrame();
			addChild(resume);
			
			employee = new EmployeeFrame();
			addChild(employee);
			
			program = new ProgramFrame();
			addChild(program);
						
			buttonResumes = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_employee_resumes"));
			buttonResumes.pivotX = buttonResumes.width * 0.5;
			buttonResumes.pivotY = buttonResumes.height;	
			buttonResumes.addEventListener(Event.TRIGGERED, onResumeTriggered);
			buttonContainer.addChild(buttonResumes);
			
			buttonEmployees = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_employee_employees"));
			buttonEmployees.pivotX = buttonEmployees.width * 0.5;
			buttonEmployees.pivotY = buttonEmployees.height;
			buttonEmployees.x = 150;
			buttonEmployees.addEventListener(Event.TRIGGERED, onEmployeeTriggered);
			buttonContainer.addChild(buttonEmployees);
			
			buttonPrograms = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_employee_programs"));
			buttonPrograms.pivotX = buttonPrograms.width * 0.5;
			buttonPrograms.pivotY = buttonPrograms.height;
			buttonPrograms.x = 300;
			buttonPrograms.addEventListener(Event.TRIGGERED, onProgramTriggered);
			buttonContainer.addChild(buttonPrograms);
			
			buttonContainer.x = Starling.current.stage.stageWidth * 0.5 - buttonContainer.width * 0.5 + buttonResumes.width * 0.5;
			buttonContainer.y = 460;
			buttonContainer.visible = false;			
			hud.containerDashboard.addChild(buttonContainer);
			
			switchPage(resume);
			
		}
		
		private function onResumeTriggered(event:Event):void
		{
			switchPage(resume);
			resume.updateResumes();
			Assets.sfxChannel = Assets.sfxResumesList.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function onEmployeeTriggered():void
		{
			switchPage(employee);
			employee.updateEmployee();
			Assets.sfxChannel = Assets.sfxEmployeeList.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function onProgramTriggered():void
		{
			switchPage(program);
			program.updateProgram();
			Assets.sfxChannel = Assets.sfxEmployeeProgram.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}
		
		private function switchPage(page:Sprite):void
		{			
			resume.visible = false;
			employee.visible = false;
			program.visible = false;
			
			page.visible = true;
		}
		
	}	
	
}