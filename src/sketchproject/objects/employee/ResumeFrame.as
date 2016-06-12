package sketchproject.objects.employee
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	
	import feathers.controls.TextInput;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import flash.events.Event;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.RewardManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.EmployeeAdapter;
	import sketchproject.objects.dialog.NativeDialog;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.utils.deg2rad;
	
	public class ResumeFrame extends Sprite
	{
		private var background:Image;
		private var candidateAvatar:Image;
		private var select:Image;
		private var status:Image;
		private var buttonOffer:Button;
		private var offerSallary:TextInput;
		
		private var label:TextField;		
		private var profile:TextField;
		private var career:TextField;
		private var education:TextField;
		private var experience:TextField;
		private var statusInfo:TextField;
		private var noCandidateLabel:TextField;
		
		private var employeeList:Sprite;
				
		private var dialogConfirm:NativeDialog;
		private var dialogInfo:NativeDialog;
		
		private var fireworkManager:FireworkManager;
		
		private var currentCandidate:EmployeeAdapter;		
		private var server:Object;
		private var gemManager:RewardManager;
		
		public function ResumeFrame()
		{
			super();
			new MetalWorksDesktopTheme();
			
			gemManager = new RewardManager(RewardManager.REWARD_GEM, RewardManager.SPAWN_AVERAGE);
			
			fireworkManager = FireworkManager.getInstance(Game.overlayStage);
			
			background = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("paper"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;	
			background.y = -45;
			addChild(background);
			
			label = new TextField(100, 50, "Candidate", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -330;
			label.y = -175;
			addChild(label);
			
			select = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("employee_select"));
			select.pivotX = select.width * 0.5;
			select.pivotY = select.height * 0.5;	
			select.x = -255;
			select.y = -115;
			addChild(select);
			
			employeeList = new Sprite();
			employeeList.x = -320;
			employeeList.y = -150;
			addChild(employeeList);
			
			noCandidateLabel = new TextField(100, 50, "No Candidate", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x888888);
			noCandidateLabel.hAlign = HAlign.LEFT;
			noCandidateLabel.vAlign = VAlign.TOP;
			noCandidateLabel.x = -330;
			noCandidateLabel.y = -145;
			addChild(noCandidateLabel);
			
			candidateAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_reza_radhian"));
			candidateAvatar.pivotX = candidateAvatar.width * 0.5;
			candidateAvatar.pivotY = candidateAvatar.height * 0.5;	
			candidateAvatar.x = -85;
			candidateAvatar.y = -30;
			addChild(candidateAvatar);
			
			status = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("sign_employed"));
			status.pivotX = candidateAvatar.width * 0.5;
			status.pivotY = candidateAvatar.height * 0.5;	
			status.x = -20;
			status.y = 150;
			status.rotation = deg2rad(-30);
			addChild(status);
			
			label = new TextField(150, 50, "Curicullum Vitae", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -175;
			addChild(label);
			
			label = new TextField(100, 50, "Profile", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -140;
			addChild(label);
			
			profile = new TextField(150, 70, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			profile.hAlign = HAlign.LEFT;
			profile.vAlign = VAlign.TOP;
			profile.x = 5;
			profile.y = -120;
			addChild(profile);
			
			label = new TextField(100, 50, "Career Goal", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -75;
			addChild(label);
			
			career = new TextField(150, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			career.hAlign = HAlign.LEFT;
			career.vAlign = VAlign.TOP;
			career.x = 5;
			career.y = -55;
			addChild(career);
			
			label = new TextField(100, 50, "Education", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -15;
			addChild(label);
			
			education = new TextField(150, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			education.hAlign = HAlign.LEFT;
			education.vAlign = VAlign.TOP;
			education.x = 5;
			education.y = 5;
			addChild(education);
			
			label = new TextField(100, 50, "Experience", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = 30;
			addChild(label);
			
			experience = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			experience.hAlign = HAlign.LEFT;
			experience.vAlign = VAlign.TOP;
			experience.x = 5;
			experience.y = 50;
			addChild(experience);
			
			label = new TextField(100, 50, "Salary Offer", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -175;
			addChild(label);
			
			label = new TextField(100, 50, "Salary / Day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -140;
			addChild(label);
			
			offerSallary = new TextInput();
			offerSallary.prompt = "Put Salary / day here";
			offerSallary.width = 165;
			offerSallary.height = 30;
			offerSallary.x = 190;
			offerSallary.y = -110;			
			offerSallary.text = "25000";
			addChild(offerSallary);	
			
			buttonOffer = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_make_offer"));
			buttonOffer.pivotX = buttonOffer.width * 0.5;
			buttonOffer.pivotY = buttonOffer.height * 0.5;
			buttonOffer.x = 275;
			buttonOffer.y = -40;
			addChild(buttonOffer);
			
			label = new TextField(100, 50, "Status", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -10;
			addChild(label);
			
			statusInfo = new TextField(200, 50, "Candidate has employed", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			statusInfo.hAlign = HAlign.LEFT;
			statusInfo.vAlign = VAlign.TOP;
			statusInfo.x = 190;
			statusInfo.y = 10;
			addChild(statusInfo);
			
			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Hiring Confirm", "Do you want to hiring employee?");
			dialogConfirm.x = Starling.current.stage.stageWidth * 0.5;
			dialogConfirm.y = Starling.current.stage.stageHeight * 0.5;
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, onHiredConfirm);
			Game.overlayStage.addChild(dialogConfirm);
			
			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION, "Hiring Failed", "Employee reject your request");
			dialogInfo.x = Starling.current.stage.stageWidth * 0.5;
			dialogInfo.y = Starling.current.stage.stageHeight * 0.5;
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, onInfoShow);
			Game.overlayStage.addChild(dialogInfo);
			
			buttonOffer.addEventListener(starling.events.Event.TRIGGERED, onSallaryOffered);
			
			updateResumes();			
			avatarAnimation();
		}
		
		private function avatarAnimation():void{
			TweenMax.to(
				candidateAvatar, 
				0.5, 
				{
					scaleX:(candidateAvatar.scaleX==1)?0.9:1, 
					scaleY:(candidateAvatar.scaleX==1)?0.9:1, 
					ease:(candidateAvatar.scaleX==1)?Cubic.easeOut:Cubic.easeIn, 
					onComplete:function():void{
						avatarAnimation();
					}
				}
			);
		}
		
		private function onSallaryOffered(event:starling.events.Event):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			if(int(offerSallary.text) <= 0 || offerSallary.text.length == 0){
				dialogInfo.dialogTitle = "Hired Failed";
				dialogInfo.dialogMessage = "Complete your sallary";
				dialogInfo.openDialog();
			}
			else{
				dialogConfirm.openDialog();
			}		
		}
		
		private function onInfoShow(event:DialogBoxEvent):void
		{
			dialogInfo.closeDialog();
		}
		
		private function onHiredConfirm(event:DialogBoxEvent):void
		{
			if(event.result) 
			{
				if(currentCandidate.offer(int(offerSallary.text)))
				{	
					Game.loadingScreen.show();
					
					var gameObject:Object 			= new Object();
					gameObject.token 				= Data.key;
					gameObject.employee_id 			= currentCandidate.employeeId;
					gameObject.employee_salary 		= int(offerSallary.text);
					
					server = new ServerManager("employee/hire_employee",gameObject);
					server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void{
						Game.loadingScreen.hide();
						
						var employee:String 		= server.received.employee_var;
						
						if(JSON.parse(employee) as Array != null)		
							Data.employee = JSON.parse(employee) as Array;
						
						Config.candidate[currentCandidate.employeeIndex].emp_status = "hired";
						Config.candidate[currentCandidate.employeeIndex][7] = "hired";
						
						dialogInfo.dialogTitle = "Hired Success";
						dialogInfo.dialogMessage = "Employee ready to work";
						dialogInfo.openDialog();
						
						setCurrentEmployee();
						
						gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40,1000);
					});
					server.sendRequest();
				}
				else
				{
					dialogInfo.dialogTitle = "Hired Failed";
					dialogInfo.dialogMessage = "Employee reject your request";		
					dialogInfo.openDialog();
				}				
			}
			dialogConfirm.closeDialog();			
		}
		
		public function updateResumes():void
		{
			employeeList.removeChildren();
			
			for(var i:int = 0; i<Config.candidate.length; i++){
				var candidate:EmployeeAdapter = new EmployeeAdapter(i, Config.candidate[i].emp_id, Config.candidate[i].emp_name);
				candidate.y = i * 30;
				employeeList.addChild(candidate);
				candidate.addEventListener(TouchEvent.TOUCH, onCandidateSelected);
			}
			
			if(employeeList.numChildren>0){
				select.visible = true;
				buttonOffer.enabled = true;
				noCandidateLabel.visible = false;
				status.visible = true;
				select.y = employeeList.getChildAt(0).y + employeeList.y + 28;
				currentCandidate = EmployeeAdapter(employeeList.getChildAt(0));
				setCurrentEmployee();
			}	
			else{
				select.visible = false;
				buttonOffer.enabled = false;
				noCandidateLabel.visible = true;
				status.visible = false;
				currentCandidate = null;
				candidateAvatar.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("no_employee");
				candidateAvatar.readjustSize();
				profile.text = "-";
				career.text = "-";
				education.text = "-";
				experience.text = "-";
			}
		}
		
		private function onCandidateSelected(touch:TouchEvent):void
		{
			if(touch.getTouch(EmployeeAdapter(touch.currentTarget),TouchPhase.ENDED)){
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
				currentCandidate = EmployeeAdapter(touch.currentTarget);
				fireworkManager.spawn(candidateAvatar.x + Starling.current.stage.stageWidth * 0.5, candidateAvatar.y + Starling.current.stage.stageHeight * 0.5);
				setCurrentEmployee();				
			}
		}
		
		private function setCurrentEmployee():void{
			TweenMax.to(select,0.3,{y:currentCandidate.y + employeeList.y + 27});
			
			candidateAvatar.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture(Config.candidate[currentCandidate.employeeIndex].emp_atlas);
			candidateAvatar.readjustSize();
						
			profile.text = Config.candidate[currentCandidate.employeeIndex].emp_profile
			career.text = Config.candidate[currentCandidate.employeeIndex].emp_salary_goal;
			education.text = Config.candidate[currentCandidate.employeeIndex].emp_education;
			experience.text = Config.candidate[currentCandidate.employeeIndex].emp_experience
			
			if(Config.candidate[currentCandidate.employeeIndex].emp_status == "hired"){			
				status.visible = true;
				buttonOffer.enabled = false;
				statusInfo.text = "Candidate has employed";				
			}
			else{
				status.visible = false;
				buttonOffer.enabled = true;
				statusInfo.text = "Candidate ready to employed";
			}			
		}
	}
}