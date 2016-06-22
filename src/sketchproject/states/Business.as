package sketchproject.states
{
	import flash.events.Event;
	
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.AchievementManager;
	import sketchproject.managers.ServerManager;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Business extends Sprite implements IState
	{
		private var game:Game;
		private var server:ServerManager;
		private var achievementManager:AchievementManager;
				
		public function Business(game:Game)
		{
			super();
			this.game = game;
			addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:starling.events.Event):void
		{
			initialize();
			trace("[STATE] BUSINESS");
		}
		
		public function initialize():void
		{
			Game.loadingScreen.show();
			
			achievementManager = new AchievementManager();
			
			var gameObject:Object 			= new Object();
			gameObject.token 				= Data.key;
			gameObject.day		 			= Data.playtime;
			gameObject.served	 			= Math.ceil(Math.random() * 50);
			gameObject.loss 				= Math.ceil(Math.random() * 50);
			
			Data.playtime++;
			var workTime:int = 0;
			for(var i:int = 0; i<Data.schedule.length;i++)
			{
				if(Data.playtime-1 % 7 == i)
				{
					workTime = Data.schedule[i][1] - Data.schedule[i][0];
				}
				 
			}
			gameObject.stress 				= Math.ceil(Math.random() * 100);;
			gameObject.work	 				= workTime;
			gameObject.location		 		= Data.district;
			gameObject.popularity	 		= Math.ceil(Math.random() * 50);
			gameObject.overview		 		= "Good Business";
			
			server = new ServerManager("gameserver/simulation",gameObject);
			server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void{
				Game.loadingScreen.hide();
				
				Data.work = workTime;
				
				initializingSimulation();
			});
			server.sendRequest();
		}
		
		public function initializingSimulation():void
		{
			Data.firstCostOfGood = 0;
			for(var i:int = 0; i<Data.material.length;i++)
			{
				Data.firstCostOfGood += Data.material[i].pma_stock * Data.material[i].mtr_price;
			}
			
			finishingSimulation();
		}
		
		public function finishingSimulation():void
		{
			trace("start of simulation review-------------------------------------");
			// total revenue today
			Data.salesToday = 500000;
			Data.salesTotal+=Data.salesToday;
			trace("sales today "+Data.salesToday);
			
			// push last location player
			Data.locationHistory.push(Data.district);
			trace("location hitory "+Data.locationHistory);
			
			// check inventory left today
			var inventoryLeft:int = 0;
			Data.lastCostOfGood = 0;
			for(var i:int = 0; i<Data.material.length;i++)
			{
				inventoryLeft+= Data.material[i].pma_stock;
				Data.lastCostOfGood += Data.material[i].pma_stock * Data.material[i].mtr_price;
			}
			Data.inventoryHistory.push(inventoryLeft);
			trace("inventory left "+inventoryLeft);
			
			// push average customer feedback today
			Data.customerHistory.push("Satisfied");
			trace("customer satisfied "+Data.customerHistory);
			
			// stress today
			Data.stress = 30;
			
			// push stress level today
			Data.stressHistory.push(30);
			trace("customer stress "+Data.stress);
			
			// push total transaction today
			Data.transactionHistory.push(400);
			trace("transaction "+Data.transactionHistory);
			
			// check player never use hint for today
			if(!Data.isUseHint)
			{
				Data.hintAvoidHistory.push(true);
			}
			else
			{
				Data.hintAvoidHistory.push(false);
			}
			Data.isUseHint = false;
			trace("is use hint "+Data.isUseHint);
			
			// push market share today
			Data.marketShareHistory.push(80);
			trace("marketshare "+Data.marketShareHistory);
			
			// check player always correct posting answer for today
			if(!Data.isFailAnswer)
			{
				Data.correctHistory.push(true);
			}
			else
			{
				Data.correctHistory.push(false);
			}
			Data.isFailAnswer = false;
			trace("is fail answer "+Data.isFailAnswer);
			trace("end of simulation review-------------------------------------");
			
			achievementManager.check_accounting_achievement();
			achievementManager.check_booster_achievement();
			achievementManager.check_customer_achievement();
			achievementManager.check_inventory_achievement();
			achievementManager.check_location_achievement();
			achievementManager.check_market_achievement();
			achievementManager.check_master_achievement();
			achievementManager.check_sales_achievement();
			achievementManager.check_stress_achievement();
			achievementManager.check_transaction_achievement();
			
			LoadingTransition.destination = Game.PLAY_STATE;
			game.changeState(Game.TRANSITION_STATE);
		}
		
		public function update():void
		{
		}
		
		public function destroy():void
		{
		}
		
		public function toString() : String 
		{
			return "sketchproject.states.BusinessState";
		}
	}
}