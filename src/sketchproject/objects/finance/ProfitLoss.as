package sketchproject.objects.finance
{
	import flash.events.Event;

	import sketchproject.core.Data;
	import sketchproject.managers.ServerManager;
	import sketchproject.screens.FinanceScreen;
	import sketchproject.utilities.TableGenerator;
	import sketchproject.utilities.ValueFormatter;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Content of profit and loss report.
	 *
	 * @author Angga
	 */
	public class ProfitLoss extends Sprite
	{
		private var title:TextField;
		private var server:ServerManager;
		private var gameObject:Object;
		private var tableContainer:Sprite;

		private var dataReport:Array;
		private var dataWidth:Array = [320, 120, 120];
		private var header:Array = ["LOSS PROFIT ACCOUNT", "DETAIL", "TOTAL"];
		private var align:Array = [HAlign.LEFT, HAlign.RIGHT, HAlign.RIGHT];
		private var headerWidth:Array = dataWidth;
		private var hSpace:int;

		private var netIncome:int;

		public var isLoaded:Boolean = false;

		/**
		 * Default constructor of ProfitLoss
		 */
		public function ProfitLoss()
		{
			super();

			dataReport = new Array();
			netIncome = 0;

			server = new ServerManager("accounting/retrieve_loss_profit");
			server.addEventListener(ServerManager.READY, update);

			gameObject = new Object();

			tableContainer = new Sprite();
			addChild(tableContainer);
		}

		/**
		 * Request balance sheet from server.
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
		 * Event handler when profit loss data has came.
		 *
		 * @param event
		 */
		private function update(event:flash.events.Event):void
		{
			hSpace = 0;

			if (JSON.parse(server.received.loss_profit_var) as Array != null)
			{
				var tmpData:Array = JSON.parse(server.received.loss_profit_var) as Array;

				var totalRevenue:int = 0;
				var totalExpense:int = 0;
				var totalExpenseAdvertising:int = 0;
				var totalExpenseMarketing:int = 0;

				for (var i:int = 0; i < tmpData.length; i++)
				{
					var row:Array;
					if (i == 0)
					{
						row = ["REVENUE", "", ""];
						dataReport.push(row);
						for (var j:int = 0; j < tmpData[i].length; j++)
						{
							if (tmpData[i].account == "[Revenue] Sales")
							{
								row = ["     " + tmpData[i][j].account, ValueFormatter.numberFormat(tmpData[i][j].value), ""];
								totalRevenue += int(tmpData[i][j].value);
							}
							else
							{
								row = ["     " + tmpData[i][j].account, ValueFormatter.numberFormat(tmpData[i][j].value), ""];
								totalRevenue -= int(tmpData[i][j].value);
							}

							dataReport.push(row);
						}
						row = ["     GROSS PROFIT", "", ValueFormatter.numberFormat(totalRevenue)];
						dataReport.push(row);
					}
					else if (i == 1)
					{
						row = ["EXPENSES", "", ""];
						dataReport.push(row);

						for (var k:int = 0; k < tmpData[i].length; k++)
						{

							if (tmpData[i][k] as Array != null)
							{
								if (k == 0)
								{
									row = ["MARKETING", "", ""];
									dataReport.push(row);
								}
								else
								{
									row = ["ADVERTISING", "", ""];
									dataReport.push(row);
								}
								for (var l:int = 0; l < tmpData[i][k].length; l++)
								{
									if (k == 0)
									{
										row = ["     " + tmpData[i][k][l].account, ValueFormatter.numberFormat(tmpData[i][k][l].value), ""];
										totalExpenseMarketing += int(tmpData[i][k][l].value);
									}
									else
									{
										row = ["     " + tmpData[i][k][l].account, ValueFormatter.numberFormat(tmpData[i][k][l].value), ""];
										totalExpenseAdvertising += int(tmpData[i][k][l].value);
									}

									dataReport.push(row);
								}
								if (k == 0)
								{
									row = ["", "", ValueFormatter.numberFormat(totalExpenseMarketing)];
									dataReport.push(row);
								}
								else
								{
									row = ["", "", ValueFormatter.numberFormat(totalExpenseAdvertising)];
									dataReport.push(row);
								}
							}
							else
							{
								row = ["     " + tmpData[i][k].account, "", ValueFormatter.numberFormat(tmpData[i][k].value)];
								totalExpense += tmpData[i][k].value;
								dataReport.push(row);
							}
						}

						row = ["     TOTAL EXPENSES", "", ValueFormatter.numberFormat(totalExpense)];
						dataReport.push(row);
					}
				}
				netIncome = totalRevenue - totalExpense;
				row = ["Net Income(Loss) Before Tax", "", ValueFormatter.numberFormat(netIncome)];
				dataReport.push(row);
			}

			TableGenerator.headerColor = 0xfe7877;
			TableGenerator.oddColor = 0xFFFFFF;
			TableGenerator.evenColor = 0xFFFFFF;
			TableGenerator.headerFontColor = 0xFFFFFF;
			TableGenerator.dataFontColor = 0x333333;
			TableGenerator.headerFontSize = 12;
			TableGenerator.dataFontSize = 12;
			TableGenerator.stripJump = 2;
			TableGenerator.hasHeader = true;

			TableGenerator.createTable(tableContainer, header, headerWidth, dataReport, dataWidth, align);

			tableContainer.flatten();

			isLoaded = true;
			dispatchEvent(new starling.events.Event(FinanceScreen.REPORT_READY));
		}

		/**
		 *
		 * @return
		 */
		public function getNetIncome():int
		{
			return netIncome;
		}
	}
}
