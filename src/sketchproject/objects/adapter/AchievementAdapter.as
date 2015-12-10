package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;
	
	public class AchievementAdapter extends Sprite
	{
		private var id:int;
		private var earn:int;
		
		private var baseList:Image;
		private var iconAchievement:Image;
		private var titleAcheivement:Image;
		private var descriptionAchievmeent:TextField;
		private var labelTotal:TextField;
		private var totalEarned:TextField;
		
		
		public function AchievementAdapter(textureIcon:Texture, textureTitle:Texture, description:String, earned:int)
		{
			super();
			
			baseList = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("list_achievement"));
			baseList.pivotX = baseList.width * 0.5;;
			addChild(baseList);
			
			iconAchievement = new Image(textureIcon);
			iconAchievement.pivotX = iconAchievement.width * 0.5;
			iconAchievement.y = 50;
			addChild(iconAchievement);
			
			titleAcheivement = new Image(textureTitle);
			titleAcheivement.pivotX = titleAcheivement.width * 0.5;
			titleAcheivement.pivotY = titleAcheivement.height * 0.5;
			titleAcheivement.y = 150;
			addChild(titleAcheivement);
			
			descriptionAchievmeent = new TextField(130, 100, description, Assets.getFont(Assets.FONT_CORegular).fontName, 12, 0xFFFFFF);
			descriptionAchievmeent.pivotX = descriptionAchievmeent.width * 0.5;
			descriptionAchievmeent.y = 170;
			descriptionAchievmeent.vAlign = VAlign.TOP;
			addChild(descriptionAchievmeent);
			
			labelTotal = new TextField(70, 60, "Earned", Assets.getFont(Assets.FONT_CORegular).fontName, 18, 0xFFFFFF);
			labelTotal.pivotX = labelTotal.width * 0.5;
			labelTotal.y = 255;
			labelTotal.vAlign = VAlign.TOP;
			addChild(labelTotal);
			
			totalEarned = new TextField(60, 50, earned.toString()+"X", Assets.getFont(Assets.FONT_CORegular).fontName, 35, 0xFFFFFF);
			totalEarned.pivotX = totalEarned.width * 0.5;
			totalEarned.y = 280;
			totalEarned.vAlign = VAlign.TOP;
			addChild(totalEarned);
						
			
		}
		
		public function set achievement(id:uint):void
		{
			this.id = id
		}
		
		public function get achievement():uint
		{
			return this.id;
		}
		
		public function set earned(earn:uint):void
		{
			this.earn = earn;
			totalEarned.text = earn.toString();
		}
		
		public function get earned():uint
		{
			return earn;
		}
	}
}