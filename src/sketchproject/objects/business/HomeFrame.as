package sketchproject.objects.business
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.utilities.ValueFormatter;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Show business operation statistic such as cash and stress.
	 * 
	 * @author Angga
	 */
	public class HomeFrame extends Sprite
	{
		private var characterBackground:Image;
		private var label:TextField;
		private var baseBar:Quad;
		private var stressBarBase:Quad;
		private var stressBar:Quad;
		private var workBar:Quad;

		private var workAverage:TextField;
		private var workTotal:TextField;
		private var sallaryMonth:TextField;
		private var sallaryDay:TextField;

		private var lineBar:Shape;

		private var lastXWork:int = 0;
		private var lastYWork:int = 0;
		private var lastXPersonal:int = 0;
		private var lastYPersonal:int = 0;
		private var lastXStress:int = 0;
		private var lastYStress:int = 0;

		private var colorStress:int = 0;

		/**
		 * Default constructor of HomeFrame.
		 */
		public function HomeFrame()
		{
			super();

			lineBar = new Shape();
			addChild(lineBar);

			label = new TextField(250, 50, "Cash", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -200;
			addChild(label);
			
			label = new TextField(250, 50, "Estimasi dan Rata - rata pendapatan owner per bulan dan per hari", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -175;
			addChild(label);

			label = new TextField(250, 50, "Est. sallary / month", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -130;
			addChild(label);

			sallaryMonth = new TextField(250, 50, "IDR 500 K", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			sallaryMonth.vAlign = VAlign.TOP;
			sallaryMonth.hAlign = HAlign.LEFT;
			sallaryMonth.x = -250;
			sallaryMonth.y = -130;
			addChild(sallaryMonth);

			label = new TextField(250, 50, "Avg. sallary / day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -110;
			addChild(label);

			sallaryDay = new TextField(250, 50, "IDR 3000", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			sallaryDay.vAlign = VAlign.TOP;
			sallaryDay.hAlign = HAlign.LEFT;
			sallaryDay.x = -250;
			sallaryDay.y = -110;
			addChild(sallaryDay);

			label = new TextField(250, 20, "Stress Chart", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -70;
			addChild(label);
			
			label = new TextField(250, 50, "Tingkat stress 6 hari terakhir", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -400;
			label.y = -45;
			addChild(label);

			stressBarBase = new Quad(30, 85, 0xeb4a42);
			stressBarBase.x = -390;
			stressBarBase.y = -10;
			addChild(stressBarBase);

			stressBar = new Quad(30, 40, 0xc0c0c0);
			stressBar.x = -390;
			stressBar.y = -10;
			addChild(stressBar);

			baseBar = new Quad(10, 10, 0xeb4a42);
			baseBar.x = -350;
			baseBar.y = 90;
			addChild(baseBar);

			label = new TextField(250, 50, "HIGH", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -335;
			label.y = 86;
			addChild(label);

			baseBar = new Quad(10, 10, 0xffca3c);
			baseBar.x = -270;
			baseBar.y = 90;
			addChild(baseBar);

			label = new TextField(250, 50, "AVG", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -255;
			label.y = 86;
			addChild(label);

			baseBar = new Quad(10, 10, 0x8fcc19);
			baseBar.x = -190;
			baseBar.y = 90;
			addChild(baseBar);

			label = new TextField(250, 50, "LOW", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -175;
			label.y = 86;
			addChild(label);

			baseBar = new Quad(205, 4, 0x333333);
			baseBar.x = -350;
			baseBar.y = 80;
			addChild(baseBar);

			label = new TextField(250, 50, "Hours", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -200;
			addChild(label);
			
			label = new TextField(250, 50, "Akumulasi dan rata - rata jam operasional toko per hari", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -175;
			addChild(label);

			label = new TextField(250, 50, "Work avarage / day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -130;
			addChild(label);

			workAverage = new TextField(250, 50, "34 Hours", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			workAverage.vAlign = VAlign.TOP;
			workAverage.hAlign = HAlign.RIGHT;
			workAverage.x = 50;
			workAverage.y = -130;
			addChild(workAverage);

			label = new TextField(250, 50, "Total work hours", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -110;
			addChild(label);

			workTotal = new TextField(250, 50, "56 Hours", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			workTotal.vAlign = VAlign.TOP;
			workTotal.hAlign = HAlign.RIGHT;
			workTotal.x = 50;
			workTotal.y = -110;
			addChild(workTotal);

			label = new TextField(250, 20, "Work Chart", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -70;
			addChild(label);
			
			label = new TextField(250, 50, "Waktu kerja 6 hari terakhir", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -100;
			label.y = -45;
			addChild(label);

			baseBar = new Quad(30, 85, 0xe02c78);
			baseBar.x = -85;
			baseBar.y = -10;
			addChild(baseBar);

			workBar = new Quad(30, 40, 0x32caeb);
			workBar.x = -85;
			workBar.y = -10;
			addChild(workBar);

			label = new TextField(250, 50, "Work Hours", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -40;
			label.y = 86;
			addChild(label);

			baseBar = new Quad(10, 10, 0xe02c78);
			baseBar.x = 35;
			baseBar.y = 90;
			addChild(baseBar);

			label = new TextField(250, 50, "Personal Hours", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 12, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 70;
			label.y = 86;
			addChild(label);

			baseBar = new Quad(10, 10, 0x32caeb);
			baseBar.x = 55;
			baseBar.y = 90;
			addChild(baseBar);

			baseBar = new Quad(195, 4, 0x333333);
			baseBar.x = -40;
			baseBar.y = 80;
			addChild(baseBar);

			characterBackground = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_dian_sastro"));
			characterBackground.x = 280;
			characterBackground.y = -170;
			addChild(characterBackground);

			characterBackground = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_christian_sugiono"));
			characterBackground.x = 200;
			characterBackground.y = -170;
			addChild(characterBackground);

			updateInfo();
		}

		/**
		 * Update home statistic.
		 */
		public function updateInfo():void
		{
			sallaryDay.text = "IDR " + ValueFormatter.format(int(Math.round(Data.salesTotal / Data.playtime)));
			sallaryMonth.text = "IDR " + ValueFormatter.format(int(Math.round(Data.salesTotal / Data.playtime * 30)));
			workAverage.text = Data.workAvg.toString() + " Hours";
			workTotal.text = Data.workTotal.toString() + " Hours";

			stressBar.height = 80 - (80 * Data.stress / 100);
			workBar.height = 80 - (80 * Data.work / 24);

			if (Data.stress < 30)
			{
				stressBarBase.color = 0x8fcc19;
			}
			else if (Data.stress < 60)
			{
				stressBarBase.color = 0xffca3c;
			}
			else
			{
				stressBarBase.color = 0xeb4a42;
			}

			var maxStress:int = Data.stressHistory[0];
			var maxWork:int = Data.workHistory[0];

			for (var i:int = 1; i < Data.workHistory.length; i++)
			{
				if (maxWork < Data.workHistory[i])
				{
					maxWork = Data.workHistory[i];
				}
				if (maxStress < Data.stressHistory[i])
				{
					maxStress = Data.stressHistory[i];
				}
			}


			lineBar.graphics.clear();

			for (var j:int = 0; j < Data.workHistory.length; j++)
			{

				if (Data.stressHistory[j] < 30)
				{
					colorStress = 0x8fcc19;
				}
				else if (Data.stressHistory[j] < 60)
				{
					colorStress = 0xffca3c;
				}
				else
				{
					colorStress = 0xeb4a42;
				}

				var posYWok:int = 60 * Data.workHistory[j] / maxWork;
				var posYPersonal:int = 60 * (24 - Data.workHistory[j]) / maxWork;
				var posYStress:int = 60 * Data.stressHistory[j] / maxStress;

				if (j > 0)
				{
					lineBar.graphics.lineStyle(3, 0xe02c78, 1);
					lineBar.graphics.moveTo(lastXWork + 5, lastYWork + 5);
					lineBar.graphics.lineTo(j * 32 - 30 + 5, -posYWok + 60 + 5);

					lineBar.graphics.lineStyle(3, 0x32caeb, 1);
					lineBar.graphics.moveTo(lastXPersonal + 5, lastYPersonal + 5);
					lineBar.graphics.lineTo(j * 32 - 30 + 5, -posYPersonal + 60 + 5);

					lineBar.graphics.lineStyle(3, colorStress, 1);
					lineBar.graphics.moveTo(lastXStress + 5, lastYStress + 5);
					lineBar.graphics.lineTo(j * 32 - 330 + 5, -posYStress + 60 + 5);
				}

				lineBar.graphics.beginFill(0xe02c78);
				lineBar.graphics.lineStyle(0, 0xFFFFFF, 1);
				lineBar.graphics.drawRect(j * 32 - 30, -posYWok + 60, 10, 10);
				lineBar.graphics.endFill();

				lineBar.graphics.beginFill(0x32caeb);
				lineBar.graphics.lineStyle(0, 0xFFFFFF, 1);
				lineBar.graphics.drawRect(j * 32 - 30, -posYPersonal + 60, 10, 10);
				lineBar.graphics.endFill();


				lineBar.graphics.beginFill(colorStress);
				lineBar.graphics.lineStyle(0, 0xFFFFFF, 1);
				lineBar.graphics.drawRect(j * 32 - 330, -posYStress + 60, 10, 10);
				lineBar.graphics.endFill();

				lastXWork = j * 32 - 30;
				lastYWork = -posYWok + 60;

				lastXPersonal = j * 32 - 30;
				lastYPersonal = -posYPersonal + 60;

				lastXStress = j * 32 - 330;
				lastYStress = -posYStress + 60;
			}

		}
	}
}
