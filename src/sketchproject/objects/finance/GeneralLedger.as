package sketchproject.objects.finance
{
	import flash.events.Event;

	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.managers.ServerManager;
	import sketchproject.screens.FinanceScreen;
	import sketchproject.utilities.TableGenerator;
	import sketchproject.utilities.ValueFormatter;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Content of general ledger.
	 *
	 * @author Angga
	 */
	public class GeneralLedger extends Sprite
	{
		private var title:TextField;
		private var server:ServerManager;
		private var gameObject:Object;
		private var tableContainer:Sprite;
		private var accountContainer:Sprite;

		private var dataReport:Array;
		private var dataWidth:Array = [35, 205, 80, 80, 80, 80];
		private var header:Array = ["Day", "Description", "Debit", "Kredit", "Balance D", "Balance K"];
		private var headerWidth:Array = dataWidth;
		private var align:Array = [HAlign.CENTER, HAlign.LEFT, HAlign.RIGHT, HAlign.RIGHT, HAlign.RIGHT, HAlign.RIGHT];
		private var hSpace:int;

		public var isLoaded:Boolean = false;

		/**
		 * Default constructor of GeneralLedger.
		 */
		public function GeneralLedger()
		{
			super();

			dataReport = new Array();

			server = new ServerManager("accounting/retrieve_ledger");
			server.addEventListener(ServerManager.READY, update);

			gameObject = new Object();

			tableContainer = new Sprite();
			addChild(tableContainer);
		}

		/**
		 * Request general ledger from server.
		 */
		public function updateReport():void
		{
			gameObject.token = Data.key;
			gameObject.day = Data.playtime;
			server.objectData = gameObject;
			server.sendRequest();

			if (tableContainer.isFlattened)
			{
				tableContainer.unflatten();
			}

			tableContainer.removeChildren();
			dataReport = new Array();
		}

		/**
		 * Event handler when general ledger data has came.
		 *
		 * @param event
		 */
		private function update(event:flash.events.Event):void
		{
			hSpace = 0;

			TableGenerator.headerColor = 0xfe7877;
			TableGenerator.oddColor = 0xFFFFFF;
			TableGenerator.evenColor = 0xdedede;
			TableGenerator.headerFontColor = 0xFFFFFF;
			TableGenerator.dataFontColor = 0x333333;
			TableGenerator.headerFontSize = 12;
			TableGenerator.dataFontSize = 12;
			TableGenerator.stripJump = 2;

			if (JSON.parse(server.received.ledger_var) as Array != null)
			{
				var tmpData:Array = JSON.parse(server.received.ledger_var) as Array;


				for (var i:int = 0; i < tmpData.length; i++)
				{
					var balance:int = 0;
					var debitTotal:int = 0;
					var creditTotal:int = 0;
					var position:String = tmpData[i][0].position;

					accountContainer = new Sprite();
					tableContainer.addChild(accountContainer);

					title = new TextField(250, 35, tmpData[i][0].account, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
					title.y = hSpace;
					title.vAlign = VAlign.TOP;
					title.hAlign = HAlign.LEFT;
					tableContainer.addChild(title);

					hSpace += 35; // hspace title

					dataReport = new Array();

					for (var j:int = 0; j < tmpData[i].length; j++)
					{

						if (tmpData[i][j].debit != "-")
						{
							debitTotal += int(tmpData[i][j].debit);
						}
						if (tmpData[i][j].credit != "-")
						{
							creditTotal += int(tmpData[i][j].credit);
						}

						if (position == "DEBITS")
						{
							if (tmpData[i][j].debit != "-")
							{
								balance += int(tmpData[i][j].debit);
							}
							else
							{
								balance -= int(tmpData[i][j].credit)
							}
						}
						else
						{
							if (tmpData[i][j].credit != "-")
							{
								balance += int(tmpData[i][j].credit)
							}
							else
							{
								balance -= int(tmpData[i][j].debit)
							}
						}

						var row:Array = [tmpData[i][j].day, String(tmpData[i][j].description).substr(0, 27) + "...", (tmpData[i][j].debit != "-") ? ValueFormatter.numberFormat(tmpData[i][j].debit) : "-", (tmpData[i][j].credit != "-") ? ValueFormatter.numberFormat(tmpData[i][j].credit) : "-", (position == "DEBITS") ? ValueFormatter.numberFormat(balance) : "-", (position == "CREDITS") ? ValueFormatter.numberFormat(balance) : "-"];
						dataReport.push(row);
					}

					dataReport.push(new Array("", "Dipindahkan periode berikutnya", ValueFormatter.numberFormat(debitTotal), ValueFormatter.numberFormat(creditTotal), (position == "DEBITS") ? ValueFormatter.numberFormat(balance) : "-", (position == "CREDITS") ? ValueFormatter.numberFormat(balance) : "-"));

					TableGenerator.createTable(accountContainer, header, headerWidth, dataReport, dataWidth, align);

					accountContainer.flatten();

					accountContainer.y = hSpace;
					hSpace += accountContainer.height + 20; // hspace between table
				}
			}

			tableContainer.flatten();

			isLoaded = true;

			dispatchEvent(new starling.events.Event(FinanceScreen.REPORT_READY));
		}
	}
}
