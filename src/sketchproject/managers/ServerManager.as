package sketchproject.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * Server communication manager.
	 *
	 * @author Angga
	 */
	public class ServerManager extends EventDispatcher
	{
		/** constant server configuration */
		public static const SERVER_HOST:String = "http://localhost/businesscareer/";
		public static const NO_SESSION:String = "no_session";
		public static const READY_SESSION:String = "ready_session";

		/** constant dispatch event type */
		public static const READY:String = "ready";
		public static const PROGRESS:String = "progress";
		public static const ERROR:String = "error";

		/** public variable from server */
		public var received:URLVariables;
		public var progress:Number;
		public var error:String;

		/** assign a variable name for our URLVariables object; */
		private var variables:URLVariables;

		/** build the request variable */
		private var request:URLRequest;

		/** build the varLoader variable */
		private var loader:URLLoader;

		/** data carrier variable */
		private var data:Object;
		private var url:String;
		
		/**
		 * Default constructor of ServerManager.
		 * 
		 * @param dest uri destination without root
		 * @param dataVars data which is passed to the server
		 */
		public function ServerManager(dest:String = "", dataVars:Object = null)
		{
			url = ServerManager.SERVER_HOST + dest;
			data = dataVars;
		}

		/**
		 * Building communication request.
		 */
		public function sendRequest():void
		{
			request = new URLRequest(url);
			variables = new URLVariables();
			loader = new URLLoader();
			parseVariables();
		}

		/**
		 * Set url directly.
		 * 
		 * @param url destination
		 */
		public function set urlDestination(url:String):void
		{
			this.url = url;
			this.request = new URLRequest(url);
		}

		/**
		 * Get current url.
		 * 
		 * @return 
		 */
		public function get urlDestination():String
		{
			return this.url;
		}

		/**
		 * Set object data which is passed to the server.
		 * 
		 * @param data
		 */
		public function set objectData(data:Object):void
		{
			this.data = data;
		}

		/**
		 * Get data which is passed to the server.
		 * 
		 * @return 
		 */
		public function get objectData():Object
		{
			return this.data;
		}

		/**
		 * Parse object data into variable class.
		 * 
		 * @return void
		 */
		private function parseVariables():void
		{
			for (var item:* in data)
			{
				variables[item] = data[item];
			}
			serverRequest();
		}

		/**
		 * Making server request by parameters have been set and 
		 * add event handler to catch the request responds.
		 * 
		 * @return void
		 */
		private function serverRequest():void
		{
			request.method = URLRequestMethod.POST;
			request.data = variables;

			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(request);
		}

		/**
		 * Handler when communication complete.
		 * 
		 * @params event passing complete state
		 * @return void
		 */
		public function completeHandler(event:Event):void
		{
			received = new URLVariables(loader.data);
			dispatchEvent(new Event(ServerManager.READY));
		}

		/**
		 * Handler when communication work in progress.
		 * 
		 * @params event passing progress state
		 * @return void
		 */
		public function progressHandler(event:ProgressEvent):void
		{
			progress = Math.ceil(Math.floor(event.bytesLoaded / 1024) / Math.floor(event.bytesTotal / 1024) * 100);
			dispatchEvent(new Event(ServerManager.PROGRESS));
		}

		/**
		 * Handler when error occured.
		 * 
		 * @params event passing IO Error event
		 * @return void
		 */
		public function errorHandler(event:IOErrorEvent):void
		{
			error = event.toString();
			dispatchEvent(new Event(ServerManager.ERROR));
		}
	}
}
