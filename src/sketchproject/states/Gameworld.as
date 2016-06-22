package sketchproject.states
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.AchievementManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.modules.EventFactory;
	import sketchproject.objects.dialog.DailyReportDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.objects.world.GameStats;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Simulation marketplace.
	 *
	 * @author Angga
	 */
	public class Gameworld extends Sprite implements IState
	{
		// game component
		private var game:Game;
		private var map:Map;
		private var stats:GameStats;

		// map drag and drop property
		private var _startXPos:int = 0;
		private var _startYPos:int = 0;
		private var currentXPos:int = 0;
		private var currentYPos:int = 0;
		private var newXPos:int = 0;
		private var newYPos:int = 0;
		private var minX:int = -300 * Config.zoom;
		private var maxX:int = 1450 * Config.zoom;
		private var minY:int = -831 * Config.zoom;
		private var maxY:int = 13 * Config.zoom;
		private var globalPosition:Point = new Point();
		private var touch:Touch;
		private var target:DisplayObject;
		private var position:Point;

		private var isSimulationStarted:Boolean;
		private var isDailyReportShowed:Boolean;

		private var dailyReport:DailyReportDialog;
		private var postDialog:PostDialog;

		private var server:ServerManager;
		private var achievementManager:AchievementManager;
		
		private var simulationOverview:int = 0;

		public function Gameworld(game:Game)
		{
			super();
			this.game = game;
			addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
		}

		public function init():void
		{
			trace("[STATE] GAMEWORLD");
			initialize();
		}

		public function initialize():void
		{
			isSimulationStarted = true;
			isDailyReportShowed = false;
			
			Data.soldFood1 = 0;
			Data.soldFood2 = 0;
			Data.soldFood3 = 0;
			Data.soldDrink1 = 0;
			Data.soldDrink2 = 0;
			
			Data.salesToday = 0;
			Data.marketshare = 0;
			Data.transaction = 0;
			Data.transactionAllShop = 0;
			
			Data.open = int(Data.schedule[DayCounter.numberDayWeek()][0]);
			Data.close = int(Data.schedule[DayCounter.numberDayWeek()][1]);

			map = new Map(isSimulationStarted);
			map.x = 500;
			map.y = -300;
			map.addEventListener(TouchEvent.TOUCH, onWorldTouched);
			addChild(map);

			stats = new GameStats();
			stats.addEventListener(GameStats.SHOP_OPEN, onShopOpen);
			stats.addEventListener(GameStats.SHOP_CLOSE, onShopClose);
			addChild(stats);

			postDialog = new PostDialog("Revenue", Data.salesToday, false, false);
			postDialog.x = stage.stageWidth * 0.5;
			postDialog.y = stage.stageHeight * 0.5;
			postDialog.addEventListener(PostDialog.POSTING, function(event:starling.events.Event):void
			{
				Config.transactionList.splice(0, 1);
				retrievePosting();
			});
			Game.overlayStage.addChild(postDialog);

			dailyReport = new DailyReportDialog();
			dailyReport.x = Starling.current.stage.stageWidth * 0.5;
			dailyReport.y = Starling.current.stage.stageHeight * 0.5;
			dailyReport.addEventListener(DailyReportDialog.REQUEST_POST, function(event:starling.events.Event):void
			{
				isDailyReportShowed = false;
				dailyReport.closeDialog();
				retrievePosting();
			});
			addChild(dailyReport);
		}

		/**
		 * Retrieve stack of posting transaction.
		 */
		private function retrievePosting():void
		{
			if (Config.transactionList.length > 0)
			{
				postDialog.transactionType = Config.transactionList[0][0];
				postDialog.transactionValue = Config.transactionList[0][1];
				postDialog.preparePosting();
				postDialog.openDialog();
			}
			else
			{
				Game.loadingScreen.show();
				
				var dataNonExpired:Array = [12, 16, 17, 18, 19];
				
				// substract expired remaining
				for (var i:int = 0; i < Data.material.length; i++)
				{
					var noExpired:Boolean = false;
					for (var j:int = 0; j < dataNonExpired.length; j++)
					{
						if(dataNonExpired[j] == Data.material[i].mtr_id){
							noExpired = true;
							break;
						}
					}
					
					if(!noExpired){
						Data.material[i].pma_expired_remaining--;
					}
				}
				
				var gameObject:Object = new Object();
				gameObject.token = Data.key;
				gameObject.material_data = JSON.stringify(Data.material);
				
				server = new ServerManager("inventory/update_material", gameObject);
				server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void
				{
					Game.loadingScreen.hide();
										
					LoadingTransition.destination = Game.PLAY_STATE;
					game.changeState(Game.TRANSITION_STATE);
				});
				server.sendRequest();				
			}
		}

		/**
		 * Dispatching action when shop open.
		 *
		 * @param event
		 */
		private function onShopOpen(event:starling.events.Event):void
		{
			trace("shop open-----prepare the simulation");

			// total first cost of good
			Data.firstCostOfGood = 0;
			for (var i:int = 0; i < Data.material.length; i++)
			{
				Data.firstCostOfGood += Data.material[i].pma_stock * Data.material[i].mtr_price;
			}
		}

		/**
		 * Dispatching action when shop closed.
		 *
		 * @param event
		 */
		private function onShopClose(event:starling.events.Event):void
		{
			isSimulationStarted = false;
			var factory:EventFactory = new EventFactory();
			factory.generateEvent();
			factory.generateWeather();
			saveSimulationToday();
		}

		/**
		 * Save simulation today.
		 */
		private function saveSimulationToday():void
		{
			Game.loadingScreen.show();

			var gameObject:Object = new Object();
			gameObject.token = Data.key;
			gameObject.day = Data.playtime;
			gameObject.served = Data.transaction;
			gameObject.loss = Data.transactionAllShop - Data.transaction;

			var workTime:int = 0;

			for (var i:int = 0; i < Data.schedule.length; i++)
			{
				if (Data.playtime - 1 % 7 == i)
				{
					workTime = Data.schedule[i][1] - Data.schedule[i][0];
					break;
				}
			}
			var workStress:int = 100 * workTime / 15;
			
			gameObject.work = workTime;
			gameObject.stress = workStress > 100 ? 100 : workStress;
			gameObject.location = Data.district;
			gameObject.popularity = Data.marketshare;
			if (Data.marketshare > 80)
			{
				gameObject.overview = "Great Business";
				simulationOverview = 0;
			}
			else if (Data.marketshare > 70)
			{
				gameObject.overview = "Good Business";
				simulationOverview = 1;
			}
			else if (Data.marketshare > 60)
			{
				gameObject.overview = "Avg Business";
				simulationOverview = 2;
			}
			else if (Data.marketshare > 30)
			{
				gameObject.overview = "Mediocre Business";
				simulationOverview = 3;
			}
			else
			{
				gameObject.overview = "Bad Business";
				simulationOverview = 4;
			}

			Data.playtime++;

			server = new ServerManager("gameserver/insert_simulation", gameObject);
			server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void
			{
				Game.loadingScreen.hide();

				Data.work = workTime;
				Data.stress = workStress;

				checkUnlockedAchievements();

				preparePostingTransaction();
			});
			server.sendRequest();
		}

		/**
		 * Check and unlock achievement manager.
		 */
		private function checkUnlockedAchievements():void
		{
			achievementManager = new AchievementManager();

			// total revenue today
			Data.salesTotal += Data.salesToday;
			trace("sales today " + Data.salesToday);

			// push last location player
			Data.locationHistory.push(Data.district);
			trace("location hitory " + Data.locationHistory);

			// check inventory left today
			var inventoryLeft:int = 0;
			Data.lastCostOfGood = 0;
			for (var j:int = 0; j < Data.material.length; j++)
			{
				inventoryLeft += Data.material[j].pma_stock;
				Data.lastCostOfGood += Data.material[j].pma_stock * Data.material[j].mtr_price;
			}
			Data.inventoryHistory.push(inventoryLeft);
			trace("inventory left " + inventoryLeft);

			// push average customer feedback today
			Data.customerHistory.push(Config.emotion[simulationOverview][1]);
			trace("customer satisfied " + Data.customerHistory);

			// stress today, push stress level today
			Data.stressHistory.push(Data.stress);
			trace("customer stress " + Data.stress);

			// push total transaction today
			Data.transactionHistory.push(Data.transaction);
			trace("transaction " + Data.transactionHistory);

			// check player never use hint for today
			if (!Data.isUseHint)
			{
				Data.hintAvoidHistory.push(true);
			}
			else
			{
				Data.hintAvoidHistory.push(false);
			}
			Data.isUseHint = false;
			trace("is use hint " + Data.isUseHint);

			// push market share today
			Data.marketShareHistory.push(Data.marketshare);
			trace("marketshare " + Data.marketShareHistory);

			// check player always correct posting answer for today
			if (!Data.isFailAnswer)
			{
				Data.correctHistory.push(true);
			}
			else
			{
				Data.correctHistory.push(false);
			}
			Data.isFailAnswer = false;
			trace("is fail answer " + Data.isFailAnswer);

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
		}

		/**
		 * Calculate revenue and expenses after simulation.
		 */
		private function preparePostingTransaction():void
		{
			var expensesTotal:int = 0;

			Config.transactionList = new Array();

			// check business revenue
			if (Data.salesToday > 0){
				Config.transactionList.push(new Array("Revenue", Data.salesToday));
			}

			// check business cost of good
			if (Data.firstCostOfGood - Data.lastCostOfGood > 0){
				Config.transactionList.push(new Array("Cost", Data.firstCostOfGood - Data.lastCostOfGood));
			}

			// check business employee
			if (Data.employee.length > 0)
			{
				var totalSalary:int = 0;
				for (var i:uint = 0; i < Data.employee.length; i++)
				{
					totalSalary += int(Data.employee[i].pem_salary);
				}
				Config.transactionList.push(new Array("Employee", totalSalary));
				expensesTotal = totalSalary;
			}

			// check advertisement
			if (Data.advertisingCost[0][1] > 0){
				Config.transactionList.push(new Array("Advertising TV", Data.advertisingCost[0][1]));
				expensesTotal += Data.advertisingCost[0][1];
			}
			if (Data.advertisingCost[1][1] > 0){
				Config.transactionList.push(new Array("Advertising Radio", Data.advertisingCost[1][1]));
				expensesTotal += Data.advertisingCost[1][1];
			}
			if (Data.advertisingCost[2][1] > 0){
				Config.transactionList.push(new Array("Advertising Newspaper", Data.advertisingCost[2][1]));
				expensesTotal += Data.advertisingCost[2][1];
			}
			if (Data.advertisingCost[3][1] > 0){
				Config.transactionList.push(new Array("Advertising Internet", Data.advertisingCost[3][1]));
				expensesTotal += Data.advertisingCost[3][1];
			}
			if (Data.advertisingCost[4][1] > 0){
				Config.transactionList.push(new Array("Advertising Event", Data.advertisingCost[4][1]));
				expensesTotal += Data.advertisingCost[4][1];
			}
			if (Data.advertisingCost[5][1] > 0){
				Config.transactionList.push(new Array("Advertising Billboard", Data.advertisingCost[5][1]));
				expensesTotal += Data.advertisingCost[5][1];
			}

			// check research
			if (Data.researchCost > 0){
				Config.transactionList.push(new Array("Quality", Data.researchCost));
				expensesTotal += Data.researchCost;
			}

			// check program
			if (Data.programCost > 0){
				Config.transactionList.push(new Array("Training", Data.programCost));
				expensesTotal += Data.programCost;
			}
			
			trace("daily report :", Data.salesToday, expensesTotal, Data.salesToday - expensesTotal);

			isDailyReportShowed = true;
			dailyReport.generateDailyReport(Data.salesToday, expensesTotal, Data.salesToday - expensesTotal, [Data.soldFood1, Data.soldFood2, Data.soldFood3, Data.soldDrink1, Data.soldDrink2]);
			dailyReport.openDialog();
		}

		/**
		 * Drag and drop the map.
		 *
		 * @param e
		 */
		private function onWorldTouched(e:TouchEvent):void
		{
			touch = e.getTouch(stage);
			target = e.currentTarget as DisplayObject;

			if (touch == null)
			{
				return;
			}

			position = touch.getLocation(stage);

			if (touch.phase == TouchPhase.BEGAN)
			{
				// store start of drag x pos
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;

				_startXPos = target.globalToLocal(globalPosition).x;
				_startYPos = target.globalToLocal(globalPosition).y;
			}
			else if (touch.phase == TouchPhase.MOVED)
			{
				// calculate new x based on touch's global coordinates
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;

				currentXPos = target.globalToLocal(globalPosition).x;
				currentYPos = target.globalToLocal(globalPosition).y;

				newXPos = target.x + currentXPos - _startXPos;
				newYPos = target.y + currentYPos - _startYPos;

				if (newXPos <= maxX && newXPos >= minX) // set target's x if it falls within limits
					target.x = newXPos;

				if (newYPos <= maxY && newYPos >= minY) // set target's y if it falls within limits
					target.y = newYPos;
			}

			return;
		}

		/**
		 * Update the game world.
		 */
		public function update():void
		{
			if (isSimulationStarted)
			{
				map.update(stats.clock.hour, stats.clock.minute);
				stats.update();
			}
			else if (isDailyReportShowed)
			{
				dailyReport.update();
			}
		}

		/**
		 * Remove resources of state.
		 */
		public function destroy():void
		{
			stats.destroy();
			dailyReport.destroy();
			removeFromParent(true);
		}

		/**
		 * Return name of state.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.states.GameworldState";
		}
	}
}
