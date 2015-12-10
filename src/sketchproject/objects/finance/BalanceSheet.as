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
	
	public class BalanceSheet extends Sprite
	{
		private var  title:TextField;
		private var server:ServerManager;
		private var gameObject:Object;
		private var tableContainer:Sprite;
		
		private var dataReport:Array;
		private var dataWidth:Array = [320,120,120];		
		private var header:Array = ["BALANCE ACCOUNT","DETAIL", "TOTAL"];
		private var align:Array = [HAlign.LEFT, HAlign.RIGHT, HAlign.RIGHT];
		private var headerWidth:Array = dataWidth;
		private var retainEarning:int;
		private var activa:int;
		
		public var isLoaded:Boolean = false;
		
		public function BalanceSheet()
		{
			super();
			
			dataReport = new Array();
			
			retainEarning = 0;
			
			title = new TextField(250, 150, "Balance Sheet", Assets.getFont("FontCarterOne").fontName, 14, 0x333333);
			title.x = 10;
			title.vAlign = VAlign.TOP;
			title.hAlign = HAlign.LEFT;
			//addChild(title);
			
			server = new ServerManager("accounting/retrieve_balance");
			server.addEventListener(ServerManager.READY, update);
			
			gameObject = new Object();
			
			tableContainer = new Sprite();
			addChild(tableContainer);	
		}
		
		public function updateReport():void
		{						
			gameObject.token = Data.key;
			gameObject.day = Data.playtime;
			server.objectData = gameObject;
			server.sendRequest();
			
			if(tableContainer.isFlattened)
			{
				tableContainer.unflatten();
			}
			tableContainer.removeChildren();
			dataReport = new Array();
		}
		
		private function update(event:flash.events.Event):void{
			
			
			
			var title:Array = ["CURRENT ASSETS","FIXED ASSET","Liabilities","Equity"];
			
			var totalActiva:int = 0;
			var totalPasiva:int = 0;
			
			
			if(JSON.parse(server.received.balance_var) as Array != null){
				var tmpData:Array = JSON.parse(server.received.balance_var) as Array;
				
				for(var i:int = 0; i<tmpData.length;i++)
				{
					var row:Array = [title[i],"",""];
					var totalAccount:int = 0;
					for(var j:int = 0; j<tmpData[i].length;j++)
					{						
						row = [
							tmpData[i][j].account,		
							ValueFormatter.numberFormat(tmpData[i][j].value),
							""
						];
						totalAccount+=int(tmpData[i][j].value);
						dataReport.push(row);
					}	
					row = ["    TOTAL "+title[i],"",ValueFormatter.numberFormat(totalAccount)];	
					dataReport.push(row);
					
					if(i == 0 || i==1)
					{
						totalActiva += totalAccount;	
					}
					else
					{
						totalPasiva += totalAccount;
					}
					
					if(i == 1)
					{
						activa = totalActiva;
						row = ["ACTIVA","",ValueFormatter.numberFormat(totalActiva)];	
						dataReport.push(row);
						row = ["","",""];	
						dataReport.push(row);
					}
					if(i == 3)
					{
						retainEarning = totalActiva-totalPasiva;
						totalPasiva+=retainEarning;
						row = ["Retained Earnings","",retainEarning];	
						dataReport.push(row);
						row = ["PASIVA","",ValueFormatter.numberFormat(totalPasiva)];	
						dataReport.push(row);
						row = ["","",""];	
						dataReport.push(row);
					}
				}
				
			}
			
			TableGenerator.headerColor = 0xfe7877;
			TableGenerator.oddColor = 0xFFFFFF;
			TableGenerator.evenColor = 0xFFFFFF;
			TableGenerator.headerFontColor = 0xFFFFFF;
			TableGenerator.dataFontColor = 0x333333;
			TableGenerator.headerFontSize = 12;
			TableGenerator.dataFontSize = 12;
			TableGenerator.stripJump = 3;
			TableGenerator.hasHeader = true;
			
			TableGenerator.createTable(tableContainer,header,headerWidth,dataReport,dataWidth,align);
			
			tableContainer.flatten();
			
			isLoaded = true;
			dispatchEvent(new starling.events.Event(FinanceScreen.REPORT_READY));
		}
		
		public function getActiva():int
		{
			return activa;
		}
	}
}