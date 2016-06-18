package sketchproject.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import sketchproject.managers.DataManager;
	import sketchproject.managers.ServerManager;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Load saved game and XML data.
	 *
	 * @author Angga
	 */
	public class DataLoader extends EventDispatcher
	{
		public static const DATA_LOADED:String = "dataLoaded";

		private var mapLoaded:Boolean = false;
		private var weatherLoaded:Boolean = false;
		private var eventLoaded:Boolean = false;
		private var tipsLoaded:Boolean = false;
		private var districtLoaded:Boolean = false;
		private var researchLoaded:Boolean = false;
		private var transactionLoaded:Boolean = false;
		private var advertisementLoaded:Boolean = false;
		private var gameData:Boolean = false;

		/**
		 * Default constructor of DataLoader.
		 */
		public function DataLoader()
		{

		}

		/**
		 * Load game data from server.
		 */
		public function loadData():void
		{
			var server:DataManager = new DataManager();
			server.addEventListener(ServerManager.READY, initializingLoadData);
			server.loadGameData();
		}

		private function initializingLoadData(e:flash.events.Event):void
		{
			gameData = true;
			gameDataLoaded();
		}

		/**
		 * Load isometric XML data.
		 */
		public function loadMapData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingMapData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/graphics/IsometricAtlas.xml"));
		}

		/**
		 * Building isometric tile pivot data.
		 * 
		 * @param e events listener
		 */
		private function initializingMapData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.levelPivot = new Array();
			for each (var item:XML in xmlData.children())
			{
				var mapInfo:Object = {
					name: item.attribute("name"), 
					pivotX: item.attribute("pivotX"), 
					pivotY: item.attribute("pivotY")
				};
				Config.levelPivot.push(mapInfo);
			}

			mapLoaded = true;
			gameDataLoaded();
		}

		/**
		 * Load weather XML data.
		 */
		public function loadWeatherData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingWeatherData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/weather.xml"));
		}

		/**
		 * Building weather list data.
		 * 
		 * @param e events listener
		 */
		private function initializingWeatherData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.weather = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.name), 
					int(item.min), 
					int(item.max), 
					Number(item.probability), 
					String(item.status)
				];

				Config.weather.push(row);
			}

			weatherLoaded = true;
			gameDataLoaded();
		}


		/**
		 * Load event XML data data.
		 */
		public function loadEventData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingEventData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/event.xml"));
		}

		/**
		 * Building event list data.
		 * 
		 * @param e event listener
		 */
		private function initializingEventData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.event = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.name), 
					String(item.district), 
					new Array(
						String(item.traffic.normal), 
						String(item.traffic.weekend), 
						String(item.traffic.holiday)
					), 
					new Array(
						int(item.profile.education), 
						int(item.profile.art), 
						int(item.profile.athletic)
					), 
					new Array(
						int(item.time.start), 
						int(item.time.finish)
					)
				];

				Config.event.push(row);
			}

			eventLoaded = true;
			gameDataLoaded();
		}


		/**
		 * Load tips XML data data.
		 */
		public function loadTipsData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingTipsData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/tipsoftheday.xml"));
		}

		/**
		 * Building tips list data.
		 * 
		 * @param e event listener
		 */
		private function initializingTipsData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.tipsOfTheDay = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.title), 
					String(item.content)
				];

				Config.tipsOfTheDay.push(row);
			}

			tipsLoaded = true;
			gameDataLoaded();
		}


		/**
		 * Load district XML data.
		 */
		public function loadDistrict():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingDistrictData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/district.xml"));
		}

		/**
		 * Building district list data.
		 * 
		 * @param e event listener
		 */
		private function initializingDistrictData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.district = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.name), 
					String(item.atlas), 
					String(item.description), 
					String(item.priority), 
					new Array(
						Number(item.population.low), 
						Number(item.population.normal), 
						Number(item.population.high)
					), 
					new Array(
						String(item.marker.atlas), 
						int(item.marker.x), 
						int(item.marker.y)
					), 
					int(item.cost), 
					new Point(int(item.shop.x), int(item.shop.y))
				];
				Config.district.push(row);
			}

			Config.location = new Array();
			for (var i:uint = 0; i < Config.district.length; i++)
			{
				var data:Object = {id: Config.district[i][0], text: Config.district[i][1]};
				Config.location.push(data);
			}

			districtLoaded = true;
			gameDataLoaded();
		}

		/**
		 * Load research XML data.
		 */
		public function loadResearchData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingResearchData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/research.xml"));
		}

		/**
		 * Building research list data.
		 * 
		 * @param e event listener
		 */
		private function initializingResearchData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.research = new Array();
			Data.research = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.name), 
					int(item.cost)
				];

				Config.research.push(row);
				Data.research.push(0);
			}

			researchLoaded = true;
			gameDataLoaded();
		}


		/**
		 * load transaction XML data.
		 */
		public function loadTransactionData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingTransactionData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/transaction.xml"));
		}

		/**
		 * Building transaction list data.
		 * 
		 * @param e event listener
		 */
		private function initializingTransactionData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.transaction = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.type), 
					String(item.name), 
					String(item.hint), 
					String(item.debit), 
					String(item.credit), 
					String(item.description)
				];
				Config.transaction.push(row);
			}

			transactionLoaded = true;
			gameDataLoaded();
		}

		/**
		 * Load advertisement XML data.
		 */
		public function loadAdvertisementData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingAdvertisementData);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace("XML error : " + event.toString());
			});
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "game/assets/data/ads.xml"));		
		}

		/**
		 * Building advertising list data.
		 * 
		 * @param e event listener
		 */
		private function initializingAdvertisementData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.advertisement = new Array();
			Data.advertising = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [
					int(item.attribute("id")), 
					String(item.name), 
					String(item.atlas), 
					new Array(
						int(item.visibility.none), 
						int(item.visibility.low), 
						int(item.visibility.average), 
						int(item.visibility.high))
				];
				Config.advertisement.push(row);
				Data.advertising.push(new Array(int(row[0]), 0, 0));
			}
			advertisementLoaded = true;
			gameDataLoaded();
		}

		/**
		 * Check if all data has been loaded.
		 */
		private function gameDataLoaded():void
		{
			if (mapLoaded && weatherLoaded && eventLoaded && tipsLoaded && districtLoaded && eventLoaded && transactionLoaded && advertisementLoaded && gameData)
			{
				dispatchEvent(new starling.events.Event(DATA_LOADED));
			}
		}
	}
}
