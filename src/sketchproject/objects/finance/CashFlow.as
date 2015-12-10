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
	
	public class CashFlow extends Sprite
	{
		private var  title:TextField;
		private var server:ServerManager;
		private var gameObject:Object;
		private var tableContainer:Sprite;
		
		private var dataReport:Array;
		private var dataWidth:Array = [40,300,110,110];		
		private var header:Array = ["Ref.","Account", "Clash inflow", "Cash outflow"];
		private var align:Array = [HAlign.CENTER,HAlign.LEFT, HAlign.RIGHT, HAlign.RIGHT];
		private var headerWidth:Array = dataWidth;
		
		public var isLoaded:Boolean = false;
		
		public function CashFlow()
		{
			super();
			
			dataReport = new Array();
			
			title = new TextField(250, 150, "Cash Flow", Assets.getFont("FontCarterOne").fontName, 14, 0x333333);
			title.x = 10;
			title.vAlign = VAlign.TOP;
			title.hAlign = HAlign.LEFT;
			//addChild(title);
			
			server = new ServerManager("accounting/retrieve_journal");
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
			
			if(JSON.parse(server.received.journal_var) as Array != null){
				var tmpData:Array = JSON.parse(server.received.journal_var) as Array;
				
				var cashinTotal:int = 0;
				var cashoutTotal:int = 0;
				
				for(var i:int = 0; i<tmpData.length;i++)
				{
					if((i+1)%2==1)
					{
						// debit record
						if(tmpData[i].account_id == 111)
						{
							cashinTotal+=int(tmpData[i].debit);
							insertCashFlow(tmpData[i],"IN");
						}
					}
					else
					{
						// credit record	
						if(tmpData[i].account_id == 111)
						{
							cashoutTotal+=int(tmpData[i].credit);
							insertCashFlow(tmpData[i-1],"OUT");
						}
					}
				}
				dataReport.push(new Array("","CASH FLOW",ValueFormatter.numberFormat(cashinTotal),ValueFormatter.numberFormat(cashoutTotal)));
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
			
			TableGenerator.createTable(tableContainer,header,headerWidth,dataReport,dataWidth,align);
			
			tableContainer.flatten();
			
			isLoaded = true;
			dispatchEvent(new starling.events.Event(FinanceScreen.REPORT_READY));
		}
		
		private function insertCashFlow(data:Object, flow:String):void
		{
			var isExist:Boolean = false;
			
			var cashin:int;
			var cashout:int;
			
			if(flow == "OUT")
			{
				cashin = 0;
				cashout = data.debit
			}
			else
			{
				cashin = data.debit;
				cashout = 0;
			}
			
			for(var i:int = 0; i<dataReport.length;i++)
			{
				if(dataReport[i][0] == data.account_id)
				{
					isExist = true;
					
					dataReport[i][2] = ValueFormatter.numberFormat(int(dataReport[i][2].toString().replace(".","")) + cashin);
					dataReport[i][3] = ValueFormatter.numberFormat(int(dataReport[i][3].toString().replace(".","")) + cashout);
					
					break;
				}
			}
			
			if(!isExist)
			{
				var row:Array = [
					data.account_id,				
					data.account,			
					ValueFormatter.numberFormat(cashin),				
					ValueFormatter.numberFormat(cashout)		
				];
				
				dataReport.push(row);
			}
			
		}
	}
}