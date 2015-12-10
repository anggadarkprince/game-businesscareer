package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

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
			
			salesFood1 = new TextField(250, 50, "Sales Food 1 IDR 34000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesFood1.pivotX = salesFood1.width;
			salesFood1.hAlign = HAlign.RIGHT;
			salesFood1.vAlign = VAlign.TOP;
			salesFood1.x = 215.05;
			salesFood1.y = -113.65;
			addChild(salesFood1);
			
			salesFood2 = new TextField(250, 50, "Sales Food 2 IDR 34000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesFood2.pivotX = salesFood2.width;
			salesFood2.hAlign = HAlign.RIGHT;
			salesFood2.vAlign = VAlign.TOP;
			salesFood2.x = 215.05;
			salesFood2.y = -67.65;
			addChild(salesFood2);
			
			salesFood3 = new TextField(250, 50, "Sales Food 3 IDR 34000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesFood3.pivotX = salesFood3.width;
			salesFood3.hAlign = HAlign.RIGHT;
			salesFood3.vAlign = VAlign.TOP;
			salesFood3.x = 215.05;
			salesFood3.y = -21.65;
			addChild(salesFood3);
			
			salesDrink1 = new TextField(250, 50, "Sales Drink 1 IDR 34000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			salesDrink1.pivotX = salesDrink1.width;
			salesDrink1.hAlign = HAlign.RIGHT;
			salesDrink1.vAlign = VAlign.TOP;
			salesDrink1.x = 215.05;
			salesDrink1.y = 24.35;
			addChild(salesDrink1);
			
			salesDrink2 = new TextField(250, 50, "Sales Drink 2 IDR 34000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
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
			
			buttonClose.addEventListener(Event.TRIGGERED, function(event:Event):void{
				closeDialog();
			});
			
			update();
			
		}
		
		public function update():void
		{
			soldFood1.text = "Sold 34 Items";
			soldFood2.text = "Sold 34 Items";
			soldFood3.text = "Sold 34 Items";
			soldDrink1.text = "Sold 34 Items";
			soldDrink2.text = "Sold 34 Items";
			
			salesFood1.text = "Sales Food 1 IDR 34000";
			salesFood2.text = "Sales Food 2 IDR 34000";
			salesFood3.text = "Sales Food 3 IDR 34000";
			salesDrink1.text = "Sales Drink 1 IDR 34000";
			salesDrink2.text = "Sales Drink 2 IDR 34000";
		}
		
		
	}
}