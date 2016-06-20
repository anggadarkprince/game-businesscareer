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
	import starling.utils.HAlign;

	/**
	 * Content of trial balance report.
	 *
	 * @author Angga
	 */
	public class TrialBalance extends Sprite
	{
		private var server:ServerManager;
		private var gameObject:Object;
		private var tableContainer:Sprite;

		private var dataReport:Array;
		private var dataWidth:Array = [60, 300, 100, 100];
		private var header:Array = ["Ref.", "Accounting", "Debit", "Kredit"];
		private var align:Array = [HAlign.CENTER, HAlign.LEFT, HAlign.RIGHT, HAlign.RIGHT];
		private var headerWidth:Array = dataWidth;

		public var isLoaded:Boolean = false;

		/**
		 * Default constructor of TrialBalance.
		 */
		public function TrialBalance()
		{
			super();

			dataReport = new Array();

			server = new ServerManager("accounting/retrieve_trial_balance");
			server.addEventListener(ServerManager.READY, update);

			gameObject = new Object();

			tableContainer = new Sprite();
			addChild(tableContainer);
		}

		/**
		 * Request trial balance from server.
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
		 * Event handler when trial balance data has came.
		 *
		 * @param event
		 */
		private function update(event:flash.events.Event):void
		{
			if (JSON.parse(server.received.trial_var) as Array != null)
			{
				var tmpData:Array = JSON.parse(server.received.trial_var) as Array;

				var totalDebit:int = 0;
				var totalCredit:int = 0;

				for (var i:int = 0; i < tmpData.length; i++)
				{
					var debit:String = (tmpData[i].debit != "-") ? ValueFormatter.numberFormat(tmpData[i].debit) : "-";
					var credit:String = (tmpData[i].credit != "-") ? ValueFormatter.numberFormat(tmpData[i].credit) : "-";

					var row:Array = [tmpData[i].account_id, tmpData[i].account, (tmpData[i].position == "DEBITS") ? debit : "-", (tmpData[i].position == "CREDITS") ? credit : "-"];

					dataReport.push(row);

					totalDebit += int(tmpData[i].debit);
					totalCredit += int(tmpData[i].credit);
				}

				dataReport.push(new Array("", "TOTAL BALANCE", totalDebit, totalCredit));
			}

			TableGenerator.headerColor = 0xfe7877;
			TableGenerator.oddColor = 0xFFFFFF;
			TableGenerator.evenColor = 0xdedede;
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
	}
}
