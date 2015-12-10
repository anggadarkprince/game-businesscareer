package sketchproject.objects.panel
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.FireworkParticleManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Panel extends Sprite
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var dialogIcon:Image;
		private var dialogTitle:Image;
		private var dialogSubtitle:TextField;
		private var buttonClose:Button;
		protected var fireworkManager:FireworkParticleManager;
		
		public function Panel(iconTexture:Texture, titleTexture:Texture, subtitle:String)
		{
			super();
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialogBase = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("panel"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
			
			dialogIcon = new Image(iconTexture);
			dialogIcon.pivotX = dialogIcon.width * 0.5;
			dialogIcon.pivotY = dialogIcon.height * 0.5;
			dialogIcon.x = -421.45;
			dialogIcon.y = -241.8;
			addChild(dialogIcon);
			
			dialogTitle = new Image(titleTexture);
			dialogTitle.x = -380.45;
			dialogTitle.y = -280;
			addChild(dialogTitle);
			
			dialogSubtitle = new TextField(300, 35, subtitle, Assets.getFont(Assets.FONT_CORegular).fontName, 18, 0xFFFFFF);			
			dialogSubtitle.x = -380.45;
			dialogSubtitle.y = -245;
			dialogSubtitle.hAlign = HAlign.LEFT;
			dialogSubtitle.vAlign = VAlign.TOP;
			addChild(dialogSubtitle);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.y = -242;
			buttonClose.x = 454.75;
			addChild(buttonClose);
			
			buttonClose.addEventListener(Event.TRIGGERED, onPanelClosed);
			
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
					scaleX:1,
					scaleY:1,
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
		
		public function onPanelClosed(event:Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			closeDialog();
		}
	}
}