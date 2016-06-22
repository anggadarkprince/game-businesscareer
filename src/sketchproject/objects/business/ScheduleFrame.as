package sketchproject.objects.business
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.managers.DataManager;

	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Configure schedule open and close shop.
	 * 
	 * @author Angga
	 */
	public class ScheduleFrame extends Sprite
	{
		private var label:TextField;
		private var baseTimeline:Quad;

		private var timelineSunday:Quad;
		private var timelineMonday:Quad;
		private var timelineTuesday:Quad;
		private var timelineWednesday:Quad;
		private var timelineThursday:Quad;
		private var timelineFriday:Quad;
		private var timelineSaturday:Quad;

		private var openAddSunday:Button;
		private var openSubtractSunday:Button;
		private var openAddMonday:Button;
		private var openSubtractMonday:Button;
		private var openAddTuesday:Button;
		private var openSubtractTuesday:Button;
		private var openAddWednesday:Button;
		private var openSubtractWednesday:Button;
		private var openAddThursday:Button;
		private var openSubtractThursday:Button;
		private var openAddFriday:Button;
		private var openSubtractFriday:Button;
		private var openAddSaturday:Button;
		private var openSubtractSaturday:Button;

		private var closeAddSunday:Button;
		private var closeSubtractSunday:Button;
		private var closeAddMonday:Button;
		private var closeSubtractMonday:Button;
		private var closeAddTuesday:Button;
		private var closeSubtractTuesday:Button;
		private var closeAddWednesday:Button;
		private var closeSubtractWednesday:Button;
		private var closeAddThursday:Button;
		private var closeSubtractThursday:Button;
		private var closeAddFriday:Button;
		private var closeSubtractFriday:Button;
		private var closeAddSaturday:Button;
		private var closeSubtractSaturday:Button;

		private var openSunday:TextField;
		private var openMonday:TextField;
		private var openTuesday:TextField;
		private var openWednesday:TextField;
		private var openThursday:TextField;
		private var openFriday:TextField;
		private var openSaturday:TextField;

		private var closeSunday:TextField;
		private var closeMonday:TextField;
		private var closeTuesday:TextField;
		private var closeWednesday:TextField;
		private var closeThursday:TextField;
		private var closeFriday:TextField;
		private var closeSaturday:TextField;

		private var timelineWidth:Number;
		private var timelineStep:Number;

		private var timelineContainer:Sprite;
		private var save:DataManager;

		/**
		 * Default constructor of ScheduleFrame.
		 */
		public function ScheduleFrame()
		{
			super();

			save = new DataManager();

			timelineWidth = 500;
			timelineStep = timelineWidth / 24;

			label = new TextField(250, 50, "Operation Hours", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -435;
			label.y = -220;
			addChild(label);

			label = new TextField(165, 50, "Set the hours of operation by rolling over each day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -435;
			label.y = -184.55;
			addChild(label);

			label = new TextField(80, 50, "AM/PM", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.RIGHT;
			label.x = -270;
			label.y = -199.8;
			addChild(label);

			label = new TextField(700, 50, "01  02  03  04  05  06  07  08  09  10  11  12 01  02  03  04  05  06  07  08  09  10  11  12", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -177;
			label.y = -198;
			addChild(label);

			label = new TextField(80, 50, "24 HRS", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.RIGHT;
			label.x = -270;
			label.y = -171.85;
			addChild(label);

			label = new TextField(700, 50, "01  02  03  04  05  06  07  08  09  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -177;
			label.y = -170;
			addChild(label);

			label = new TextField(250, 50, "Days", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -435;
			label.y = -131.85;
			addChild(label);

			label = new TextField(100, 50, "OPEN", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.CENTER;
			label.x = -294.75;
			label.y = -131.85;
			addChild(label);

			label = new TextField(250, 50, "BUSINESS OPERATION", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 0;
			label.y = -131.85;
			addChild(label);

			label = new TextField(100, 50, "CLOSE", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.CENTER;
			label.x = 332;
			label.y = -131.85;
			addChild(label);

			label = new TextField(250, 50, "Sunday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = -102.45;
			addChild(label);

			label = new TextField(250, 50, "Monday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = -77.35;
			addChild(label);

			label = new TextField(250, 50, "Tuesday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = -52.25;
			addChild(label);

			label = new TextField(250, 50, "Wednesday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = -27.15;
			addChild(label);

			label = new TextField(250, 50, "Thursday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = -2.05;
			addChild(label);

			label = new TextField(250, 50, "Friday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = 23.05;
			addChild(label);

			label = new TextField(250, 50, "Saturday", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -420;
			label.y = 48.15;
			addChild(label);

			// open sunday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = -97.7;
			addChild(baseTimeline);

			openSunday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openSunday.pivotX = openSunday.width * 0.5;
			openSunday.pivotY = openSunday.height * 0.5;
			openSunday.x = -244.4;
			openSunday.y = -87.85;
			addChild(openSunday);

			openAddSunday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddSunday.pivotX = openAddSunday.width * 0.5;
			openAddSunday.pivotY = openAddSunday.height * 0.5;
			openAddSunday.x = -217.65;
			openAddSunday.y = -87.85;
			openAddSunday.scaleX = 0.8;
			openAddSunday.scaleY = 0.8;
			addChild(openAddSunday);

			openSubtractSunday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractSunday.pivotX = openSubtractSunday.width * 0.5;
			openSubtractSunday.pivotY = openSubtractSunday.height * 0.5;
			openSubtractSunday.x = -270.1;
			openSubtractSunday.y = -87.85;
			openSubtractSunday.scaleX = 0.8;
			openSubtractSunday.scaleY = 0.8;
			addChild(openSubtractSunday);

			// timeline sunday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = -97.7;
			addChild(baseTimeline);

			// close sunday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = -97.7;
			addChild(baseTimeline);

			closeSunday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeSunday.pivotX = closeSunday.width * 0.5;
			closeSunday.pivotY = closeSunday.height * 0.5;
			closeSunday.x = 385.6;
			closeSunday.y = -87.85;
			addChild(closeSunday);

			closeAddSunday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddSunday.pivotX = closeAddSunday.width * 0.5;
			closeAddSunday.pivotY = closeAddSunday.height * 0.5;
			closeAddSunday.x = 412.35;
			closeAddSunday.y = -87.85;
			closeAddSunday.scaleX = 0.8;
			closeAddSunday.scaleY = 0.8;
			addChild(closeAddSunday);

			closeSubtractSunday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractSunday.pivotX = closeSubtractSunday.width * 0.5;
			closeSubtractSunday.pivotY = closeSubtractSunday.height * 0.5;
			closeSubtractSunday.x = 359.9;
			closeSubtractSunday.y = -87.85;
			closeSubtractSunday.scaleX = 0.8;
			closeSubtractSunday.scaleY = 0.8;
			addChild(closeSubtractSunday);

			// open monday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = -73.1;
			addChild(baseTimeline);

			openMonday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openMonday.pivotX = openMonday.width * 0.5;
			openMonday.pivotY = openMonday.height * 0.5;
			openMonday.x = -244.4;
			openMonday.y = -62.7;
			addChild(openMonday);

			openAddMonday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddMonday.pivotX = openAddMonday.width * 0.5;
			openAddMonday.pivotY = openAddMonday.height * 0.5;
			openAddMonday.x = -217.65;
			openAddMonday.y = -62.7;
			openAddMonday.scaleX = 0.8;
			openAddMonday.scaleY = 0.8;
			addChild(openAddMonday);

			openSubtractMonday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractMonday.pivotX = openSubtractMonday.width * 0.5;
			openSubtractMonday.pivotY = openSubtractMonday.height * 0.5;
			openSubtractMonday.x = -270.1;
			openSubtractMonday.y = -62.7;
			openSubtractMonday.scaleX = 0.8;
			openSubtractMonday.scaleY = 0.8;
			addChild(openSubtractMonday);

			// timeline monday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = -73.1;
			addChild(baseTimeline);

			// close monday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = -73.1;
			addChild(baseTimeline);

			closeMonday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeMonday.pivotX = closeMonday.width * 0.5;
			closeMonday.pivotY = closeMonday.height * 0.5;
			closeMonday.x = 385.6;
			closeMonday.y = -62.7;
			addChild(closeMonday);

			closeAddMonday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddMonday.pivotX = closeAddMonday.width * 0.5;
			closeAddMonday.pivotY = closeAddMonday.height * 0.5;
			closeAddMonday.x = 412.35;
			closeAddMonday.y = -62.7;
			closeAddMonday.scaleX = 0.8;
			closeAddMonday.scaleY = 0.8;
			addChild(closeAddMonday);

			closeSubtractMonday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractMonday.pivotX = closeSubtractMonday.width * 0.5;
			closeSubtractMonday.pivotY = closeSubtractMonday.height * 0.5;
			closeSubtractMonday.x = 359.9;
			closeSubtractMonday.y = -62.7;
			closeSubtractMonday.scaleX = 0.8;
			closeSubtractMonday.scaleY = 0.8;
			addChild(closeSubtractMonday);

			// open tuesday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = -47.9;
			addChild(baseTimeline);

			openTuesday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openTuesday.pivotX = openTuesday.width * 0.5;
			openTuesday.pivotY = openTuesday.height * 0.5;
			openTuesday.x = -244.4;
			openTuesday.y = -37.5;
			addChild(openTuesday);

			openAddTuesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddTuesday.pivotX = openAddTuesday.width * 0.5;
			openAddTuesday.pivotY = openAddTuesday.height * 0.5;
			openAddTuesday.x = -217.65;
			openAddTuesday.y = -37.5;
			openAddTuesday.scaleX = 0.8;
			openAddTuesday.scaleY = 0.8;
			addChild(openAddTuesday);

			openSubtractTuesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractTuesday.pivotX = openSubtractTuesday.width * 0.5;
			openSubtractTuesday.pivotY = openSubtractTuesday.height * 0.5;
			openSubtractTuesday.x = -270.1;
			openSubtractTuesday.y = -37.5;
			openSubtractTuesday.scaleX = 0.8;
			openSubtractTuesday.scaleY = 0.8;
			addChild(openSubtractTuesday);

			// timeline tuesday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = -47.9;
			addChild(baseTimeline);

			// close tuesday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = -47.9;
			addChild(baseTimeline);

			closeTuesday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeTuesday.pivotX = closeTuesday.width * 0.5;
			closeTuesday.pivotY = closeTuesday.height * 0.5;
			closeTuesday.x = 385.6;
			closeTuesday.y = -37.5;
			addChild(closeTuesday);

			closeAddTuesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddTuesday.pivotX = closeAddTuesday.width * 0.5;
			closeAddTuesday.pivotY = closeAddTuesday.height * 0.5;
			closeAddTuesday.x = 412.35;
			closeAddTuesday.y = -37.5;
			closeAddTuesday.scaleX = 0.8;
			closeAddTuesday.scaleY = 0.8;
			addChild(closeAddTuesday);

			closeSubtractTuesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractTuesday.pivotX = closeSubtractTuesday.width * 0.5;
			closeSubtractTuesday.pivotY = closeSubtractTuesday.height * 0.5;
			closeSubtractTuesday.x = 359.9;
			closeSubtractTuesday.y = -37.5;
			closeSubtractTuesday.scaleX = 0.8;
			closeSubtractTuesday.scaleY = 0.8;
			addChild(closeSubtractTuesday);

			// open wednesday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = -22.7;
			addChild(baseTimeline);

			openWednesday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openWednesday.pivotX = openWednesday.width * 0.5;
			openWednesday.pivotY = openWednesday.height * 0.5;
			openWednesday.x = -244.4;
			openWednesday.y = -12.3;
			addChild(openWednesday);

			openAddWednesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddWednesday.pivotX = openAddWednesday.width * 0.5;
			openAddWednesday.pivotY = openAddWednesday.height * 0.5;
			openAddWednesday.x = -217.65;
			openAddWednesday.y = -12.3;
			openAddWednesday.scaleX = 0.8;
			openAddWednesday.scaleY = 0.8;
			addChild(openAddWednesday);

			openSubtractWednesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractWednesday.pivotX = openSubtractWednesday.width * 0.5;
			openSubtractWednesday.pivotY = openSubtractWednesday.height * 0.5;
			openSubtractWednesday.x = -270.1;
			openSubtractWednesday.y = -12.3;
			openSubtractWednesday.scaleX = 0.8;
			openSubtractWednesday.scaleY = 0.8;
			addChild(openSubtractWednesday);

			// timeline wednesday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = -22.7;
			addChild(baseTimeline);

			// close wednesday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = -22.7;
			addChild(baseTimeline);

			closeWednesday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeWednesday.pivotX = closeWednesday.width * 0.5;
			closeWednesday.pivotY = closeWednesday.height * 0.5;
			closeWednesday.x = 385.6;
			closeWednesday.y = -12.3;
			addChild(closeWednesday);

			closeAddWednesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddWednesday.pivotX = closeAddWednesday.width * 0.5;
			closeAddWednesday.pivotY = closeAddWednesday.height * 0.5;
			closeAddWednesday.x = 412.35;
			closeAddWednesday.y = -12.3;
			closeAddWednesday.scaleX = 0.8;
			closeAddWednesday.scaleY = 0.8;
			addChild(closeAddWednesday);

			closeSubtractWednesday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractWednesday.pivotX = closeSubtractWednesday.width * 0.5;
			closeSubtractWednesday.pivotY = closeSubtractWednesday.height * 0.5;
			closeSubtractWednesday.x = 359.9;
			closeSubtractWednesday.y = -12.3;
			closeSubtractWednesday.scaleX = 0.8;
			closeSubtractWednesday.scaleY = 0.8;
			addChild(closeSubtractWednesday);

			// open thursday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = 2.5;
			addChild(baseTimeline);

			openThursday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openThursday.pivotX = openThursday.width * 0.5;
			openThursday.pivotY = openThursday.height * 0.5;
			openThursday.x = -244.4;
			openThursday.y = 12.9;
			addChild(openThursday);

			openAddThursday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddThursday.pivotX = openAddThursday.width * 0.5;
			openAddThursday.pivotY = openAddThursday.height * 0.5;
			openAddThursday.x = -217.65;
			openAddThursday.y = 12.9;
			openAddThursday.scaleX = 0.8;
			openAddThursday.scaleY = 0.8;
			addChild(openAddThursday);

			openSubtractThursday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractThursday.pivotX = openSubtractThursday.width * 0.5;
			openSubtractThursday.pivotY = openSubtractThursday.height * 0.5;
			openSubtractThursday.x = -270.1;
			openSubtractThursday.y = 12.9;
			openSubtractThursday.scaleX = 0.8;
			openSubtractThursday.scaleY = 0.8;
			addChild(openSubtractThursday);

			// timeline thursday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = 2.5;
			addChild(baseTimeline);

			// close thursday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = 2.5;
			addChild(baseTimeline);

			closeThursday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeThursday.pivotX = closeThursday.width * 0.5;
			closeThursday.pivotY = closeThursday.height * 0.5;
			closeThursday.x = 385.6;
			closeThursday.y = 12.9;
			addChild(closeThursday);

			closeAddThursday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddThursday.pivotX = closeAddThursday.width * 0.5;
			closeAddThursday.pivotY = closeAddThursday.height * 0.5;
			closeAddThursday.x = 412.35;
			closeAddThursday.y = 12.9;
			closeAddThursday.scaleX = 0.8;
			closeAddThursday.scaleY = 0.8;
			addChild(closeAddThursday);

			closeSubtractThursday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractThursday.pivotX = closeSubtractThursday.width * 0.5;
			closeSubtractThursday.pivotY = closeSubtractThursday.height * 0.5;
			closeSubtractThursday.x = 359.9;
			closeSubtractThursday.y = 12.9;
			closeSubtractThursday.scaleX = 0.8;
			closeSubtractThursday.scaleY = 0.8;
			addChild(closeSubtractThursday);

			// open friday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = 28.3;
			addChild(baseTimeline);

			openFriday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openFriday.pivotX = openFriday.width * 0.5;
			openFriday.pivotY = openFriday.height * 0.5;
			openFriday.x = -244.4;
			openFriday.y = 38.05;
			addChild(openFriday);

			openAddFriday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddFriday.pivotX = openAddFriday.width * 0.5;
			openAddFriday.pivotY = openAddFriday.height * 0.5;
			openAddFriday.x = -217.65;
			openAddFriday.y = 38.05;
			openAddFriday.scaleX = 0.8;
			openAddFriday.scaleY = 0.8;
			addChild(openAddFriday);

			openSubtractFriday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractFriday.pivotX = openSubtractFriday.width * 0.5;
			openSubtractFriday.pivotY = openSubtractFriday.height * 0.5;
			openSubtractFriday.x = -270.1;
			openSubtractFriday.y = 38.05;
			openSubtractFriday.scaleX = 0.8;
			openSubtractFriday.scaleY = 0.8;
			addChild(openSubtractFriday);

			// timeline friday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = 28.3;
			addChild(baseTimeline);

			// close friday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = 28.3;
			addChild(baseTimeline);

			closeFriday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeFriday.pivotX = closeFriday.width * 0.5;
			closeFriday.pivotY = closeFriday.height * 0.5;
			closeFriday.x = 385.6;
			closeFriday.y = 38.05;
			addChild(closeFriday);

			closeAddFriday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddFriday.pivotX = closeAddFriday.width * 0.5;
			closeAddFriday.pivotY = closeAddFriday.height * 0.5;
			closeAddFriday.x = 412.35;
			closeAddFriday.y = 38.05;
			closeAddFriday.scaleX = 0.8;
			closeAddFriday.scaleY = 0.8;
			addChild(closeAddFriday);

			closeSubtractFriday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractFriday.pivotX = closeSubtractFriday.width * 0.5;
			closeSubtractFriday.pivotY = closeSubtractFriday.height * 0.5;
			closeSubtractFriday.x = 359.9;
			closeSubtractFriday.y = 38.05;
			closeSubtractFriday.scaleX = 0.8;
			closeSubtractFriday.scaleY = 0.8;
			addChild(closeSubtractFriday);

			// open saturday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = -265.65;
			baseTimeline.y = 53.5;
			addChild(baseTimeline);

			openSaturday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			openSaturday.pivotX = openSaturday.width * 0.5;
			openSaturday.pivotY = openSaturday.height * 0.5;
			openSaturday.x = -244.4;
			openSaturday.y = 63.2;
			addChild(openSaturday);

			openAddSaturday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			openAddSaturday.pivotX = openAddSaturday.width * 0.5;
			openAddSaturday.pivotY = openAddSaturday.height * 0.5;
			openAddSaturday.x = -217.65;
			openAddSaturday.y = 63.2;
			openAddSaturday.scaleX = 0.8;
			openAddSaturday.scaleY = 0.8;
			addChild(openAddSaturday);

			openSubtractSaturday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			openSubtractSaturday.pivotX = openSubtractSaturday.width * 0.5;
			openSubtractSaturday.pivotY = openSubtractSaturday.height * 0.5;
			openSubtractSaturday.x = -270.1;
			openSubtractSaturday.y = 63.2;
			openSubtractSaturday.scaleX = 0.8;
			openSubtractSaturday.scaleY = 0.8;
			addChild(openSubtractSaturday);

			// timeline saturday
			baseTimeline = new Quad(500, 20);
			baseTimeline.x = -175;
			baseTimeline.y = 53.5;
			addChild(baseTimeline);

			// close saturday
			baseTimeline = new Quad(45, 20);
			baseTimeline.x = 364.35;
			baseTimeline.y = 53.5;
			addChild(baseTimeline);

			closeSaturday = new TextField(50, 30, "23", Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xA92922);
			closeSaturday.pivotX = closeSaturday.width * 0.5;
			closeSaturday.pivotY = closeSaturday.height * 0.5;
			closeSaturday.x = 385.6;
			closeSaturday.y = 63.2;
			addChild(closeSaturday);

			closeAddSaturday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_plus"));
			closeAddSaturday.pivotX = closeAddSaturday.width * 0.5;
			closeAddSaturday.pivotY = closeAddSaturday.height * 0.5;
			closeAddSaturday.x = 412.35;
			closeAddSaturday.y = 63.2;
			closeAddSaturday.scaleX = 0.8;
			closeAddSaturday.scaleY = 0.8;
			addChild(closeAddSaturday);

			closeSubtractSaturday = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_min"));
			closeSubtractSaturday.pivotX = closeSubtractSaturday.width * 0.5;
			closeSubtractSaturday.pivotY = closeSubtractSaturday.height * 0.5;
			closeSubtractSaturday.x = 359.9;
			closeSubtractSaturday.y = 63.2;
			closeSubtractSaturday.scaleX = 0.8;
			closeSubtractSaturday.scaleY = 0.8;
			addChild(closeSubtractSaturday);

			timelineSunday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineSunday);
			timelineMonday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineMonday);
			timelineTuesday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineTuesday);
			timelineWednesday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineWednesday);
			timelineThursday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineThursday);
			timelineFriday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineFriday);
			timelineSaturday = new Quad(100, 20, 0xeb4a42);
			addChild(timelineSaturday);

			updateTimeline();

			addEventListener(TouchEvent.TOUCH, onAdjustingSchedule);

		}

		/**
		 * Adjust schedule time, increasing or decreading the clock.
		 * 
		 * @param touch
		 */
		private function onAdjustingSchedule(touch:TouchEvent):void
		{
			// open
			if (touch.getTouch(openAddSunday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[0][0] + 1) < Data.schedule[0][1])
				{
					Data.schedule[0][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractSunday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[0][0] - 1) >= 0)
				{
					Data.schedule[0][0]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(openAddMonday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[1][0] + 1) < Data.schedule[1][1])
				{
					Data.schedule[1][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractMonday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[1][0] - 1) >= 0)
				{
					Data.schedule[1][0]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(openAddTuesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[2][0] + 1) < Data.schedule[2][1])
				{
					Data.schedule[2][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractTuesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[2][0] - 1) >= 0)
				{
					Data.schedule[2][0]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(openAddWednesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[3][0] + 1) < Data.schedule[3][1])
				{
					Data.schedule[3][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractWednesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[3][0] - 1) >= 0)
				{
					Data.schedule[3][0]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(openAddThursday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[4][0] + 1) < Data.schedule[4][1])
				{
					Data.schedule[4][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractThursday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[4][0] - 1) >= 0)
				{
					Data.schedule[4][0]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(openAddFriday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[5][0] + 1) < Data.schedule[5][1])
				{
					Data.schedule[5][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractFriday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[5][0] - 1) >= 0)
				{
					Data.schedule[5][0]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(openAddSaturday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[6][0] + 1) < Data.schedule[6][1])
				{
					Data.schedule[6][0]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(openSubtractSaturday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[6][0] - 1) >= 0)
				{
					Data.schedule[6][0]--;
					updateTimeline();
				}
			}

			// close
			if (touch.getTouch(closeAddSunday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[0][1] + 1) <= 24)
				{
					Data.schedule[0][1]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(closeSubtractSunday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[0][1] - 1) > Data.schedule[0][0])
				{
					Data.schedule[0][1]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(closeAddMonday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[1][1] + 1) <= 24)
				{
					Data.schedule[1][1]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(closeSubtractMonday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[1][1] - 1) > Data.schedule[1][0])
				{
					Data.schedule[1][1]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(closeAddTuesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[2][1] + 1) <= 24)
				{
					Data.schedule[2][1]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(closeSubtractTuesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[2][1] - 1) > Data.schedule[2][0])
				{
					Data.schedule[2][1]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(closeAddWednesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[3][1] + 1) <= 24)
				{
					Data.schedule[3][1]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(closeSubtractWednesday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[3][1] - 1) > Data.schedule[3][0])
				{
					Data.schedule[3][1]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(closeAddThursday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[4][1] + 1) <= 24)
				{
					Data.schedule[4][1]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(closeSubtractThursday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[4][1] - 1) > Data.schedule[4][0])
				{
					Data.schedule[4][1]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(closeAddFriday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[5][1] + 1) <= 24)
				{
					Data.schedule[5][1]++;
					updateTimeline()
				}
			}
			if (touch.getTouch(closeSubtractFriday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[5][1] - 1) > Data.schedule[5][0])
				{
					Data.schedule[5][1]--;
					updateTimeline();
				}
			}

			if (touch.getTouch(closeAddSaturday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[6][1] + 1) <= 24)
				{
					Data.schedule[6][1]++;
					updateTimeline();
				}
			}
			if (touch.getTouch(closeSubtractSaturday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				if ((Data.schedule[6][1] - 1) > Data.schedule[6][0])
				{
					Data.schedule[6][1]--;
					updateTimeline();
				}
			}
		}

		/**
		 * Update timeline width depends on schedule value.
		 */
		public function updateTimeline():void
		{
			openSunday.text = Data.schedule[0][0];
			closeSunday.text = Data.schedule[0][1];

			openMonday.text = Data.schedule[1][0];
			closeMonday.text = Data.schedule[1][1];

			openTuesday.text = Data.schedule[2][0];
			closeTuesday.text = Data.schedule[2][1];

			openWednesday.text = Data.schedule[3][0];
			closeWednesday.text = Data.schedule[3][1];

			openThursday.text = Data.schedule[4][0];
			closeThursday.text = Data.schedule[4][1];

			openFriday.text = Data.schedule[5][0];
			closeFriday.text = Data.schedule[5][1];

			openSaturday.text = Data.schedule[6][0];
			closeSaturday.text = Data.schedule[6][1];

			timelineSunday.width = timelineStep * (Data.schedule[0][1] - Data.schedule[0][0]);
			timelineSunday.x = -175 + timelineStep * Data.schedule[0][0];
			timelineSunday.y = -97.7 + (25.2 * 0);

			timelineMonday.width = timelineStep * (Data.schedule[1][1] - Data.schedule[1][0]);
			timelineMonday.x = -175 + timelineStep * Data.schedule[1][0];
			timelineMonday.y = -97.7 + (25.2 * 1);

			timelineTuesday.width = timelineStep * (Data.schedule[2][1] - Data.schedule[2][0]);
			timelineTuesday.x = -175 + timelineStep * Data.schedule[2][0];
			timelineTuesday.y = -97.7 + (25.2 * 2);

			timelineWednesday.width = timelineStep * (Data.schedule[3][1] - Data.schedule[3][0]);
			timelineWednesday.x = -175 + timelineStep * Data.schedule[3][0];
			timelineWednesday.y = -97.7 + (25.2 * 3);

			timelineThursday.width = timelineStep * (Data.schedule[4][1] - Data.schedule[4][0]);
			timelineThursday.x = -175 + timelineStep * Data.schedule[4][0];
			timelineThursday.y = -97.7 + (25.2 * 4);

			timelineFriday.width = timelineStep * (Data.schedule[5][1] - Data.schedule[5][0]);
			timelineFriday.x = -175 + timelineStep * Data.schedule[5][0];
			timelineFriday.y = -97.7 + (25.2 * 5);

			timelineSaturday.width = timelineStep * (Data.schedule[6][1] - Data.schedule[6][0]);
			timelineSaturday.x = -175 + timelineStep * Data.schedule[6][0];
			timelineSaturday.y = -97.7 + (25.2 * 6);

			save.saveGameData();
		}
	}
}
