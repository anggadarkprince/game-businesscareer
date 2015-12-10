package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.FireworkParticleManager;
	import sketchproject.objects.task.Task;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class NewTaskDialog extends Sprite implements IDialog
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var dialogIcon:Task;
		private var info:TextField;
		private var reward:TextField;		
		private var buttonOK:Button;
		private var type:String;
		private var progress:TextField;
		private var fireworkManager:FireworkParticleManager;
		
		public function NewTaskDialog(textInfo:String = "No Task", type:String = "journal", point:uint = 0)
		{
			super();
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_new_task"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
			
			//dialogIcon = new Task(type);
			//dialogIcon.y = -80;
			//addChild(dialogIcon);
			
			this.type = type;
			
			info = new TextField(250, 150, textInfo, Assets.getFont("FontCarterOne").fontName, 16, 0xFFFFFF);
			info.pivotX = info.width * 0.5;
			info.y = -60;
			info.vAlign = VAlign.TOP;
			addChild(info);
			
			progress = new TextField(250, 150, "Reward", Assets.getFont("FontCarterOne").fontName, 12, 0xFFFFFF);
			progress.x = -100;
			progress.y = 22;
			progress.hAlign = HAlign.LEFT;
			progress.vAlign = VAlign.TOP;
			addChild(progress);
			
			reward = new TextField(250, 150, point+" PTS", Assets.getFont("FontCarterOne").fontName, 15, 0xFFFFFF);
			reward.x = -100;
			reward.y = 37;
			reward.hAlign = HAlign.LEFT;
			reward.vAlign = VAlign.TOP;
			addChild(reward);
			
			progress = new TextField(250, 150, "Progress", Assets.getFont("FontCarterOne").fontName, 12, 0xFFFFFF);
			progress.pivotX = info.width;
			progress.x = 100;
			progress.y = 22;			
			progress.hAlign = HAlign.RIGHT;
			progress.vAlign = VAlign.TOP;
			addChild(progress);
			
			progress = new TextField(250, 150, "0/1", Assets.getFont("FontCarterOne").fontName, 15, 0xFFFFFF);
			progress.pivotX = info.width;
			progress.x = 100;
			progress.y = 37;
			progress.hAlign = HAlign.RIGHT;
			progress.vAlign = VAlign.TOP;
			addChild(progress);
			
			buttonOK = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_confirm_outline"));
			buttonOK.pivotX = buttonOK.width * 0.5;
			buttonOK.pivotY = buttonOK.height * 0.5;
			buttonOK.scaleX = 0.75;
			buttonOK.scaleY = 0.75;
			buttonOK.y = 100;
			addChild(buttonOK);
			
			buttonOK.addEventListener(Event.TRIGGERED, onPrimaryTrigerred);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}
		
		public function set taskInfo(info:String):void
		{
			this.info.text = info;
		}
		
		public function get taskInfo():String
		{
			return this.info.text;
		}
		
		public function set taskReward(reward:int):void
		{
			this.reward.text = reward.toString()+" PTS";
		}
		
		public function get taskReward():int
		{
			return int(this.reward.text.substring(0,this.reward.text.length-4));
		}
		
		public function set taskType(type:String):void
		{
			this.type = type;
		}
		
		public function get taskType():String
		{
			return type;
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
					scaleX:1,
					scaleY:1,
					alpha:1,
					delay:0.2,
					onComplete:function():void{
						fireworkManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5);
					}
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
					onComplete:function():void{
						visible = false;
					}
				}
			);
		}
		
		public function onPrimaryTrigerred(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			dispatchEvent(new DialogBoxEvent(DialogBoxEvent.CLOSED, true));
			closeDialog();
		}
	}
}