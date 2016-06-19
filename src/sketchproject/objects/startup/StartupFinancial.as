package sketchproject.objects.startup
{
	import feathers.controls.PickerList;
	import feathers.data.ListCollection;

	import sketchproject.core.Assets;
	import sketchproject.core.Data;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Setting seed financial of business.
	 * 
	 * @author Angga
	 */
	public class StartupFinancial extends Sprite
	{
		private var text:TextField;
		private var line:Quad;
		private var listSeed:PickerList;

		/**
		 * Default constructor of StartupFinancial
		 */
		public function StartupFinancial()
		{
			super();
			initObjectProperty();
		}

		/**
		 * Initialize financial component.
		 */
		public function initObjectProperty():void
		{
			text = new TextField(250, 50, "Financial Detail", Assets.getFont(Assets.FONT_CORegular).fontName, 25, 0xc0251e);
			text.x = 20;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(250, 50, "Startup Cost", Assets.getFont(Assets.FONT_CORegular).fontName, 25, 0xc0251e);
			text.x = 550;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(350, 50, "Detail source starting cost", Assets.getFont(Assets.FONT_CORegular).fontName, 14, 0x333333);
			text.x = 20;
			text.y = 25;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(350, 50, "Cost for starting your business", Assets.getFont(Assets.FONT_CORegular).fontName, 14, 0x333333);
			text.x = 550;
			text.y = 25;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(300, 50, "Saving", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 20;
			text.y = 70;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "2.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 270;
			text.y = 70;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			text = new TextField(300, 50, "Bank Debt/Equity", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 20;
			text.y = 90;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "8.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 270;
			text.y = 90;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			var levelList:ListCollection = new ListCollection([{text: "Dept / Pay monthly with 10% interest"}, {text: "Equity / share profit each month 5%"}]);
			listSeed = new PickerList();
			listSeed.dataProvider = levelList;
			listSeed.listProperties.@itemRendererProperties.labelField = "text";
			listSeed.labelField = "text";
			listSeed.width = 400;
			listSeed.height = 25;
			listSeed.x = 20;
			listSeed.y = 135;
			addChild(listSeed);

			text = new TextField(300, 50, "Total Seed Financing", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 20;
			text.y = 170;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "10.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 270;
			text.y = 170;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			line = new Quad(400, 5, 0x333333);
			line.x = 20;
			line.y = 170;
			addChild(line);

			text = new TextField(300, 50, "This cost will dedicate from your cash balance", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xc0251e);
			text.x = 20;
			text.y = 210;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(300, 50, "Signature", Assets.getFont(Assets.FONT_SSBOLD).fontName, 12, 0x333333);
			text.x = 20;
			text.y = 250;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(300, 50, Data.name, Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0x333333);
			text.x = 20;
			text.y = 270;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(300, 50, "Shop Owner", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0xc0251e);
			text.x = 20;
			text.y = 292;
			text.hAlign = HAlign.LEFT;
			addChild(text);


			text = new TextField(300, 50, "Cart", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 70;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "5.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 70;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			text = new TextField(300, 50, "Equipment", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 90;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "300.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 90;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			text = new TextField(300, 50, "Permits", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 110;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "750.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 110;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			text = new TextField(300, 50, "Sign", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 130;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "500.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 130;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			text = new TextField(300, 50, "Insurance", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 550;
			text.y = 150;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "300.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			text.x = 700;
			text.y = 150;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			line = new Quad(300, 5, 0x333333);
			line.x = 550;
			line.y = 200;
			addChild(line);

			text = new TextField(200, 50, "Total Startup Cost", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 550;
			text.y = 200;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "6.850.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 700;
			text.y = 200;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			text = new TextField(200, 50, "Working Capital", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 550;
			text.y = 230;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "3.150.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 700;
			text.y = 230;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

			line = new Quad(300, 5, 0x333333);
			line.x = 550;
			line.y = 275;
			addChild(line);

			text = new TextField(300, 50, "Total Seed Financing", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 550;
			text.y = 280;
			text.hAlign = HAlign.LEFT;
			addChild(text);

			text = new TextField(150, 50, "10.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			text.x = 700;
			text.y = 280;
			text.hAlign = HAlign.RIGHT;
			addChild(text);

		}

		/**
		 * Update financial data.
		 */
		public function update():void
		{
			if (listSeed.selectedIndex == 0)
			{
				Data.financing = "DEBT";
				Data.installment = 0;
			}
			else
			{
				Data.financing = "EQUITY";
				Data.installment = 8000000;
			}
		}
	}
}
