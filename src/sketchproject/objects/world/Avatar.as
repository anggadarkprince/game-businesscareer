package sketchproject.objects.world
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;

	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * Avatar or image of player's profile.
	 * 
	 * @author Angga
	 */
	public class Avatar extends Sprite
	{
		private static var instance:Avatar;

		private var skin:Image;
		private var hair:Image;
		private var backhair:Image;
		private var face:Image;
		private var top:Image;
		private var bottom:Image;
		private var shadow:Image;

		/**
		 * Default controller of Avatar.
		 */
		public function Avatar()
		{
			shadow = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("shadow"));
			shadow.x = 0;
			shadow.y = 243;
			addChild(shadow);

			backhair = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_hair_back_2"));
			backhair.x = -10;
			backhair.y = 20;
			addChild(backhair);

			skin = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("body_1"));
			addChild(skin);

			face = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_face"));
			face.x = 13;
			face.y = 35;
			addChild(face);

			hair = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_hair_front_2"));
			hair.x = -35;
			hair.y = -42;
			addChild(hair);

			bottom = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_bottom_suit_2"));
			bottom.x = 10;
			bottom.y = 143;
			addChild(bottom);

			top = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_top_suit_2"));
			top.x = 12;
			top.y = 80;
			addChild(top);

			updateAvatar();
		}

		/**
		 * Singleton instance.
		 * 
		 * @return Avatar
		 */
		public static function getInstance():Avatar
		{
			if (instance == null)
			{
				instance = new Avatar();
			}
			return instance;
		}

		/**
		 * Update this avatar by game data.
		 */
		public function updateAvatar():void
		{
			if (Data.avatar[0] == 0)
			{
				hair.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_hair_front_" + int(Data.avatar[1] + 1));
				backhair.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_hair_back_" + int(Data.avatar[1] + 1));
				face.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_face");
				top.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_top_suit_" + int(Data.avatar[3] + 1));
				bottom.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_bottom_suit_" + int(Data.avatar[4] + 1));
			}
			else
			{
				hair.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("f_hair_front_" + int(Data.avatar[1] + 1));
				backhair.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("f_hair_back_" + int(Data.avatar[1] + 1));
				face.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("m_face");
				top.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("f_top_suit_" + int(Data.avatar[3] + 1));
				bottom.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("f_bottom_suit_" + int(Data.avatar[4] + 1));
			}
			skin.texture = Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("body_" + int(Data.avatar[2] + 1));
		}
	}
}
