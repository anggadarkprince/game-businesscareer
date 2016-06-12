package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkManager;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class DialogOverlay extends Sprite
	{
		protected var overlay:Quad;
		protected var isDestroyable:Boolean;
		protected var fireworkManager:FireworkManager;
		
		public function DialogOverlay(destroyable:Boolean)
		{
			super();
			
			isDestroyable = destroyable;
			
			fireworkManager = new FireworkManager(Game.overlayStage);
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
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
						if(isDestroyable)
						{
							destroy();
						}
						else
						{
							visible = false;
						}						
					}
				}
			);
		}
		
		public function destroy():void
		{
			removeFromParent(true);
		}
	}
}