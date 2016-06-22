package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	import sketchproject.core.Assets;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Show district information.
	 *
	 * @author Angga
	 */
	public class InfoDistrictDialog extends Sprite
	{
		private var overlay:Quad;
		private var preview:Image;
		private var district:TextField;
		private var description:TextField;
		private var distance:TextField;
		private var buttonPrimary:Button;

		/**
		 * Default constructor of InfoDistrictDialog.
		 */
		public function InfoDistrictDialog()
		{
			super();

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			overlay = new Quad(650, 200, 0xFFFFFF);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			addChild(overlay);

			preview = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("location_airport"));
			preview.x = -290;
			preview.y = -60;
			addChild(preview);

			district = new TextField(150, 50, "District", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 22, 0x333333);
			district.hAlign = HAlign.LEFT;
			district.vAlign = VAlign.TOP;
			district.x = -100;
			district.y = -75;
			addChild(district);

			description = new TextField(400, 75, "Description", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			description.hAlign = HAlign.LEFT;
			description.vAlign = VAlign.TOP;
			description.x = -100;
			description.y = -50;
			addChild(description);

			distance = new TextField(250, 50, "Distance", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			distance.hAlign = HAlign.LEFT;
			distance.vAlign = VAlign.TOP;
			distance.x = -100;
			distance.y = 30;
			addChild(distance);

			buttonPrimary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok_flat"));
			buttonPrimary.x = 140;
			buttonPrimary.y = 20;
			buttonPrimary.addEventListener(Event.TRIGGERED, function(event:Event):void {
				closeDialog();
			});
			addChild(buttonPrimary);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}

		/**
		 * Open / show district info dialog by passing district information.
		 * 
		 * @param district name
		 * @param description district info
		 * @param texture icon
		 * @param distance from shop
		 */
		public function openDialog(district:String, description:String, texture:String, distance:int):void
		{
			this.district.text = district;
			this.preview.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture);
			this.description.text = description;
			this.distance.text = "Distance from your shop " + distance;

			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					delay: 0.2
				}
			);
		}

		/**
		 * Close / hide district info dialog.
		 */
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			TweenMax.to(
				this, 
				0.5, 
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
	}
}
