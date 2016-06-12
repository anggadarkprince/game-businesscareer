package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.DataManager;
	import sketchproject.managers.FireworkManager;
	import sketchproject.objects.world.AvatarController;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class AvatarDialog extends Sprite
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var buttonPrimary:Button;
		private var avatar:AvatarController;
		
		private var buttonConfirm:Button;
		
		private var fireworkManager:FireworkManager;
		
		private var labelAvatarDesign:TextField;
		
		private var server:DataManager;
				
		public function AvatarDialog()
		{
			super();
									
			fireworkManager = new FireworkManager(Game.overlayStage);
			
			server = new DataManager();
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_flat_small"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
			
			labelAvatarDesign = new TextField(170, 50, "MY AVATAR", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0xFFFFFF);
			labelAvatarDesign.pivotX = labelAvatarDesign.width * 0.5;
			labelAvatarDesign.y = -250;
			addChild(labelAvatarDesign);
			
			avatar = AvatarController.getInstance();
			avatar.x = -140;
			avatar.y = -160;
			addChild(avatar);
						
			buttonConfirm = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_confirm_flat"));
			buttonConfirm.pivotX = buttonConfirm.width * 0.5;
			buttonConfirm.pivotY = buttonConfirm.height * 0.5;
			buttonConfirm.scaleX = 0.8;
			buttonConfirm.scaleY = 0.8;
			buttonConfirm.x = 74;
			buttonConfirm.y = 175;
			addChild(buttonConfirm);
			
			labelAvatarDesign = new TextField(200, 50, "Avatar Design", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xc0251e);
			labelAvatarDesign.x = -200;
			labelAvatarDesign.y = 132;
			addChild(labelAvatarDesign);
			
			labelAvatarDesign = new TextField(200, 50, Data.name, Assets.getFont(Assets.FONT_CORegular).fontName, 15, 0x333333);
			labelAvatarDesign.x = -200;
			labelAvatarDesign.y = 157;
			addChild(labelAvatarDesign);
									
			buttonConfirm.addEventListener(Event.TRIGGERED, onDialogClosed);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
			
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
					}
				}
			);
		}
		
		public function onDialogClosed(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			server.saveGameData();
			closeDialog();
		}
		
		public function destroy():void
		{
			avatar.removeFromParent(false);
		}
	}
}