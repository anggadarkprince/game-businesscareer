package sketchproject.screens
{
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkParticleManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class GameScreen extends Sprite
	{
		protected var containerScreen:Sprite;
		protected var baseScreen:Image;
		protected var topScreen:Image;
		protected var buttonContainer:Sprite;
		protected var fireworkManager:FireworkParticleManager;
		
		public function GameScreen()
		{
			super();
			
			fireworkManager = new FireworkParticleManager(Game.overlayStage);
			
			containerScreen = new Sprite();
			
			baseScreen = new Image(Assets.getAtlas(Assets.ADDITIONAL, Assets.ADDITIONAL_XML).getTexture("shop_background"));
			baseScreen.pivotX = baseScreen.width * 0.5;
			baseScreen.pivotY = baseScreen.height * 0.5;
			containerScreen.addChild(baseScreen);
			
			topScreen = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("shop_top"));
			topScreen.pivotX = topScreen.width * 0.5;
			topScreen.pivotY = topScreen.height * 0.5;		
			topScreen.y = - 260;
			containerScreen.addChild(topScreen);
						
			addChild(containerScreen);
			
			buttonContainer = new Sprite();
		}
		
		protected function hideBase():void
		{
			containerScreen.visible = false;
		}
		
		protected function showBase():void
		{
			containerScreen.visible = true;
		}
		
		public function hideMenu():void
		{
			buttonContainer.visible = false;			
		}
		
		public function showMenu():void
		{
			buttonContainer.visible = true;			
		}
	}
}