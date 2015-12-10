package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.FireworkParticleManager;
	import sketchproject.managers.RewardManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class EmployeeTrainingDialog extends Sprite
	{
		public static const EMPLOYEE_TRAINED:String = "employeeTrained";
		
		private var overlay:Quad;
		private var dialog:Image;
		private var titleEmployee:TextField;
		private var label:TextField;
		private var trainingBar:Quad;
		private var icon:Image;
		private var buttonTrainMorale:Button;
		private var buttonTrainProductivity:Button;
		private var buttonTrainServices:Button;
		private var fireworkManager:FireworkParticleManager;
		
		private var moraleContainer:Sprite;
		private var productivityContainer:Sprite;
		private var servicesContainer:Sprite;
		
		private var dialogConfirm:NativeDialog;
		private var dialogInfo:NativeDialog;
		
		private var totalTrainingCost:int;
		private var buttonOk:Button;
		
		private var employee:Object;
		private var gemManager:RewardManager;
		
		
		public function EmployeeTrainingDialog()
		{
			super();
			
			employee = new Object();
			
			gemManager = new RewardManager(RewardManager.REWARD_GEM, RewardManager.SPAWN_HIGH);
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialog = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_train"));
			dialog.pivotX = dialog.width * 0.5;
			dialog.pivotY = dialog.height * 0.5;
			addChild(dialog);
			
			titleEmployee = new TextField(300, 50, "EMPLOYEE STATUS", Assets.getFont(Assets.FONT_SSBOLD).fontName, 26, 0xFFFFFF);
			titleEmployee.pivotX = titleEmployee.width * 0.5;
			titleEmployee.vAlign = VAlign.TOP;
			titleEmployee.y = -190;
			addChild(titleEmployee);
			
			
			icon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_morale"));
			icon.pivotX = icon.width * 0.5;
			icon.pivotY = icon.height * 0.5;
			icon.x = -190;
			icon.y = -82;
			addChild(icon);
			
			icon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_productivity"));
			icon.pivotX = icon.width * 0.5;
			icon.pivotY = icon.height * 0.5;
			icon.x = -190;
			icon.y = -10;
			addChild(icon);
			
			icon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_services"));
			icon.pivotX = icon.width * 0.5;
			icon.pivotY = icon.height * 0.5;
			icon.x = -190;
			icon.y = 61;
			addChild(icon);
			
			
			label = new TextField(170, 50, "Morale", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x454545);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -113;
			label.y = -112;
			addChild(label);
			
			moraleContainer = new Sprite();
			moraleContainer.x = -113;
			moraleContainer.y = -80;
			addChild(moraleContainer);
			
			label = new TextField(100, 50, "500 K", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x454545);
			label.hAlign = HAlign.RIGHT;
			label.vAlign = VAlign.TOP;
			label.pivotX = label.width;
			label.x = 80;
			label.y = -112;
			addChild(label);
			
			
			label = new TextField(170, 50, "Productivity", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x454545);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -113;
			label.y = -40;
			addChild(label);
			
			productivityContainer = new Sprite();
			productivityContainer.x = -113;
			productivityContainer.y = -8;
			addChild(productivityContainer);
			
			label = new TextField(100, 50, "500 K", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x454545);
			label.hAlign = HAlign.RIGHT;
			label.vAlign = VAlign.TOP;
			label.pivotX = label.width;
			label.x = 80;
			label.y = -40;
			addChild(label);
			
			
			label = new TextField(170, 50, "Services", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x454545);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -113;
			label.y = 31;
			addChild(label);
			
			servicesContainer = new Sprite();
			servicesContainer.x = -113;
			servicesContainer.y = 63;
			addChild(servicesContainer);
			
			label = new TextField(100, 50, "500 K", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0x454545);
			label.hAlign = HAlign.RIGHT;
			label.vAlign = VAlign.TOP;
			label.pivotX = label.width;
			label.x = 80;
			label.y = 31;
			addChild(label);
			
			
			buttonTrainMorale = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_train_mini"));
			buttonTrainMorale.pivotX = buttonTrainMorale.width * 0.5;
			buttonTrainMorale.pivotY = buttonTrainMorale.height * 0.5;
			buttonTrainMorale.x = 160;
			buttonTrainMorale.y = -75;
			addChild(buttonTrainMorale);
			
			buttonTrainProductivity = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_train_mini"));
			buttonTrainProductivity.pivotX = buttonTrainProductivity.width * 0.5;
			buttonTrainProductivity.pivotY = buttonTrainProductivity.height * 0.5;
			buttonTrainProductivity.x = 160;
			buttonTrainProductivity.y = -3;
			addChild(buttonTrainProductivity);
			
			buttonTrainServices = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_train_mini"));
			buttonTrainServices.pivotX = buttonTrainServices.width * 0.5;
			buttonTrainServices.pivotY = buttonTrainServices.height * 0.5;
			buttonTrainServices.x = 160;
			buttonTrainServices.y = 68;
			addChild(buttonTrainServices);
			
			
			buttonOk = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
			buttonOk.pivotX = buttonOk.width * 0.5;
			buttonOk.pivotY = buttonOk.height * 0.5;
			buttonOk.y = 145;
			addChild(buttonOk);
			
			buttonOk.addEventListener(Event.TRIGGERED, onDialogTrainingClosed);
			buttonTrainMorale.addEventListener(Event.TRIGGERED, onMoraleTrained);
			buttonTrainProductivity.addEventListener(Event.TRIGGERED, onProductivityTrained);
			buttonTrainServices.addEventListener(Event.TRIGGERED, onServicesTrained);
			
			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Employee Training", "Do you want to train the employee?");
			dialogConfirm.x = Starling.current.stage.stageWidth * 0.5;
			dialogConfirm.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(dialogConfirm);
			
			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION, "Training failed", "Your don't have enough money");
			dialogInfo.x = Starling.current.stage.stageWidth * 0.5;
			dialogInfo.y = Starling.current.stage.stageHeight * 0.5;
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, function(event:starling.events.Event):void{
				dialogInfo.closeDialog();	
			});
			Game.overlayStage.addChild(dialogInfo);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}
		
		public function getTrainingCost():int
		{
			return totalTrainingCost;
		}
		
		private function onDialogTrainingClosed(event:Event):void
		{
			closeDialog();			
		}
		
		private function onServicesTrained(event:Event):void
		{
			Game.overlayStage.swapChildren(dialogConfirm, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
			dialogConfirm.dialogMessage = "Do you want to train employee services?";
			dialogConfirm.removeEventListeners(DialogBoxEvent.CLOSED);
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void{
				if(event.result)
				{
					if(Data.cash < (totalTrainingCost + 500000))
					{
						Game.overlayStage.swapChildren(dialogInfo, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
						dialogInfo.openDialog();
					}
					else
					{
						for(var i:int = 0; i<Data.employee.length ; i++)
						{
							if(Data.employee[i].emp_id == employee.emp_id)
							{
								Data.employee[i].pem_services = int(Data.employee[i].pem_services) + 2;
								Data.employee[i].pem_level = Math.ceil((int(Data.employee[i].pem_services)+int(Data.employee[i].pem_productivity)+int(Data.employee[i].pem_morale))/30*5);
								totalTrainingCost += 500000;
								setEmployee(employee,false);
								gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40,700);
								trace("total cost training " + totalTrainingCost);
								trace("employee id "+employee.emp_id+" trained services level to "+Data.employee[i].pem_services+", overall level "+Data.employee[i].pem_level);
								if(int(Data.employee[i].pem_services) == 10){
									buttonTrainServices.enabled = false;
								}
							}
						}
					}					
				}
				dialogConfirm.closeDialog();
			});		
			dialogConfirm.openDialog();
		}
		
		private function onProductivityTrained(event:Event):void
		{
			Game.overlayStage.swapChildren(dialogConfirm, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
			dialogConfirm.dialogMessage = "Do you want to train employee productivity?";
			dialogConfirm.removeEventListeners(DialogBoxEvent.CLOSED);
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void{
				if(event.result)
				{
					if(Data.cash < (totalTrainingCost + 500000))
					{
						Game.overlayStage.swapChildren(dialogInfo, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
						dialogInfo.openDialog();
					}
					else
					{
						for(var i:int = 0; i<Data.employee.length ; i++)
						{
							if(Data.employee[i].emp_id == employee.emp_id)
							{
								Data.employee[i].pem_productivity = int(Data.employee[i].pem_productivity) + 2;
								Data.employee[i].pem_level = Math.ceil((int(Data.employee[i].pem_services)+int(Data.employee[i].pem_productivity)+int(Data.employee[i].pem_morale))/30*5)
								totalTrainingCost += 500000;
								setEmployee(employee,false);
								gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40,700);
								trace("total cost training " + totalTrainingCost);
								trace("employee id "+employee.emp_id+" trained productivity level to "+Data.employee[i].pem_productivity+", overall level "+Data.employee[i].pem_level);
								if(int(Data.employee[i].pem_productivity) == 10){
									buttonTrainProductivity.enabled = false;
								}
							}
						}
					}					
				}
				dialogConfirm.closeDialog();
			});		
			dialogConfirm.openDialog();
		}
		
		private function onMoraleTrained(event:Event):void
		{
			Game.overlayStage.swapChildren(dialogConfirm, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
			dialogConfirm.dialogMessage = "Do you want to train employee morale?";
			dialogConfirm.removeEventListeners(DialogBoxEvent.CLOSED);
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void{
				if(event.result)
				{
					if(Data.cash < (totalTrainingCost + 500000))
					{
						Game.overlayStage.swapChildren(dialogInfo, Game.overlayStage.getChildAt(Game.overlayStage.numChildren-1));
						dialogInfo.openDialog();
					}
					else
					{
						for(var i:int = 0; i<Data.employee.length ; i++)
						{
							if(Data.employee[i].emp_id == employee.emp_id)
							{
								Data.employee[i].pem_morale = int(Data.employee[i].pem_morale) + 2;
								Data.employee[i].pem_level = Math.ceil((int(Data.employee[i].pem_services)+int(Data.employee[i].pem_productivity)+int(Data.employee[i].pem_morale))/30*5)
								totalTrainingCost += 500000;
								setEmployee(employee,false);
								gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40,700);
								trace("total cost training " + totalTrainingCost);
								trace("employee id "+employee.emp_id+" trained morale level to "+Data.employee[i].pem_morale+", overall level "+Data.employee[i].pem_level);
								if(int(Data.employee[i].pem_morale) == 10){
									buttonTrainMorale.enabled = false;
								}
							}
						}
					}					
				}
				dialogConfirm.closeDialog();
			});		
			dialogConfirm.openDialog();
		}
		
		
		public function setEmployee(employee:Object, setNew:Boolean = true):void
		{
			this.employee = employee;
			
			if(setNew){
				totalTrainingCost = 0;
			}
			
			moraleContainer.removeChildren();
			productivityContainer.removeChildren();
			servicesContainer.removeChildren();
			
			for(var j:int = 0; j<Data.employee.length ; j++)
			{
				if(Data.employee[j].emp_id == employee.emp_id)
				{
					titleEmployee.text = Data.employee[j].emp_name;
				}
			}
			
			if(employee.pem_morale == 10)
			{
				buttonTrainMorale.enabled = false;
			}
			if(employee.pem_productivity == 10)
			{
				buttonTrainProductivity.enabled = false;
			}
			if(employee.pem_services == 10)
			{
				buttonTrainServices.enabled = false;
			}
			
			for(var i:int = 0; i<5 ; i++)
			{
				// morale
				if(i<employee.pem_morale/2){
					trainingBar = new Quad(35,20,0xF96E43);					
				}
				else{
					trainingBar = new Quad(35,20,0xc9cdc8);
				}
				trainingBar.x = (i * (trainingBar.width + 5));
				moraleContainer.addChild(trainingBar);
				
				// productivity
				if(i<employee.pem_productivity/2){
					trainingBar = new Quad(35,20,0xF96E43);					
				}
				else{
					trainingBar = new Quad(35,20,0xc9cdc8);
				}
				trainingBar.x = (i * (trainingBar.width + 5));
				productivityContainer.addChild(trainingBar);
				
				// services
				if(i<employee.pem_services/2){
					trainingBar = new Quad(35,20,0xF96E43);					
				}
				else{
					trainingBar = new Quad(35,20,0xc9cdc8);
				}
				trainingBar.x = (i * (trainingBar.width + 5));
				servicesContainer.addChild(trainingBar);
			}
		}
		
		
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0,0,Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this,
				0.7,
				{
					ease:Back.easeOut,
					scaleX:0.9,
					scaleY:0.9,
					alpha:1,
					delay:0.2
				}
			);	
		}
		
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			TweenMax.to(
				this,
				0.5,
				{
					ease:Back.easeIn,
					scaleX:0.5,
					scaleY:0.5,
					alpha:0,
					delay:0.2,
					onComplete:function():void{
						visible = false;
						if(totalTrainingCost > 0)
						{
							var dialog:PostDialog = new PostDialog("Training",totalTrainingCost,false);
							dialog.x = stage.stageWidth * 0.5;
							dialog.y = stage.stageHeight * 0.5;
							Game.overlayStage.addChild(dialog);
							dialog.openDialog();
							dialog.addEventListener(PostDialog.POSTING, function(event:starling.events.Event):void{
								totalTrainingCost = 0;	
								dispatchEvent(new Event(EmployeeTrainingDialog.EMPLOYEE_TRAINED));
							});
						}
					}
				}
			);
		}
		
	}
}