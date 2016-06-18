package sketchproject.objects.adapter
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	import sketchproject.core.Assets;
	import sketchproject.utilities.ValueFormatter;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Leaderboard list adapter, wrapper of player info.
	 * 
	 * @author Angga
	 */
	public class LeaderboardAdapter extends Sprite
	{
		private var baseList:Image;
		private var avatarBase:Image;
		private var avatarImage:Image;
		private var orderBase:Image;
		private var textOrder:TextField;
		private var textName:TextField;
		private var textScore:TextField;

		private var player:String;
		private var star:uint;
		private var score:uint;
		private var avatar:String;
		private var order:uint;

		/**
		 * Default constructor of LeaderbaordAdapter.
		 */
		public function LeaderboardAdapter()
		{
			super();

			baseList = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("list_leaderboard"));
			baseList.y = 10.45;
			addChild(baseList);

			avatarBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("avatar_wrapper"));
			avatarBase.x = 15.55;
			addChild(avatarBase);

			avatarImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("avatar_wrapper"));
			avatarImage.width = 47;
			avatarImage.height = 47;
			avatarImage.x = 15.55;
			addChild(avatarImage);

			orderBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("order_base"));
			orderBase.x = 4.35;
			orderBase.y = 10;
			addChild(orderBase);

			textOrder = new TextField(350, 25, "0", Assets.getFont("FontSSPRegular").fontName, 18, 0xFFFFFF);
			textOrder.pivotX = textOrder.width * 0.5;
			textOrder.pivotY = textOrder.height * 0.5;
			textOrder.x = 14;
			textOrder.y = 20;
			addChild(textOrder);

			textName = new TextField(300, 35, "0", Assets.getFont("FontSSPRegular").fontName, 17, 0xBC8458);
			textName.x = 72;
			textName.y = 10;
			textName.hAlign = HAlign.LEFT;
			textName.vAlign = VAlign.TOP;
			addChild(textName);

			textScore = new TextField(300, 35, "0", Assets.getFont("FontSSPBold").fontName, 20, 0xBC8458);
			textScore.pivotX = textScore.width * 0.5;
			textScore.pivotY = textScore.height * 0.5;
			textScore.x = 335;
			textScore.y = 35;
			addChild(textScore);
		}

		/**
		 * Set avatar texture image url.
		 * 
		 * @param texture
		 */
		public function set avatarTexture(texture:String):void
		{
			this.avatar = texture;
			
			// create the loader
			var loader:Loader = new Loader();

			// load the texture
			loader.load(new URLRequest(texture));

			// when texture is loaded
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);

			function onComplete(e:Event):void
			{
				// grab the loaded bitmap
				var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;

				// create a texture from the loaded bitmap
				var texture:Texture = Texture.fromBitmap(loadedBitmap);

				avatarImage.texture = texture;
			}
		}

		/**
		 * Set leaderboard order.
		 * 
		 * @param order
		 */
		public function set leaderOrder(order:uint):void
		{
			this.order = order;
		}

		/**
		 * Set leaderboard player name.
		 * 
		 * @param player
		 */
		public function set leaderPlayer(player:String):void
		{
			this.player = player;
		}

		/**
		 * Set leaderboard stars count.
		 * 
		 * @param star
		 */
		public function set leaderStar(star:uint):void
		{
			this.star = star;
		}

		/**
		 * Set leaderboard score.
		 * 
		 * @param score
		 */
		public function set leaderScore(score:uint):void
		{
			this.score = score;
		}

		/**
		 * 
		 * @return
		 */
		public function get avatarTexture():String
		{
			return this.avatar;
		}
		
		/**
		 * Get leaderboard order.
		 * 
		 * @return
		 */
		public function get leaderOrder():uint
		{
			return this.order;
		}

		/**
		 * Get player name.
		 * 
		 * @return
		 */
		public function get leaderPlayer():String
		{
			return this.player;
		}

		/**
		 * Get total stars.
		 * 
		 * @return
		 */
		public function get leaderStar():uint
		{
			return this.star;
		}

		/**
		 * Get leaderboard score.
		 * 
		 * @return
		 */
		public function get leaderScore():uint
		{
			return this.score;
		}

		/**
		 * Loop through the leaderboard list adapter.
		 */
		public function setup():void
		{
			textOrder.text = leaderOrder.toString();
			textName.text = leaderPlayer;
			textScore.text = ValueFormatter.format(leaderScore) + " PTS";

			var star:Image;
			for (var i:uint = 0; i < 5; i++)
			{
				if (i < leaderStar)
				{
					star = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star"));
				}
				else
				{
					star = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_base"));
				}
				star.x = (i * (star.width + 5)) + 76.9;
				star.y = 36;
				addChild(star);
			}
		}
	}
}
