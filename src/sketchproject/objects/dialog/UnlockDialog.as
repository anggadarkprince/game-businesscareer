package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.CelebrateManager;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.RewardManager;
	import sketchproject.managers.ServerManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	public class UnlockDialog extends Sprite implements IDialog
	{
		public static const ACHIEVEMENT_UNLOCKED:String = "unlocked";
		
		private var overlay:Quad;
		private var dialogBase:Image;
		private var dialogIcon:Image;
		private var dialogIconText:Image;
		private var info:TextField;
		private var buttonOK:Button;
		
		private var celebrateManager:CelebrateManager;
		private var celebrateContainer:Sprite;
		
		private var fireworkManager:FireworkManager;
		
		private var fireworksTimer:Timer;
		
		private var server:ServerManager;
		
		private var gemManager:RewardManager;
		
		public function UnlockDialog(textInfo:String = "No Unlock Achievement", achievementIcon:String = "icon_sales")
		{
			super();
						
			fireworkManager = new FireworkManager(Game.overlayStage);
			
			gemManager = new RewardManager(RewardManager.REWARD_GEM, RewardManager.SPAWN_AVERAGE);
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			celebrateContainer = new Sprite();
			celebrateContainer.x = -Starling.current.nativeStage.stageWidth * 0.5;
			celebrateContainer.y = -Starling.current.nativeStage.stageHeight * 0.5;
			addChild(celebrateContainer);
			
			celebrateManager = new CelebrateManager(celebrateContainer);
			
			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_new_congratulation"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
			
			dialogIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(achievementIcon));
			dialogIcon.pivotX = dialogIcon.width * 0.5;
			dialogIcon.pivotY = dialogIcon.height * 0.5;
			dialogIcon.y = -100;
			dialogIcon.scaleX = 0.8;
			dialogIcon.scaleY = 0.8;
			addChild(dialogIcon);

			dialogIconText = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_achievement_unlocked"));
			dialogIconText.pivotX = dialogIconText.width * 0.5;
			dialogIconText.pivotY = dialogIconText.height * 0.5;
			dialogIconText.y = -20;
			addChild(dialogIconText);
			
			info = new TextField(250, 150, textInfo, Assets.getFont(Assets.FONT_CORegular).fontName, 17, 0xFFFFFF);
			info.pivotX = info.width * 0.5;
			info.y = 10;
			info.vAlign = VAlign.TOP;
			addChild(info);
			
			buttonOK = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok_outline"));
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
			
			fireworksTimer = new Timer(1500);
			fireworksTimer.addEventListener(TimerEvent.TIMER, onFireworksTriggered);
		}
		
		protected function onFireworksTriggered(event:TimerEvent):void
		{
			Assets.sfxChannel = Assets.sfxFireworks.play(0,0,Assets.sfxTransform);
			fireworkManager.spawn(Math.random() * Starling.current.stage.stageWidth, Math.random() * Starling.current.stage.stageHeight);
		}
		
		public function set unlockInfo(info:String):void
		{
			this.info.text = info;
		}
		
		public function get unlockInfo():String
		{
			return this.info.text;
		}
		
		public function set unlockIcon(icon:String):void
		{
			this.dialogIcon.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(icon);
			this.dialogIcon.readjustSize();
		}
		
		public function get unlockIcon():String
		{
			return "Achievement Icon";
		}
		
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxStrings.play(0,0,Assets.sfxTransform);
			fireworksTimer.start();
			visible = true;
			TweenMax.to(
				this,
				0.7,
				{
					ease:Back.easeOut,
					scaleX:1,
					scaleY:1,
					alpha:1,
					delay:1,
					onComplete:function():void{
						fireworkManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5);
						gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40,200);
					}
				}
			);	
		}
		
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			fireworksTimer.stop();
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
						dispatchEventWith(ACHIEVEMENT_UNLOCKED);
					}
				}
			);
		}
		
		public function onPrimaryTrigerred(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			closeDialog();
		}
		
		
		/**
		 * Update current state
		 * @return void
		 */
		public function update():void 
		{
			celebrateManager.update();
		}
		
		
		/**
		 * Garbage collection destroy all compenent and reset varable
		 * @return void
		 */
		public function destroy():void
		{
			celebrateManager.destroy();
		}
	}
}