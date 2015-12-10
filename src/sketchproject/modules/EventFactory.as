package sketchproject.modules
{
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.utilities.GameUtils;

	public class EventFactory
	{
		private var agentGenerator:AgentGenerator;
		
		public function EventFactory()
		{
			agentGenerator = new AgentGenerator();
		}
		
		public function generateWeather(isInitial:Boolean = false):void
		{
			if(Data.weather.length!=0 && !isInitial){
				Data.weather.shift();				
			}	
			agentGenerator.generateWeather(Data.valueWeather);
		}
		
		public function generateEvent():void
		{
			agentGenerator.generateEvent(Data.valueEvent);
		}
		
		public static function generateTask():Array
		{
			var generate:int = GameUtils.randomFor(4);
			var task:Array = new Array();
			trace("task type",generate);
			switch(generate)
			{
				case 1:
					var transaction:int = Math.floor(Math.random() * Config.transaction.length);
					task = [
						"journal",				
						200,
						Config.transaction[transaction][2].split("[value]").join("100000"),
						"task_journal",
						Config.transaction[transaction][1]
					]
					break;
				case 2:
					var type:int = Math.floor(Math.random() * Data.asset.length);
					var list:Array = new Array();
					for(var j:int = 0; j < Data.asset.length; j++){
						if(int(Data.asset[j].ast_level) < 3){
							list.push(j);
						}
					}
					if(list.length != 0){
						var asset:int = GameUtils.randomFor(list.length-1);
						
						task = [
							"upgrade",				
							500,
							"Upgrade asset "+Data.asset[list[asset]].ast_type+" menjadi level "+(int(Data.asset[list[asset]].ast_level) + 1),
							"task_upgrade",
							Data.asset[asset].ast_type,
							int(Data.asset[asset].ast_level) + 1							
						]
					}
					
					break;
				case 3:
					var price:int = Data.salesToday + (GameUtils.randomFor(50000) + (10000+Data.valuePopulation));
					var target:int = price + (10000 - (price%10000)); 
					task = [
						"selling",				
						200,
						"Lakukan penjualan dengan total IDR "+target,
						"task_selling",
						target					
					];
					break;
				case 4:
					var product:int = Config.material[GameUtils.randomFor(Config.material.length)-1].mtr_id;
					var sold:int = Math.ceil(Math.random() * 100) + 40; 
					task = [
						"order",				
						300,
						"Siapkan material "+Config.material[product-1].mtr_item+" sebanyak "+sold+" buah",
						"task_order",
						product,
						sold				
					];
					break;
			}
			return task;	
		}
		
		public function initialTask():void
		{
			Data.tasks = [
				[
					"journal",				
					200,
					Config.transaction[0][2].toString(),
					"task_journal",
					"Loan"
				],
				[
					"upgrade",				
					500,
					"Upgrade asset Vehicle menjadi level 2",
					"task_upgrade",
					"Vehicle",
					2
				],
				[
					"selling",				
					200,
					"Lakukan penjualan dengan total 150000",
					"task_selling",
					150000
				],
				[
					"order",				
					300,
					"Siapkan Material 'Rice' sebanyak 60 buah",
					"task_order",
					1,
					60
				]
			];
		}
		
		public function initialTransaction():void
		{
			Config.transactionList = [
				[
					"Loan",
					8000000
				],
				[
					"Equity",
					2000000
				],
				[
					"Cart",
					5000000
				],
				[
					"Equipment",
					300000
				],
				[
					"Permit",
					750000
				],
				[
					"Logo",
					500000
				],
				[
					"Insurance",
					300000
				]
			];
		}
		
	}
}