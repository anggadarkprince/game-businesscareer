package sketchproject.objects.panel
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.objects.adapter.AchievementAdapter;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class AchievementPanel extends Panel
	{
		private var acheivement1Container:Sprite;
		private var acheivement2Container:Sprite;
		
		private var currentPage:int;
		private var pageButton:Image;
		private var page1:Quad;
		private var page2:Quad;
		
		public function AchievementPanel()
		{
			super(
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_star"),
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("title_achievement"),
				"Earn achievements by making good business and life decisions"
			);
			
			currentPage = 1;
			pageButton = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("achievement_page1"));
			pageButton.pivotX = pageButton.width * 0.5;
			pageButton.y = 200;
			addChild(pageButton);
			
			page1 = new Quad(150,30,0xFFFFFF);
			page1.x = -150;
			page1.y = pageButton.y;
			page1.alpha = 0;
			addChild(page1);
			
			page2 = new Quad(150,30,0xFFFFFF);
			page2.x = 0;
			page2.y = pageButton.y;
			page2.alpha = 0;
			addChild(page2);
						
			acheivement1Container = new Sprite();
			acheivement1Container.x = -380;
			acheivement1Container.y = -185;
			addChild(acheivement1Container);
			
			acheivement2Container = new Sprite();
			acheivement2Container.x = -380;
			acheivement2Container.y = -185;
			acheivement2Container.visible = false;
			addChild(acheivement2Container);
			
			for(var i:uint = 0; i<Data.achievement.length;i++){
				var acheivement:AchievementAdapter = new AchievementAdapter(
					Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.achievement[i].ach_atlas),
					Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.achievement[i].ac_title_atlas),
					Data.achievement[i].ach_description,
					Data.achievement[i].earned
				);
				acheivement.x = (i%5) * 185;
				acheivement.name = Data.achievement[i].ac_title_atlas.toString();
				
				if(i<5){
					acheivement1Container.addChild(acheivement);
				}
				else{
					acheivement2Container.addChild(acheivement);
				}			
			}
			
			updateEarned();
			
			addEventListener(TouchEvent.TOUCH, onPageTouched);
		}
		
		private function onPageTouched(touch:TouchEvent):void
		{
			if(touch.getTouch(page1,TouchPhase.ENDED)){
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				pageButton.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("achievement_page1");
				acheivement1Container.visible = true;
				acheivement2Container.visible = false;
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			else if(touch.getTouch(page2,TouchPhase.ENDED)){
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				pageButton.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("achievement_page2");
				acheivement1Container.visible = false;
				acheivement2Container.visible = true;
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			
		}	
						
		public function updateEarned():void
		{
			for(var i:uint = 0; i<Data.achievement.length;i++){
				if(i<5){
					AchievementAdapter(acheivement1Container.getChildByName(Data.achievement[i].ac_title_atlas)).earned = Data.achievement[i].earned;	
				}
				else{
					AchievementAdapter(acheivement2Container.getChildByName(Data.achievement[i].ac_title_atlas)).earned = Data.achievement[i].earned;
				}				
			}			
		}
	}
}