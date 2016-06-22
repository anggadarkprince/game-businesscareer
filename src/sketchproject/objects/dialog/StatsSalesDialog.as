package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Show player's stats sales of products.
	 *
	 * @author Angga
	 */
	public class StatsSalesDialog extends DialogOverlay
	{
		private var background:Image;
		private var soldFood1:TextField;
		private var soldFood2:TextField;
		private var soldFood3:TextField;
		private var soldDrink1:TextField;
		private var soldDrink2:TextField;
		private var salesFood1:TextField;
		private var salesFood2:TextField;
		private var salesFood3:TextField;
		private var salesDrink1:TextField;
		private var salesDrink2:TextField;
		private var buttonClose:Button;

		/**
		 * Default constructor of StatsSales.
		 *
		 * @param destroyable
		 */
		public function StatsSalesDialog(destroyable:Boolean = false)
		{
			super(destroyable);

			background = new Image(Assets.getAtlas(Assets.ADDITIONAL, Assets.ADDITIONAL_XML).getTexture("sales_panel"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);

			soldFood1 = new TextField(250, 50, "Sold 34 Items", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			soldFood1.hAlign = HAlign.LEFT;
			soldFood1.vAlign = VAlign.TOP;
			soldFood1.x = -145.05;
			soldFood1.y = -96.55;
			addChild(soldFood1);

			soldFood2 = new TextField(250, 50, "Sold 34 Items", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			soldFood2.hAlign = HAlign.LEFT;
			soldFood2.vAlign = VAlign.TOP;
			soldFood2.x = -145.05;
			soldFood2.y = -49.6;
			addChild(soldFood2);

			soldFood3 = new TextField(250, 50, "Sold 34 Items", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			soldFood3.hAlign = HAlign.LEFT;
			soldFood3.vAlign = VAlign.TOP;
			soldFood3.x = -145.05;
			soldFood3.y = -2.65;
			addChild(soldFood3);

			soldDrink1 = new TextField(250, 50, "Sold 34 Items", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			soldDrink1.hAlign = HAlign.LEFT;
			soldDrink1.vAlign = VAlign.TOP;
			soldDrink1.x = -145.05;
			soldDrink1.y = 41.8;
			addChild(soldDrink1);

			soldDrink2 = new TextField(250, 50, "Sold 34 Items", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
			soldDrink2.hAlign = HAlign.LEFT;
			soldDrink2.vAlign = VAlign.TOP;
			soldDrink2.x = -145.05;
			soldDrink2.y = 87.95;
			addChild(soldDrink2);

			salesFood1 = new TextField(250, 50, "Food 1 IDR " + Data.product[0].prd_price, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesFood1.pivotX = salesFood1.width;
			salesFood1.hAlign = HAlign.RIGHT;
			salesFood1.vAlign = VAlign.TOP;
			salesFood1.x = 215.05;
			salesFood1.y = -113.65;
			addChild(salesFood1);

			salesFood2 = new TextField(250, 50, "Food 2 IDR " + Data.product[1].prd_price, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesFood2.pivotX = salesFood2.width;
			salesFood2.hAlign = HAlign.RIGHT;
			salesFood2.vAlign = VAlign.TOP;
			salesFood2.x = 215.05;
			salesFood2.y = -67.65;
			addChild(salesFood2);

			salesFood3 = new TextField(250, 50, "Food 3 IDR " + Data.product[2].prd_price, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesFood3.pivotX = salesFood3.width;
			salesFood3.hAlign = HAlign.RIGHT;
			salesFood3.vAlign = VAlign.TOP;
			salesFood3.x = 215.05;
			salesFood3.y = -21.65;
			addChild(salesFood3);

			salesDrink1 = new TextField(250, 50, "Drink 1 IDR " + Data.product[3].prd_price, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesDrink1.pivotX = salesDrink1.width;
			salesDrink1.hAlign = HAlign.RIGHT;
			salesDrink1.vAlign = VAlign.TOP;
			salesDrink1.x = 215.05;
			salesDrink1.y = 24.35;
			addChild(salesDrink1);

			salesDrink2 = new TextField(250, 50, "Drink 2 IDR " + Data.product[4].prd_price, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesDrink2.pivotX = salesDrink2.width;
			salesDrink2.hAlign = HAlign.RIGHT;
			salesDrink2.vAlign = VAlign.TOP;
			salesDrink2.x = 215.05;
			salesDrink2.y = 70.35;
			addChild(salesDrink2);

			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_close"));
			buttonClose.x = 113.45;
			buttonClose.y = 137.25;
			addChild(buttonClose);

			buttonClose.addEventListener(Event.TRIGGERED, function(event:Event):void {
				closeDialog();
			});

			update();
		}

		/**
		 * Update sales statuses.
		 */
		public function update():void
		{
			soldFood1.text = "Sold " + Data.soldFood1 + " Items";
			soldFood2.text = "Sold " + Data.soldFood2 + " Items";
			soldFood3.text = "Sold " + Data.soldFood3 + " Items";
			soldDrink1.text = "Sold " + Data.soldDrink1 + " Items";
			soldDrink2.text = "Sold " + Data.soldDrink2 + " Items";
		}
	}
}
