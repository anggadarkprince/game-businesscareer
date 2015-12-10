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
	
	public class GeneralJournal extends Sprite
	{
		private var  title:TextField;
		private var server:ServerManager;
		private var gameObject:Object;
		private var tableContainer:Sprite;
		
		private var dataReport:Array;
		private var dataWidth:Array = [35,285,40,100,100];		
		private var header:Array = ["Day","Description", "Ref.", "Debit", "Kredit"];
		private var align:Array = [HAlign.CENTER,HAlign.LEFT, HAlign.CENTER, HAlign.RIGHT, HAlign.RIGHT];
		private var headerWidth:Array = dataWidth;
		
		public var isLoaded:Boolean = false;
		
		public function GeneralJournal()
		{
			super();
			
			dataReport = new Array();
			
			title = new TextField(250, 150, "General Journal", Assets.getFont("FontCarterOne").fontName, 14, 0x333333);
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
				
				for(var i:int = 0; i<tmpData.length;i++)
				{
					var row:Array = [
						tmpData[i].day,				
						(i%2==0)?tmpData[i].account:"    "+tmpData[i].account,				
						tmpData[i].account_id,				
						(tmpData[i].debit!="-")?ValueFormatter.numberFormat(tmpData[i].debit):"-",				
						(tmpData[i].credit!="-")?ValueFormatter.numberFormat(tmpData[i].credit):"-"		
					];
					
					dataReport.push(row);
					
					if(i%2==1)
					{
						dataReport.push(new Array("",String(tmpData[i].description).substr(0,40)+"...","","",""));
					}
				}
			}

			TableGenerator.headerColor = 0xfe7877;
			TableGenerator.oddColor = 0xFFFFFF;
			TableGenerator.evenColor = 0xdedede;
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
		
		
	}
}