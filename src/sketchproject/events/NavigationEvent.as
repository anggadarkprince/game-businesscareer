package sketchproject.events
{
	import starling.events.Event;

	/**
	 * Navigation game menu event dispatcher.
	 *
	 * @author Angga
	 */
	public class NavigationEvent extends Event
	{
		public static const SWITCH:String = "switch";

		public static const NAVIGATE_CUSTOMER:String = "customer";
		public static const NAVIGATE_POINT:String = "point";
		public static const NAVIGATE_STAR:String = "star";
		public static const NAVIGATE_PROFIT:String = "profit";

		public static const NAVIGATE_HELP:String = "help";
		public static const NAVIGATE_SETTING:String = "setting";
		public static const NAVIGATE_AVATAR:String = "info";
		public static const NAVIGATE_ACHIEVEMENT:String = "achievement";
		public static const NAVIGATE_LEADERBOARD:String = "leaderboard";
		public static const NAVIGATE_BOOSTER:String = "performance";
		public static const NAVIGATE_PAUSE:String = "menu";

		public static const NAVIGATE_MARKET:String = "market";

		public static const NAVIGATE_MAP:String = "map";
		public static const NAVIGATE_BUSINESS:String = "business";
		public static const NAVIGATE_PRODUCT:String = "product";
		public static const NAVIGATE_EMPLOYEE:String = "employee";
		public static const NAVIGATE_ISSUES:String = "issues";
		public static const NAVIGATE_ADVERTISING:String = "advert";
		public static const NAVIGATE_FINANCE:String = "finance";

		private var mResult:String;

		/**
		 * Default constructor of NavigationEvent.
		 *
		 * @param type of event which dispatched
		 * @param data that passed through event (custom)
		 * @param bubbles is the event bubbling up
		 */
		public function NavigationEvent(type:String, data:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
			this.mResult = data;
		}

		/**
		 * Get data that passed from dispatcher component.
		 *
		 * @return boolean
		 */
		public function get navigate():String
		{
			return mResult;
		}
	}
}
