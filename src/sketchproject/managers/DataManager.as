package sketchproject.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import sketchproject.core.Config;
	import sketchproject.core.Data;

	/**
	 * Responsible to saving and loading player data.
	 *
	 * @author Angga
	 */
	public class DataManager extends EventDispatcher
	{
		private var gameServer:ServerManager;
		public var progress:Number;

		/**
		 * Default constructor of DataManager.
		 */
		public function DataManager()
		{
			gameServer = new ServerManager();
		}

		/**
		 * Populate player data into an object.
		 *
		 * @return Object
		 */
		public function dataCollection():Object
		{
			var gameObject:Object = new Object();
			gameObject.token = Data.key;

			gameObject.playtime = Data.playtime;
			gameObject.point = Data.point;
			gameObject.cash = Data.cash;
			gameObject.customer = Data.customer;
			gameObject.advisor = Data.advisor;
			gameObject.personalObjective = Data.personalObjective;
			gameObject.businessPlan = Data.businessPlan;
			gameObject.financing = Data.financing;
			gameObject.instalment = Data.installment;
			gameObject.weather = JSON.stringify(Data.weather);
			gameObject.event = JSON.stringify(Data.event);
			gameObject.tasks = JSON.stringify(Data.tasks);
			gameObject.booster = JSON.stringify(Data.booster);
			gameObject.avatarName = Data.avatarName;
			gameObject.avatar = JSON.stringify(Data.avatar);
			gameObject.motivation = Data.motivation;

			gameObject.shop = Data.shop;
			gameObject.logo = Data.logo;
			gameObject.district = Data.district;
			gameObject.schedule = JSON.stringify(Data.schedule);
			gameObject.decoration = JSON.stringify(Data.decoration);
			gameObject.scent = JSON.stringify(Data.scent);
			gameObject.cleanness = JSON.stringify(Data.cleanness);
			gameObject.salesToday = Data.salesToday;
			gameObject.salesTotal = Data.salesTotal;
			gameObject.research = JSON.stringify(Data.research);
			gameObject.program = JSON.stringify(Data.program);
			gameObject.advertising = JSON.stringify(Data.advertising);

			gameObject.valuePopulation = Data.valuePopulation;
			gameObject.valueWeather = Data.valueWeather;
			gameObject.valueEvent = Data.valueEvent;
			gameObject.valueCompetitor = Data.valueCompetitor;
			gameObject.valueVariant = Data.valueVariant;
			gameObject.valueAddicted = Data.valueAddicted;
			gameObject.valueBuying = Data.valueBuying;
			gameObject.valueEmotion = Data.valueEmotion;

			gameObject.dataEmployee = JSON.stringify(Data.employee);
			gameObject.dataMaterial = JSON.stringify(Data.material);
			gameObject.dataAsset = JSON.stringify(Data.asset);
			gameObject.dataProduct = JSON.stringify(Data.product);

			return gameObject;
		}

		/**
		 * Create initial data player's when the game is played for the first time.
		 */
		public function setupGameData():void
		{
			gameServer.urlDestination = ServerManager.SERVER_HOST + "gameserver/setup_data";
			gameServer.objectData = dataCollection();

			gameServer.addEventListener(ServerManager.PROGRESS, onSetupProgress);
			gameServer.addEventListener(ServerManager.READY, onSetupComplete);
			gameServer.addEventListener(ServerManager.ERROR, onSetupError);

			gameServer.sendRequest();
		}

		/**
		 * Handle when setup on progress.
		 *
		 * @param event server progress
		 */
		protected function onSetupProgress(event:Event):void
		{
			trace("[SETUP] Setup on progress");
			this.progress = gameServer.progress;
			dispatchEvent(new Event(ServerManager.PROGRESS));
		}

		/**
		 * Handler when setup complete.
		 *
		 * @param event server complete
		 */
		protected function onSetupComplete(event:Event):void
		{
			trace("[SETUP] Setup complete");
			dispatchEvent(new Event(ServerManager.READY));
		}

		/**
		 * Handler when setup data error.
		 *
		 * @param event server error
		 */
		protected function onSetupError(event:Event):void
		{
			trace("[SETUP] Setup error");
			dispatchEvent(new Event(ServerManager.ERROR));
		}

		/**
		 * Save player's data.
		 */
		public function saveGameData():void
		{
			gameServer.urlDestination = ServerManager.SERVER_HOST + "gameserver/save_data";
			gameServer.objectData = dataCollection();

			gameServer.addEventListener(ServerManager.PROGRESS, onSaveProgress);
			gameServer.addEventListener(ServerManager.READY, onSaveComplete);
			gameServer.addEventListener(ServerManager.ERROR, onSaveError);

			gameServer.sendRequest();
		}

		/**
		 * Handler if save data on progress.
		 *
		 * @param event server progress
		 */
		protected function onSaveProgress(event:Event):void
		{
			trace("[SAVE] Save on progress");
			this.progress = gameServer.progress;
			dispatchEvent(new Event(ServerManager.PROGRESS));
		}

		/**
		 * Handler when save data complete.
		 *
		 * @param event server complete
		 */
		protected function onSaveComplete(event:Event):void
		{
			trace("[SAVE] Save complete");
			dispatchEvent(new Event(ServerManager.READY));
		}

		/**
		 * Handler if save data produces errors.
		 *
		 * @param event
		 */
		protected function onSaveError(event:Event):void
		{
			trace("[SAVE] Save error");
			dispatchEvent(new Event(ServerManager.ERROR));
		}

		/**
		 * Load player's data from server and populate data into object
		 */
		public function loadGameData():void
		{
			var playerObject:Object = new Object();
			playerObject.token = Data.key;

			gameServer.urlDestination = ServerManager.SERVER_HOST + "gameserver/load_data";
			gameServer.objectData = playerObject;

			gameServer.addEventListener(ServerManager.PROGRESS, onLoadProgress);
			gameServer.addEventListener(ServerManager.READY, onLoadComplete);
			gameServer.addEventListener(ServerManager.ERROR, onLoadError);

			gameServer.sendRequest();
		}

		/**
		 * Handler when load data request on progress.
		 *
		 * @param event server progress
		 */
		protected function onLoadProgress(event:Event):void
		{
			trace("[LOAD] Load on progress");
			this.progress = gameServer.progress;
			dispatchEvent(new Event(ServerManager.PROGRESS));
		}

		/**
		 * Handler when load data request is complete.
		 *
		 * @param event server complete request
		 */
		protected function onLoadComplete(event:Event):void
		{
			trace("[LOAD] Load complete");
			var result:String = gameServer.received.result_var;

			var game:String = gameServer.received.game_var;
			var candidate:String = gameServer.received.candidate_var;
			var employee:String = gameServer.received.employee_var;
			var product:String = gameServer.received.product_var;
			var playerProduct:String = gameServer.received.player_product_var;
			var productMaterial:String = gameServer.received.product_material_var;
			var material:String = gameServer.received.material_var;
			var playerMaterial:String = gameServer.received.player_material_var;
			var asset:String = gameServer.received.asset_var;
			var playerAsset:String = gameServer.received.player_asset_var;
			var supplier:String = gameServer.received.supplier_var;
			var achievement:String = gameServer.received.achievement_var;
			var account:String = gameServer.received.account_var;
			var simulation:String = gameServer.received.simulation_var;
			var workHistory:String = gameServer.received.work_history_var;
			var workTotal:String = gameServer.received.work_total_var;
			var star:String = gameServer.received.star;

			var generalData:Array = JSON.parse(game) as Array;
			if (JSON.parse(game) as Object != null && generalData == null)
			{
				var gameData:Object = JSON.parse(game) as Object;

				Data.playtime = gameData.gme_playtime;
				Data.point = gameData.gme_point;
				Data.cash = gameData.gme_cash;
				Data.customer = gameData.gme_customer;
				Data.advisor = gameData.gme_advisor;
				Data.personalObjective = gameData.gme_personal_objective;
				Data.businessPlan = gameData.gme_business_plan;
				Data.financing = gameData.gme_financing;
				Data.installment = gameData.gme_instalment;
				Data.weather = JSON.parse(gameData.gme_weather) as Array;
				Data.event = JSON.parse(gameData.gme_event) as Array;
				Data.tasks = JSON.parse(gameData.gme_task) as Array;
				Data.booster = JSON.parse(gameData.gme_booster) as Array;
				Data.avatarName = gameData.gme_avatar_name;
				Data.avatar = JSON.parse(gameData.gme_avatar_data) as Array;
				Data.motivation = gameData.gme_motivation;

				Data.valuePopulation = gameData.par_population;
				Data.valueWeather = gameData.par_weather;
				Data.valueEvent = gameData.par_event;
				Data.valueCompetitor = gameData.par_competitor;
				Data.valueVariant = gameData.par_social;
				Data.valueAddicted = gameData.par_addicted;
				Data.valueBuying = gameData.par_buying;
				Data.valueEmotion = gameData.par_emotion;

				Data.shop = gameData.shp_name;
				Data.logo = gameData.shp_logo;
				Data.district = gameData.shp_district;
				Data.schedule = JSON.parse(gameData.shp_schedule) as Array;
				Data.decoration = JSON.parse(gameData.shp_decoration) as Array;
				Data.scent = JSON.parse(gameData.shp_scent) as Array;
				Data.cleanness = JSON.parse(gameData.shp_cleanness) as Array;
				Data.salesToday = gameData.shp_sales_today;
				Data.salesTotal = gameData.shp_sales_total;
				Data.research = JSON.parse(gameData.shp_research_data) as Array;
				Data.program = JSON.parse(gameData.shp_program_data) as Array;
				Data.advertising = JSON.parse(gameData.shp_advertising_data) as Array;
			}

			if (JSON.parse(candidate) as Array != null)
				Config.candidate = JSON.parse(candidate) as Array;

			if (JSON.parse(employee) as Array != null)
				Data.employee = JSON.parse(employee) as Array;

			if (JSON.parse(material) as Array != null)
				Config.material = JSON.parse(material) as Array;

			if (JSON.parse(playerMaterial) as Array != null)
				Data.material = JSON.parse(playerMaterial) as Array;

			if (JSON.parse(asset) as Array != null)
				Config.asset = JSON.parse(asset) as Array;

			if (JSON.parse(playerAsset) as Array != null)
				Data.asset = JSON.parse(playerAsset) as Array;

			if (JSON.parse(product) as Array != null)
				Config.product = JSON.parse(product) as Array;
			
			if (JSON.parse(playerProduct) as Array != null && (JSON.parse(playerProduct) as Array).length > 0)
				Data.product = JSON.parse(playerProduct) as Array;
			else
				Data.product = JSON.parse(product) as Array;

			if (JSON.parse(productMaterial) as Array != null)
			{
				Data.productMaterial = JSON.parse(productMaterial) as Array;
				for (var i:int = 0; i < Data.productMaterial.length; i++)
				{
					Data.productMaterial[i].material = String(Data.productMaterial[i].material).split(",");
				}
			}

			if (JSON.parse(supplier) as Array != null)
				Config.supplier = JSON.parse(supplier) as Array;

			if (JSON.parse(achievement) as Array != null)
				Data.achievement = JSON.parse(achievement) as Array;

			if (JSON.parse(account) as Array != null)
			{
				var accountList:Array = JSON.parse(account) as Array;

				Config.account = new Array();
				for (var j:uint = 0; j < accountList.length; j++)
				{
					var data:Object = {id: accountList[j].acn_id, text: accountList[j].acn_account};
					Config.account.push(data);
				}
			}

			if (JSON.parse(simulation) as Array != null)
				Data.simulation = JSON.parse(simulation) as Array;

			if (JSON.parse(workHistory) as Array != null)
			{
				var history:Array = JSON.parse(workHistory) as Array;

				Data.workHistory = new Array();
				Data.stressHistory = new Array();
				var wTotal:Number = 0;

				for (var k:uint = 0; k < history.length; k++)
				{
					Data.workHistory.push(history[k].sim_work_hour);
					Data.stressHistory.push(history[k].sim_stress);

					wTotal += int(history[k].sim_work_hour);
				}
				if (history.length > 0)
				{
					Data.stress = history[history.length - 1].sim_stress;
					Data.work = history[history.length - 1].sim_work_hour;
					Data.workAvg = wTotal / history.length;
					Data.workTotal = int(workTotal);
				}
				else
				{
					Data.stress = 0;
					Data.work = 0;
					Data.workAvg = 0;
					Data.workTotal = 0;
				}
			}
			
			Data.stars = int(star);

			dispatchEvent(new Event(ServerManager.READY));
		}

		/**
		 * Handler when load data error.
		 *
		 * @param event server error request
		 */
		protected function onLoadError(event:Event):void
		{
			trace("[LOAD] Load on error");
			dispatchEvent(new Event(ServerManager.ERROR));
		}

		/**
		 * Print game data for debuging.
		 */
		public static function traceGameData():void
		{
			trace("\nGAMEDATA------------------------------------------------");
			trace("playtime", Data.playtime);
			trace("point", Data.point);
			trace("cash", Data.cash);
			trace("customer", Data.customer);
			trace("advisor", Data.advisor);
			trace("personalObjective", Data.personalObjective);
			trace("businessPlan", Data.businessPlan);

			trace("---------------------------------------");

			trace("playtime", Data.financing);
			trace("instalment", Data.installment);
			trace("weather", JSON.stringify(Data.weather));
			trace("event", JSON.stringify(Data.event));
			trace("tasks", JSON.stringify(Data.tasks));
			trace("booster", Data.booster);
			trace("avatarName", Data.avatarName);
			trace("avatar", JSON.stringify(Data.avatar));
			trace("motivation", Data.motivation);
			trace("booster", Data.booster);

			trace("---------------------------------------");

			trace("valuePopulation", Data.valuePopulation);
			trace("valueWeather", Data.valueWeather);
			trace("valueEvent", Data.valueEvent);
			trace("valueCompetitor", Data.valueCompetitor);
			trace("valueVariant", Data.valueVariant);
			trace("valueAddicted", Data.valueAddicted);
			trace("valueBuying", Data.valueBuying);
			trace("valueEmotion", Data.valueEmotion);

			trace("---------------------------------------");

			trace("shop", Data.shop);
			trace("logo", Data.logo);
			trace("district", Data.district);
			trace("schedule", JSON.stringify(Data.schedule));
			trace("decoration", JSON.stringify(Data.decoration));
			trace("scent", JSON.stringify(Data.scent));
			trace("cleanness", JSON.stringify(Data.cleanness));
			trace("salesToday", Data.salesToday);
			trace("salesTotal", Data.salesTotal);
			trace("research", JSON.stringify(Data.research));
			trace("program", JSON.stringify(Data.program));
			trace("advertising", JSON.stringify(Data.advertising));

			trace("---------------------------------------");

			trace("employee", JSON.stringify(Data.employee));
			trace("inventory", JSON.stringify(Data.material));
			trace("asset", JSON.stringify(Data.asset));
			trace("product", JSON.stringify(Data.product));
			trace("achievement", JSON.stringify(Data.achievement));
			trace("simulation", JSON.stringify(Data.simulation));

			trace("----------------------------------------------------------\n");
			
			trace("master event", Config.event);
			trace("master weather", Config.weather);
			trace("master district", Config.district);
			trace("master advertisement", Config.advertisement);
			trace("master research", JSON.stringify(Config.research));
		}
	}
}
