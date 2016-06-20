package sketchproject.managers
{
	import sketchproject.core.Config;
	import sketchproject.core.Data;

	/**
	 * Achievement unlock checker.
	 * 
	 * @author Angga
	 */
	public class AchievementManager
	{
		private var achievedData:Object;

		/**
		 * Default constructor of AchievementManager
		 */
		public function AchievementManager()
		{
		}

		/**
		 * Check if player unlock sales achievement,
		 * sales today must be over than or equal 500.000
		 */
		public function check_sales_achievement():void
		{
			// check sales today over 500.000 sold profit
			if (Data.salesToday >= 500000)
			{
				// push sales achievment - id 1
				achievedData = getAchievementUnlockInfo(1);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] sales unlocked ");
			}
		}

		/**
		 * Check if player unlock location achievement,
		 * player should placed the shop in all district in one game.
		 */
		public function check_location_achievement():void
		{
			var totalLocation:int = 0;
			for (var i:int = 0; i < Config.district.length; i++)
			{
				for (var j:int = 0; j < Data.locationHistory.length; j++)
				{
					// check district history have all district in game world
					if (Config.district[i][1] == Data.locationHistory[j])
					{
						totalLocation++;
						break;
					}
				}
			}

			// check shop have been open in all location
			if (totalLocation >= Config.district.length)
			{
				// push location achievement - id 2
				achievedData = getAchievementUnlockInfo(2);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] location unlocked ");
				// reset history
				Data.locationHistory = new Array();
			}
		}

		/**
		 * Check if player unlock inventory achievement,
		 * inventory must left 1 - 15 items 3 days in row.
		 */
		public function check_inventory_achievement():void
		{
			var perfectInventory:int = 0;
			for (var i:int = 0; i < Data.inventoryHistory.length; i++)
			{
				// perfect inventory with condition, 1-15 items left after shop closed
				if (Data.inventoryHistory[i] >= 1 && Data.inventoryHistory[i] <= 15)
				{
					perfectInventory++;
				}
			}

			// check when inventory perfect stock for 3 days in row
			if (perfectInventory == 3)
			{
				// push inventory achievement - id 3
				achievedData = getAchievementUnlockInfo(3);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] inventory unlocked");
				// reset history
				Data.inventoryHistory = new Array();
			}

			// remove first record when array contain 3 data that mean player fail to make perfect inventory for 3 days in row
			if (Data.inventoryHistory.length == 3)
			{
				Data.inventoryHistory.shift();
			}
		}


		/**
		 * Check if player unlock inventory customer,
		 * customer must give overall feedback satisfied.
		 */
		public function check_customer_achievement():void
		{
			var customerSatisfied:int = 0;
			for (var i:int = 0; i < Data.customerHistory.length; i++)
			{
				if (Data.customerHistory[i] == "Satisfied" || Data.customerHistory[i] == "Happy")
				{
					customerSatisfied++;
				}
			}

			// check when customer average feedback is Satisfied or Happy for 7 days in row
			if (customerSatisfied == 7)
			{
				// push customer achievement - id 4
				achievedData = getAchievementUnlockInfo(4);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] customer unlocked");
				// reset history
				Data.customerHistory = new Array();
			}

			// remove first record when array contain 7 data that means player fail to make customer Satisfied or Happy for 7 days in row
			if (Data.customerHistory.length == 7)
			{
				Data.customerHistory.shift();
			}
		}

		/**
		 * Check if player unlock stress achievement,
		 * maintain stress below 40 for 6 days in row.
		 */
		public function check_stress_achievement():void
		{
			var lowStress:int = 0;
			for (var i:int = 0; i < Data.stressHistory.length; i++)
			{
				// check if stress below 40% level
				if (Data.stressHistory[i] < 40)
				{
					lowStress++;
				}
			}

			// check when stress in low level for 6 days in row
			if (lowStress == 6)
			{
				// push stress achievement - id 5
				achievedData = getAchievementUnlockInfo(5);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] stress unlocked");
				// reset history
				Data.stressHistory = new Array();
			}

			// remove first record when array contain 6 data that mean player fail to make low stress for 6 days in row
			if (Data.stressHistory.length == 6)
			{
				Data.stressHistory.shift();
			}
		}

		/**
		 * Check if player unlock transaction achievement,
		 * making transaction over 50 times for 5 days in row.
		 */
		public function check_transaction_achievement():void
		{
			var transaction:int = 0;
			for (var i:int = 0; i < Data.transactionHistory.length; i++)
			{
				// check if transaction reach or more than 50
				if (Data.transactionHistory[i] >= 50)
				{
					transaction++;
				}
			}

			// check when stress in low level for 5 days in row
			if (transaction == 5)
			{
				// push transaction achievement - id 6
				achievedData = getAchievementUnlockInfo(6);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] transaction unlocked");
				// reset history
				Data.transactionHistory = new Array();
			}

			// remove first record when array contain 5 data that mean player fail to make 50 transaction minimum for 6 days in row
			if (Data.transactionHistory.length == 5)
			{
				Data.transactionHistory.shift();
			}
		}

		/**
		 * Check if player unlock accounting achievement,
		 * player not allowed use hint for 7 days in row.
		 */
		public function check_accounting_achievement():void
		{
			var hintAvoid:int = 0;
			for (var i:int = 0; i < Data.hintAvoidHistory.length; i++)
			{
				// check if player never use hint day
				if (Data.hintAvoidHistory[i])
				{
					hintAvoid++;
				}
			}

			// check when never use hint for 7 days in row
			if (hintAvoid == 7)
			{
				// push accounting achievement - id 7
				achievedData = getAchievementUnlockInfo(7);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] hint unlocked");
				// reset history
				Data.hintAvoidHistory = new Array();
			}

			// remove first record when array contain 5 data that mean player fail avoid hint for 7 days in row
			if (Data.hintAvoidHistory.length == 7)
			{
				Data.hintAvoidHistory.shift();
			}
		}

		/**
		 * Check if player unlock booster achievement,
		 * all level of boosters must 5.
		 */
		public function check_booster_achievement():void
		{
			// booster achievement just reach once in game
			if (Data.achievement[7].earned == 0)
			{
				var totalBooster:int = 0;
				for (var i:int = 0; i < Data.booster.length; i++)
				{
					// check all booster in level 5
					if (Data.booster[i] == 5)
					{
						totalBooster++;
					}
				}

				if (totalBooster == 4)
				{
					achievedData = getAchievementUnlockInfo(8);
					Config.achieved.push(achievedData);
					trace("[ACHIEVEMENT] booster unlocked");
				}
			}
		}

		/**
		 * Check if player unlock market achievement,
		 * market share should up to 70% for 7 days in row.
		 */
		public function check_market_achievement():void
		{
			var marketShare:int = 0;
			for (var i:int = 0; i < Data.marketShareHistory.length; i++)
			{
				// check if market share reach or more than 70%
				if (Data.marketShareHistory[i] >= 70)
				{
					marketShare++;
				}
			}

			// check when market share reach 7 times
			if (marketShare == 7)
			{
				// push market share achievement - id 9
				achievedData = getAchievementUnlockInfo(9);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] marketshare unlocked");
				// reset history
				Data.marketShareHistory = new Array();
			}

			// remove first record when array contain 7 data that mean player fail to reach 70%  or more market share for 7 days in row
			if (Data.marketShareHistory.length == 7)
			{
				Data.marketShareHistory.shift();
			}
		}

		/**
		 * Check if player unlock master achievement,
		 * player can answer posting question correctly in 20 days
		 */
		public function check_master_achievement():void
		{
			var correct:int = 0;
			for (var i:int = 0; i < Data.correctHistory.length; i++)
			{
				// check if correct answer
				if (Data.correctHistory[i])
				{
					correct++;
				}
			}

			// check when correct answer reach 20 days in row
			if (correct == 20)
			{
				// push master achievement - id 10
				achievedData = getAchievementUnlockInfo(10);
				Config.achieved.push(achievedData);
				trace("[ACHIEVEMENT] master unlocked");
				// reset history
				Data.correctHistory = new Array();
			}

			// remove first record when array contain 10 data that mean player fail to make mastering for 30 days days in row
			if (Data.correctHistory.length == 20)
			{
				Data.correctHistory.splice(0, 1);
			}
		}

		/**
		 * Update earned achievement data.
		 * 
		 * @param id of achievement
		 * @return
		 */
		public function getAchievementUnlockInfo(id:int):Object
		{
			for (var i:int = 0, l:int = Data.achievement.length; i < l; i++)
			{
				if (Data.achievement[i].ach_id == id)
				{
					Data.achievement[i].earned = int(Data.achievement[i].earned) + 1;
					return Data.achievement[i];
				}
			}
			return null;
		}
	}
}
