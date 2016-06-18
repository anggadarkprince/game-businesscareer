package sketchproject.objects.world
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;

	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	/**
	 * Build controller to change avatar atributes.
	 * 
	 * @author Angga
	 */
	public class AvatarController extends Sprite
	{
		private static var instance:AvatarController;

		private var buttonRightGender:Button;
		private var buttonLeftGender:Button;

		private var buttonRightHair:Button;
		private var buttonLeftHair:Button;

		private var buttonRightSkin:Button;
		private var buttonLeftSkin:Button;

		private var buttonRightTop:Button;
		private var buttonLeftTop:Button;

		private var buttonRightBottom:Button;
		private var buttonLeftBottom:Button;

		private var dataCharacter:Array;

		private var labelAvatarDesign:TextField;

		private var selectGender:TextField;
		private var selectHair:TextField;
		private var selectSkin:TextField;
		private var selectTop:TextField;
		private var selectBottom:TextField;

		private var indexGender:uint;
		private var indexHair:uint;
		private var indexSkin:uint;
		private var indexTop:uint;
		private var indexBottom:uint;

		private var character:Avatar;

		/**
		 *
		 */
		public function AvatarController()
		{
			super();

			dataCharacter = new Array();
			dataCharacter["gender"] = ["Male", "Female"];
			dataCharacter["hair"] = ["Hair 1", "Hair 2", "Hair 3", "Hair 4", "Hair 5"];
			dataCharacter["skin"] = ["Skin 1", "Skin 2", "Skin 3"];
			dataCharacter["top"] = ["Top 1", "Top 2", "Top 3", "Top 4", "Top 5"];
			dataCharacter["bottom"] = ["Bottom 1", "Bottom 2", "Bottom 3", "Bottom 4", "Bottom 5"];

			indexGender = Data.avatar[0];
			indexHair = Data.avatar[1];
			indexSkin = Data.avatar[2];
			indexTop = Data.avatar[3];
			indexBottom = Data.avatar[4];

			/** character **/
			character = Avatar.getInstance();
			character.x = 5;
			character.y = 10;
			addChild(character);

			/** label control avatar **/
			labelAvatarDesign = new TextField(200, 50, "Gender", Assets.getFont("FontErasITC").fontName, 18, 0xc0251e);
			labelAvatarDesign.x = 210 - labelAvatarDesign.width * 0.5;
			labelAvatarDesign.y = -30;
			addChild(labelAvatarDesign);

			labelAvatarDesign = new TextField(200, 50, "Hair", Assets.getFont("FontErasITC").fontName, 18, 0xc0251e);
			labelAvatarDesign.x = 210 - labelAvatarDesign.width * 0.5;
			labelAvatarDesign.y = 30;
			addChild(labelAvatarDesign);

			labelAvatarDesign = new TextField(200, 50, "Skin", Assets.getFont("FontErasITC").fontName, 18, 0xc0251e);
			labelAvatarDesign.x = 210 - labelAvatarDesign.width * 0.5;
			labelAvatarDesign.y = 90;
			addChild(labelAvatarDesign);

			labelAvatarDesign = new TextField(200, 50, "Top", Assets.getFont("FontErasITC").fontName, 18, 0xc0251e);
			labelAvatarDesign.x = 210 - labelAvatarDesign.width * 0.5;
			labelAvatarDesign.y = 150;
			addChild(labelAvatarDesign);

			labelAvatarDesign = new TextField(200, 50, "Bottom", Assets.getFont("FontErasITC").fontName, 18, 0xc0251e);
			labelAvatarDesign.x = 210 - labelAvatarDesign.width * 0.5;
			labelAvatarDesign.y = 210;
			addChild(labelAvatarDesign);

			/** create background selected character attribute **/
			for (var i:uint = 0; i < 5; i++)
			{
				var backgroundSet:Quad = new Quad(100, 25, 0xCCCCCC);
				backgroundSet.x = 165;
				backgroundSet.y = i * 60 + 6;
				addChild(backgroundSet);
			}

			/** selected attribut character **/
			selectGender = new TextField(100, 25, dataCharacter["gender"][0].toString(), Assets.getFont("FontErasITC").fontName, 16, 0x333333);
			selectGender.x = 210 - selectGender.width * 0.5;
			selectGender.y = 7;
			addChild(selectGender);

			selectHair = new TextField(100, 25, dataCharacter["hair"][0].toString(), Assets.getFont("FontErasITC").fontName, 16, 0x333333);
			selectHair.x = 210 - selectGender.width * 0.5;
			selectHair.y = selectGender.y + 60;
			addChild(selectHair);

			selectSkin = new TextField(100, 25, dataCharacter["skin"][0].toString(), Assets.getFont("FontErasITC").fontName, 16, 0x333333);
			selectSkin.x = 210 - selectGender.width * 0.5;
			selectSkin.y = selectHair.y + 60;
			addChild(selectSkin);

			selectTop = new TextField(100, 25, dataCharacter["top"][0].toString(), Assets.getFont("FontErasITC").fontName, 16, 0x333333);
			selectTop.x = 210 - selectGender.width * 0.5;
			selectTop.y = selectSkin.y + 60;
			addChild(selectTop);

			selectBottom = new TextField(100, 25, dataCharacter["bottom"][0].toString(), Assets.getFont("FontErasITC").fontName, 16, 0x333333);
			selectBottom.x = 210 - selectGender.width * 0.5;
			selectBottom.y = selectTop.y + 60;
			addChild(selectBottom);

			/** button control character **/
			buttonRightGender = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightGender.x = 250;
			buttonRightGender.y = 3;
			addChild(buttonRightGender);

			buttonLeftGender = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftGender.x = 170;
			buttonLeftGender.y = 3;
			buttonLeftGender.scaleX = -1;
			addChild(buttonLeftGender);

			buttonRightHair = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightHair.x = 250;
			buttonRightHair.y = buttonRightGender.y + 60;
			addChild(buttonRightHair);

			buttonLeftHair = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftHair.x = 170;
			buttonLeftHair.y = buttonLeftGender.y + 60;
			buttonLeftHair.scaleX = -1;
			addChild(buttonLeftHair);

			buttonRightSkin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightSkin.x = 250;
			buttonRightSkin.y = buttonRightHair.y + 60;
			addChild(buttonRightSkin);

			buttonLeftSkin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftSkin.x = 170;
			buttonLeftSkin.y = buttonLeftHair.y + 60;
			buttonLeftSkin.scaleX = -1;
			addChild(buttonLeftSkin);

			buttonRightTop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightTop.x = 250;
			buttonRightTop.y = buttonRightSkin.y + 60;
			addChild(buttonRightTop);

			buttonLeftTop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftTop.x = 170;
			buttonLeftTop.y = buttonLeftSkin.y + 60;
			buttonLeftTop.scaleX = -1;
			addChild(buttonLeftTop);

			buttonRightBottom = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonRightBottom.x = 250;
			buttonRightBottom.y = buttonRightTop.y + 60;
			addChild(buttonRightBottom);

			buttonLeftBottom = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_arrow"));
			buttonLeftBottom.x = 170;
			buttonLeftBottom.y = buttonLeftTop.y + 60;
			buttonLeftBottom.scaleX = -1;
			addChild(buttonLeftBottom);

			addEventListener(TouchEvent.TOUCH, onTouch);

			setup();
		}

		/**
		 * Singleton avatar controller.
		 * 
		 * @return AvatarController
		 */
		public static function getInstance():AvatarController
		{
			if (instance == null)
			{
				instance = new AvatarController();
			}
			return instance;
		}

		/**
		 * Event handler when sprite touched.
		 * 
		 * @param touch
		 */
		private function onTouch(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonRightGender, TouchPhase.ENDED))
			{
				if (indexGender < dataCharacter["gender"].length - 1)
				{
					indexGender++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftGender, TouchPhase.ENDED))
			{
				if (indexGender > 0)
				{
					indexGender--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightHair, TouchPhase.ENDED))
			{
				if (indexHair < dataCharacter["hair"].length - 1)
				{
					indexHair++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftHair, TouchPhase.ENDED))
			{
				if (indexHair > 0)
				{
					indexHair--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightSkin, TouchPhase.ENDED))
			{
				if (indexSkin < dataCharacter["skin"].length - 1)
				{
					indexSkin++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonLeftSkin, TouchPhase.ENDED))
			{
				if (indexSkin > 0)
				{
					indexSkin--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightTop, TouchPhase.ENDED))
			{
				if (indexTop < dataCharacter["top"].length - 1)
				{
					indexTop++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftTop, TouchPhase.ENDED))
			{
				if (indexTop > 0)
				{
					indexTop--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			if (touch.getTouch(buttonRightBottom, TouchPhase.ENDED))
			{
				if (indexBottom < dataCharacter["bottom"].length - 1)
				{
					indexBottom++;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}
			if (touch.getTouch(buttonLeftBottom, TouchPhase.ENDED))
			{
				if (indexBottom > 0)
				{
					indexBottom--;
				}
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
			}

			setup();
		}

		/**
		 * Set info avatar sttributes and set the character.
		 */
		private function setup():void
		{
			selectGender.text = dataCharacter["gender"][indexGender];
			selectHair.text = dataCharacter["hair"][indexHair];
			selectSkin.text = dataCharacter["skin"][indexSkin];
			selectTop.text = dataCharacter["top"][indexTop];
			selectBottom.text = dataCharacter["bottom"][indexBottom];

			Data.avatar[0] = indexGender;
			Data.avatar[1] = indexHair;
			Data.avatar[2] = indexSkin;
			Data.avatar[3] = indexTop;
			Data.avatar[4] = indexBottom;

			character.updateAvatar();
		}
	}
}
