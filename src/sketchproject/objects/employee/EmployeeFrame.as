package sketchproject.objects.employee
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	
	import flash.events.Event;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.DataManager;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.EmployeeAdapter;
	import sketchproject.objects.dialog.EmployeeTrainingDialog;
	import sketchproject.objects.dialog.NativeDialog;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Employee has been hiring.
	 * 
	 * @author Angga
	 */
	public class EmployeeFrame extends Sprite
	{
		private var background:Image;
		private var employeeAvatar:Image;
		private var select:Image;
		private var buttonDismiss:Button;
		private var buttonTrain:Button;

		private var label:TextField;
		private var noEmployeeLabel:TextField;
		private var profile:TextField;
		private var career:TextField;
		private var education:TextField;
		private var experience:TextField;

		private var hired:TextField;
		private var salary:TextField;
		private var morale:TextField;
		private var services:TextField;
		private var productivity:TextField;

		private var late:TextField;
		private var sick:TextField;
		private var absent:TextField;

		private var employeeList:Sprite;

		private var dialogConfirm:NativeDialog;
		private var dialogInfo:NativeDialog;

		private var currentEmployee:EmployeeAdapter;
		private var trainDialog:EmployeeTrainingDialog;

		private var levelBar:Shape;
		private var server:ServerManager;
		private var save:DataManager;
		private var fireworkManager:FireworkManager;

		/**
		 * Default constructor of EmployeeFrame.
		 */
		public function EmployeeFrame()
		{
			super();

			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			save = new DataManager();

			background = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("paper"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			background.y = -45;
			addChild(background);

			levelBar = new Shape();
			addChild(levelBar);

			label = new TextField(100, 50, "Employee", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -330;
			label.y = -175;
			addChild(label);

			noEmployeeLabel = new TextField(100, 50, "No Employee", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x888888);
			noEmployeeLabel.hAlign = HAlign.LEFT;
			noEmployeeLabel.vAlign = VAlign.TOP;
			noEmployeeLabel.x = -330;
			noEmployeeLabel.y = -145;
			addChild(noEmployeeLabel);

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

			employeeAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_reza_radhian"));
			employeeAvatar.pivotX = employeeAvatar.width * 0.5;
			employeeAvatar.pivotY = employeeAvatar.height * 0.5;
			employeeAvatar.x = -85;
			employeeAvatar.y = -30;
			addChild(employeeAvatar);

			label = new TextField(150, 50, "Employee Detail", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -175;
			addChild(label);

			label = new TextField(100, 50, "Profile", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -140;
			addChild(label);

			profile = new TextField(170, 70, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			profile.hAlign = HAlign.LEFT;
			profile.vAlign = VAlign.TOP;
			profile.x = 5;
			profile.y = -120;
			addChild(profile);

			label = new TextField(100, 50, "Request Min.", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -75;
			addChild(label);

			career = new TextField(170, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			career.hAlign = HAlign.LEFT;
			career.vAlign = VAlign.TOP;
			career.x = 5;
			career.y = -55;
			addChild(career);

			label = new TextField(100, 50, "Education", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = -25;
			addChild(label);

			education = new TextField(170, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			education.hAlign = HAlign.LEFT;
			education.vAlign = VAlign.TOP;
			education.x = 5;
			education.y = -5;
			addChild(education);

			label = new TextField(100, 50, "Experience", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 5;
			label.y = 30;
			addChild(label);

			experience = new TextField(170, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			experience.hAlign = HAlign.LEFT;
			experience.vAlign = VAlign.TOP;
			experience.x = 5;
			experience.y = 50;
			addChild(experience);

			label = new TextField(100, 50, "Behavior", Assets.getFont(Assets.FONT_CORegular).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -175;
			addChild(label);

			label = new TextField(100, 50, "Day Hired", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -140;
			addChild(label);

			hired = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			hired.hAlign = HAlign.RIGHT;
			hired.vAlign = VAlign.TOP;
			hired.x = 270;
			hired.y = -140;
			addChild(hired);

			label = new TextField(100, 50, "Salary", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -120;
			addChild(label);

			salary = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			salary.hAlign = HAlign.RIGHT;
			salary.vAlign = VAlign.TOP;
			salary.x = 270;
			salary.y = -120;
			addChild(salary);

			label = new TextField(100, 50, "Morale", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -100;
			addChild(label);

			morale = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			morale.hAlign = HAlign.RIGHT;
			morale.vAlign = VAlign.TOP;
			morale.x = 270;
			morale.y = -100;
			addChild(morale);

			label = new TextField(100, 50, "Services", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -80;
			addChild(label);

			services = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			services.hAlign = HAlign.RIGHT;
			services.vAlign = VAlign.TOP;
			services.x = 270;
			services.y = -80;
			addChild(services);

			label = new TextField(100, 50, "Productivity", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -60;
			addChild(label);

			productivity = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			productivity.hAlign = HAlign.RIGHT;
			productivity.vAlign = VAlign.TOP;
			productivity.x = 270;
			productivity.y = -60;
			addChild(productivity);

			label = new TextField(150, 50, "Days late X", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -40;
			addChild(label);

			late = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			late.hAlign = HAlign.RIGHT;
			late.vAlign = VAlign.TOP;
			late.x = 270;
			late.y = -40;
			addChild(late);

			label = new TextField(150, 50, "Days sick X", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = -20;
			addChild(label);

			sick = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			sick.hAlign = HAlign.RIGHT;
			sick.vAlign = VAlign.TOP;
			sick.x = 270;
			sick.y = -20;
			addChild(sick);

			label = new TextField(150, 50, "Days absent X", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = 0;
			addChild(label);

			absent = new TextField(100, 50, "-", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			absent.hAlign = HAlign.RIGHT;
			absent.vAlign = VAlign.TOP;
			absent.x = 270;
			absent.y = 0;
			addChild(absent);

			label = new TextField(100, 50, "Level", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 190;
			label.y = 23;
			addChild(label);

			buttonTrain = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_train"));
			buttonTrain.pivotX = buttonTrain.width * 0.5;
			buttonTrain.pivotY = buttonTrain.height * 0.5;
			buttonTrain.x = 282;
			buttonTrain.y = 80;
			addChild(buttonTrain);
			
			buttonDismiss = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_employee_dismiss"));
			buttonDismiss.pivotX = buttonDismiss.width * 0.5;
			buttonDismiss.pivotY = buttonDismiss.height * 0.5;
			buttonDismiss.x = -50;
			buttonDismiss.y = 80;
			addChild(buttonDismiss);
			
			trainDialog = new EmployeeTrainingDialog();
			trainDialog.x = Starling.current.stage.stageWidth * 0.5;
			trainDialog.y = Starling.current.stage.stageHeight * 0.5;
			trainDialog.addEventListener(EmployeeTrainingDialog.EMPLOYEE_TRAINED, onEmployeeTrain);
			Game.overlayStage.addChild(trainDialog);

			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Employee Dismiss", "Kamu yakin dismiss pegawai??");
			dialogConfirm.x = Starling.current.stage.stageWidth * 0.5;
			dialogConfirm.y = Starling.current.stage.stageHeight * 0.5;
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, onEmployeeFired);
			Game.overlayStage.addChild(dialogConfirm);

			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION);
			dialogInfo.x = Starling.current.stage.stageWidth * 0.5;
			dialogInfo.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(dialogInfo);

			buttonDismiss.addEventListener(starling.events.Event.TRIGGERED, function(event:starling.events.Event):void
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(buttonDismiss.x + Starling.current.stage.stageWidth * 0.5, buttonDismiss.y + Starling.current.stage.stageHeight * 0.5);
				dialogConfirm.openDialog();
			});

			buttonTrain.addEventListener(starling.events.Event.TRIGGERED, function(event:starling.events.Event):void
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(buttonTrain.x + Starling.current.stage.stageWidth * 0.5, buttonTrain.y + Starling.current.stage.stageHeight * 0.5);
				trainDialog.setEmployee(Data.employee[currentEmployee.employeeIndex]);
				trainDialog.openDialog();
			});

			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void
			{
				dialogInfo.closeDialog()
			});

			updateEmployee();
			avatarAnimation();
		}

		/**
		 * Employee was trained and save the game data.
		 * 
		 * @param event
		 */
		private function onEmployeeTrain(event:starling.events.Event):void
		{
			save.saveGameData();
			updateEmployee();
		}

		/**
		 * Employee is dismissed.
		 * 
		 * @param event
		 */
		private function onEmployeeFired(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				if (currentEmployee.dismiss())
				{
					Game.loadingScreen.show();

					var gameObject:Object = new Object();
					gameObject.token = Data.key;
					gameObject.employee_id = currentEmployee.employeeId;

					server = new ServerManager("employee/fired_employee", gameObject);
					server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void
					{
						Game.loadingScreen.hide();

						trace("employee fired id " + currentEmployee.employeeId + "index "+currentEmployee.employeeIndex);

						Data.employee.splice(currentEmployee.employeeIndex, 1);

						Config.candidate[currentEmployee.employeeId-1].emp_status = "unemployed";
						Config.candidate[currentEmployee.employeeId-1][7] = "unemployed";

						dialogInfo.dialogTitle = "Employee Dismissed";
						dialogInfo.dialogMessage = "Pegawai telah di dismiss dari daftar";
						dialogInfo.openDialog();

						updateEmployee();
					});
					server.sendRequest();

				}
				else
				{
					dialogInfo.dialogTitle = "Employee Dismiss";
					dialogInfo.dialogMessage = "Dismiss pegawai gagal";
					dialogInfo.openDialog();
				}
			}
			dialogConfirm.closeDialog();
		}

		/**
		 * Animate employee avatar scale up-down.
		 */
		private function avatarAnimation():void
		{
			TweenMax.to(
				employeeAvatar, 
				0.5, 
				{
					scaleX: (employeeAvatar.scaleX == 1) ? 0.9 : 1, 
					scaleY: (employeeAvatar.scaleX == 1) ? 0.9 : 1, 
					ease: (employeeAvatar.scaleX == 1) ? Cubic.easeOut : Cubic.easeIn, 
					onComplete: function():void {
						avatarAnimation();
					}
				}
			);
		}

		/**
		 * Update employee list.
		 */
		public function updateEmployee():void
		{
			employeeList.removeChildren();
			var count:int = 0;
			if (Data.employee != null)
			{
				for (var i:int = 0; i < Data.employee.length; i++)
				{
					var employee:EmployeeAdapter = new EmployeeAdapter(i, Data.employee[i].emp_id, Data.employee[i].emp_name);
					employee.y = count++ * 30;
					employeeList.addChild(employee);
					employee.addEventListener(TouchEvent.TOUCH, onEmployeeSelected);
				}
			}

			if (employeeList.numChildren > 0)
			{
				buttonDismiss.enabled = true;
				buttonTrain.enabled = true;
				noEmployeeLabel.visible = false;
				select.visible = true;
				select.y = employeeList.getChildAt(0).y + employeeList.y + 28;
				currentEmployee = EmployeeAdapter(employeeList.getChildAt(0))
				setCurrentEmployee();
			}
			else
			{
				buttonDismiss.enabled = false;
				buttonTrain.enabled = false;
				noEmployeeLabel.visible = true;
				select.visible = false;
				currentEmployee = null;
				employeeAvatar.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("no_employee");
				employeeAvatar.readjustSize();
				hired.text = "-";
				salary.text = "-";
				morale.text = "-";
				services.text = "-";
				productivity.text = "-";
				late.text = "-";
				sick.text = "-";
				absent.text = "-";
				profile.text = "-";
				career.text = "-";
				education.text = "-";
				experience.text = "-";
				levelBar.graphics.clear();
			}
		}

		/**
		 * Selected employee and update the avatar.
		 * 
		 * @param touch
		 */
		private function onEmployeeSelected(touch:TouchEvent):void
		{
			if (touch.getTouch(EmployeeAdapter(touch.currentTarget), TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				currentEmployee = EmployeeAdapter(touch.currentTarget);
				fireworkManager.spawn(employeeAvatar.x + Starling.current.stage.stageWidth * 0.5, employeeAvatar.y + Starling.current.stage.stageHeight * 0.5);
				setCurrentEmployee();
			}
		}

		/**
		 * Update view of employee avatar and info.
		 */
		private function setCurrentEmployee():void
		{
			TweenMax.to(select, 0.3, {y: currentEmployee.y + employeeList.y + 27});

			employeeAvatar.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture(Data.employee[currentEmployee.employeeIndex].emp_atlas);
			employeeAvatar.readjustSize();

			hired.text = Data.employee[currentEmployee.employeeIndex].pem_hired;
			salary.text = "IDR " + ValueFormatter.numberFormat(Data.employee[currentEmployee.employeeIndex].pem_salary);
			morale.text = Data.employee[currentEmployee.employeeIndex].pem_morale;
			services.text = Data.employee[currentEmployee.employeeIndex].pem_services;
			productivity.text = Data.employee[currentEmployee.employeeIndex].pem_productivity;
			late.text = Data.employee[currentEmployee.employeeIndex].pem_late + "X";
			sick.text = Data.employee[currentEmployee.employeeIndex].pem_sick + "X";
			absent.text = Data.employee[currentEmployee.employeeIndex].pem_absent + "X";

			profile.text = String(Data.employee[currentEmployee.employeeIndex].emp_profile).replace("\n\n", "");
			career.text = "IDR " + ValueFormatter.numberFormat(Data.employee[currentEmployee.employeeIndex].emp_salary_goal) + " / hari";
			education.text = Data.employee[currentEmployee.employeeIndex].emp_education;
			experience.text = String(Data.employee[currentEmployee.employeeIndex].emp_experience).replace("\n\n", "");

			levelBar.graphics.clear();

			for (var j:int = 0; j < 5; j++)
			{
				if (j < Data.employee[currentEmployee.employeeIndex].pem_level)
				{
					levelBar.graphics.beginFill(0x0696ef);
					levelBar.graphics.lineStyle(1, 0x0696ef, 0.5);
					levelBar.graphics.drawCircle(j * 20 + 280, 35, 7);
					levelBar.graphics.endFill();
				}
				else
				{
					levelBar.graphics.beginFill(0xd1d1d1);
					levelBar.graphics.lineStyle(1, 0xd1d1d1, 0.5);
					levelBar.graphics.drawCircle(j * 20 + 280, 35, 7);
					levelBar.graphics.endFill();
				}
			}

			var emp:Object = Data.employee[currentEmployee.employeeIndex];
			buttonTrain.enabled = !(emp.pem_morale >= 10 && emp.pem_productivity >= 10 && emp.pem_services >= 10);
		}
	}
}
