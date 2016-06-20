package sketchproject.objects.finance
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.screens.FinanceScreen;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 *
	 * @author Angga
	 */
	public class ProfitChart extends Sprite
	{
		private var title:TextField;
		private var bar:Quad;
		private var label:TextField;
		public var isLoaded:Boolean = false;

		/**
		 * Default constructor of ProfitChart
		 */
		public function ProfitChart()
		{
			super();

			title = new TextField(250, 150, "Profit Chart", Assets.getFont("FontCarterOne").fontName, 14, 0x333333);
			title.x = 10;
			title.vAlign = VAlign.TOP;
			title.hAlign = HAlign.LEFT;
			addChild(title);
		}

		/**
		 * Retrieve max of selling value.
		 * 
		 * @return
		 */
		public function getSalesMax():int
		{
			var max:int = 0;
			for (var i:int = 0; i < Data.simulation.length; i++)
			{
				if (Data.simulation[i].sim_served > max)
				{
					max = Data.simulation[i].sim_served;
				}
			}
			return max;
		}

		/**
		 * Update profit chart.
		 */
		public function updateReport():void
		{
			isLoaded = true;

			removeChildren();

			var maxSales:int = getSalesMax();

			bar = new Quad(540, 2, 0xDDDDDD);
			bar.x = 10;
			bar.y = 25;
			addChild(bar);

			bar = new Quad(540, 2, 0xDDDDDD);
			bar.x = 10;
			bar.y = 100;
			addChild(bar);

			bar = new Quad(540, 2, 0xDDDDDD);
			bar.x = 10;
			bar.y = 175;
			addChild(bar);

			bar = new Quad(540, 2, 0xDDDDDD);
			bar.x = 10;
			bar.y = 250;
			addChild(bar);

			for (var i:int = 0; i < Data.simulation.length; i++)
			{
				bar = new Quad(50, 220 / maxSales * Data.simulation[i].sim_served, 0x96ce00);
				bar.x = i * 90 + 35;
				bar.y = 240 - bar.height + 10;
				addChild(bar);

				label = new TextField(100, 30, "DAY " + Data.simulation[i].sim_day, Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
				label.hAlign = HAlign.CENTER;
				label.vAlign = VAlign.TOP;
				label.pivotX = label.width * 0.5;
				label.pivotY = label.width * 0.5;
				label.x = i * 90 + 35 + bar.width * 0.5;
				label.y = 300;
				addChild(label);
			}

			dispatchEvent(new starling.events.Event(FinanceScreen.REPORT_READY));
		}
	}
}
