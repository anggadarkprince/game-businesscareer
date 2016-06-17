package sketchproject.objects.loading
{
	import sketchproject.core.Assets;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.text.TextField;

	/**
	 * Display loading bar and progress animation.
	 *
	 * @author Angga
	 */
	public class GameLoader extends Sprite
	{
		private var background:Image;
		private var iconLoading:MovieClip;
		private var progressBar:Shape;
		private var progressInfo:TextField;

		private var progressValue:uint;
		private var progressWidth:Number

		/**
		 * Game loader sprite contructor.
		 */
		public function GameLoader()
		{
			progress = 0;

			background = new Image(Assets.getAtlas(Assets.BACKGROUND, Assets.BACKGROUND_XML).getTexture("preloading"));
			background.pivotX = background.width * 0.5;
			addChild(background);

			iconLoading = new MovieClip(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTextures("wonderland"), 15);
			iconLoading.pivotX = iconLoading.width * 0.5;
			iconLoading.pivotY = iconLoading.height;
			iconLoading.x = 100;
			iconLoading.y = 240;
			Starling.juggler.add(iconLoading);
			addChild(iconLoading);

			progressBar = new Shape();
			addChild(progressBar);

			progressInfo = new TextField(200, 50, "Loading " + progress + " %", Assets.getFont(Assets.FONT_SSBOLD).fontName, 25, 0xFFFFFF);
			progressInfo.color = 0xffffff;
			progressInfo.pivotX = progressInfo.width * 0.5;
			progressInfo.y = 300;
			progressInfo.visible = false;
			addChild(progressInfo);
		}

		/**
		 * Setter game loading progress.
		 *
		 * @params percent game loading precentage
		 * @return void
		 */
		public function set progress(percent:uint):void
		{
			progressValue = percent;
		}

		/**
		 * Getter progress precentage.
		 * 
		 * @return uint precentage value
		 */
		public function get progress():uint
		{
			return progressValue;
		}

		/**
		 * Update game loading bar and loading text.
		 * 
		 * @return void
		 */
		public function updateProgress():void
		{
			if (progressInfo.visible == false)
			{
				progressInfo.visible = true;
			}

			progress = ++progress;
			progressInfo.text = "Loading " + progress + " %";

			progressWidth = progress * 562 / 100;
			progressBar.graphics.clear();
			progressBar.graphics.beginFill(0xFFFFFF);
			progressBar.graphics.lineStyle(1, 0xFFFFFF, 0.5);
			progressBar.graphics.drawRoundRect(-this.width * 0.5 + 10, 260, progressWidth, 17, 20);
			progressBar.graphics.endFill();

			if (isLoaded())
			{
				progressInfo.visible = false;
			}
		}

		/**
		 * Check game load is done.
		 * 
		 * @return Boolean
		 */
		public function isLoaded():Boolean
		{
			if (progress >= 100)
			{
				progress = 100;
			}
			return progress == 100 ? true : false;
		}
	}
}
