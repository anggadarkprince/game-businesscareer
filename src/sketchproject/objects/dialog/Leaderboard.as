package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.adapter.LeaderboardAdapter;
	import sketchproject.utilities.ValueFormatter;

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

	/**
	 * Show global rangking in the world.
	 *
	 * @author Angga
	 */
	public class Leaderboard extends Sprite implements IDialog
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var dialogTitle:Image;
		private var buttonClose:Button;
		private var titleDialog:TextField;

		private var textMyScore:TextField;
		private var textMyName:TextField;
		private var textMyPosition:TextField;

		private var avatarBase:Image;
		private var avatarImage:Image;
		private var server:ServerManager;

		private var dataGlobal:Array;
		private var dataPlayer:Object;

		private var listContainer:Sprite;
		private var starContainer:Sprite;

		private var fireworkManager:FireworkManager;

		private var loader:Loader;

		/**
		 * Default constructor of Leaderboard.
		 */
		public function Leaderboard()
		{
			super();
			initObjectProperty();
		}

		/**
		 * Initializing leaderboard component.
		 */
		public function initObjectProperty():void
		{
			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onCompleteLoadPlayerAvatar);

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_flat_small"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);

			listContainer = new Sprite();
			addChild(listContainer);

			starContainer = new Sprite();
			addChild(starContainer);

			titleDialog = new TextField(170, 50, "LEADERBOARD", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0xFFFFFF);
			titleDialog.pivotX = titleDialog.width * 0.5;
			titleDialog.y = -250;
			addChild(titleDialog);

			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.addEventListener(starling.events.Event.TRIGGERED, onPrimaryTrigerred);
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = 200;
			buttonClose.y = -223;
			addChild(buttonClose);

			avatarBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("avatar_wrapper"));
			avatarBase.x = -200;
			avatarBase.y = -180;
			addChild(avatarBase);

			avatarImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("avatar_wrapper"));
			avatarImage.width = 47;
			avatarImage.height = 47;
			avatarImage.x = -200;
			avatarImage.y = -180;
			addChild(avatarImage);

			textMyPosition = new TextField(300, 35, "You at 25th Position", Assets.getFont("FontSSPRegular").fontName, 22, 0xBC8458);
			textMyPosition.x = -135;
			textMyPosition.y = -183;
			textMyPosition.hAlign = HAlign.LEFT;
			textMyPosition.vAlign = VAlign.TOP;
			addChild(textMyPosition);

			titleDialog = new TextField(300, 35, "Global World Ranking", Assets.getFont("FontSSPRegular").fontName, 18, 0xBC8458);
			titleDialog.x = -135;
			titleDialog.y = -158;
			titleDialog.hAlign = HAlign.LEFT;
			titleDialog.vAlign = VAlign.TOP;
			addChild(titleDialog);

			textMyScore = new TextField(300, 35, ValueFormatter.format(Data.point) + " PTS", Assets.getFont("FontSSPRegular").fontName, 23, 0xBC8458);
			textMyScore.pivotX = textMyScore.width;
			textMyScore.x = 200;
			textMyScore.y = -183;
			textMyScore.hAlign = HAlign.RIGHT;
			textMyScore.vAlign = VAlign.TOP;
			addChild(textMyScore);

			var gameObject:Object = new Object();
			gameObject.token = Data.key;
			server = new ServerManager("leaderboard/retrieve_leaderboard", gameObject);
			server.addEventListener(ServerManager.READY, onRetrieveCompleted);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}

		/**
		 * Retrieve data from server complete and ready.
		 *
		 * @param event
		 */
		private function onRetrieveCompleted(event:flash.events.Event):void
		{
			Game.loadingScreen.hide();
			dataPlayer = JSON.parse(server.received.leaderboard_player_var) as Object;
			dataGlobal = JSON.parse(server.received.leaderboard_global_var) as Array;

			if (dataPlayer != null && dataGlobal != null)
			{
				var ordinal:String = "th";
				if (dataPlayer.ranking == 1)
				{
					ordinal = "st";
				}
				else if (dataPlayer.ranking == 2)
				{
					ordinal = "nd";
				}
				else if (dataPlayer.ranking == 3)
				{
					ordinal = "rd";
				}
				textMyPosition.text = "You at " + dataPlayer.ranking + ordinal + " Position";
				textMyScore.text = ValueFormatter.format(dataPlayer.gme_point) + " PTS";

				Data.worldRank = dataPlayer.ranking;

				loader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/images/avatar/" + dataPlayer.ply_avatar));

				starContainer.removeChildren();
				var star:Image;
				for (var i:uint = 0; i < 5; i++)
				{
					if (i < Data.stars)
					{
						star = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star"));
					}
					else
					{
						star = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_base"));
					}
					star.x = (i * (star.width + 5)) + 102.8;
					star.y = -150;
					starContainer.addChild(star);
				}

				listContainer.removeChildren();
				for (var j:uint = 0; j < dataGlobal.length; j++)
				{
					var leader:LeaderboardAdapter = new LeaderboardAdapter();
					leader.leaderPlayer = dataGlobal[j].ply_name;
					leader.leaderOrder = dataGlobal[j].ranking;
					leader.leaderStar = dataGlobal[j].star;
					leader.leaderScore = dataGlobal[j].gme_point;
					leader.avatarTexture = ServerManager.SERVER_HOST + "assets/images/avatar/" + dataGlobal[j].ply_avatar;
					leader.setup();
					leader.x = -215;
					leader.y = (j * (leader.height + 2)) - 110;
					listContainer.addChild(leader);
				}
			}
		}

		/**
		 * Load data avatar as bitmap and put into texture.
		 * 
		 * @param e loader event
		 */
		private function onCompleteLoadPlayerAvatar(e:flash.events.Event):void
		{
			// grab the loaded bitmap
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;

			// create a texture from the loaded bitmap
			var texture:Texture = Texture.fromBitmap(loadedBitmap);

			avatarImage.texture = texture;
		}

		/**
		 * Open leaderboard dialog and send server request.
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 0.9, 
					scaleY: 0.9, 
					alpha: 1, 
					delay: 0.2, 
					onComplete: function():void {
						server.sendRequest();
						Game.loadingScreen.show();
					}
				}
			);
		}

		/**
		 * Close and hide leaderboard dialog
		 */
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			TweenMax.to(
				this, 0.5, 
				{
					ease: Back.easeIn, 
					scaleX: 0.5, 
					scaleY: 0.5, 
					alpha: 0, 
					delay: 0.2, 
					onComplete: function():void {
						visible = false;
					}
				}
			);
		}

		/**
		 *
		 * @param event
		 */
		public function onPrimaryTrigerred(event:starling.events.Event):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			closeDialog();
		}

	}
}
