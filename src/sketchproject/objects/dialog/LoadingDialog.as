package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;

	/**
	 * Loading dialog to waiting server response or proccess.
	 *
	 * @author Angga
	 */
	public class LoadingDialog extends Sprite
	{
		private var overlay:Quad;
		private var label:TextField;
		private var iconAnimate:Image;

		/**
		 * Default constructor of LoadingDialog.
		 */
		public function LoadingDialog()
		{
			super();

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			iconAnimate = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("focus_circle"));
			iconAnimate.pivotX = iconAnimate.width * 0.5;
			iconAnimate.pivotY = iconAnimate.height * 0.5;
			iconAnimate.y = -30;
			addChild(iconAnimate);

			label = new TextField(170, 50, "PLEASE WAIT", Assets.getFont(Assets.FONT_SSBOLD).fontName, 22, 0xFFFFFF);
			label.pivotX = label.width * 0.5;
			label.y = 50;
			addChild(label);

			hide();
		}

		/**
		 * Update circle icon rotation.
		 */
		public function update():void
		{
			iconAnimate.rotation += 0.2;
		}

		/**
		 * Show loading dialog
		 */
		public function show():void
		{
			visible = true;
		}

		/**
		 * Hide loading dialog.
		 */
		public function hide():void
		{
			visible = false;
		}
	}
}
