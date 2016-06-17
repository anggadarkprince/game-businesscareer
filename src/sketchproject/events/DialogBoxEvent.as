package sketchproject.events
{
	import starling.events.Event;

	/**
	 * Close dialog event dispatcher.
	 *
	 * @author Angga
	 */
	public class DialogBoxEvent extends Event
	{
		public static const CLOSED:String = "closed";

		private var mResult:Boolean;

		/**
		 * Default constructor of DialogBoxEvent.
		 *
		 * @param type of event reference to CLOSED string
		 * @param data that passed through event (custom)
		 * @param bubbles is the event bubbling up
		 */
		public function DialogBoxEvent(type:String, data:Boolean, bubbles:Boolean = false)
		{
			super(type, bubbles);
			this.mResult = data;
		}

		/**
		 * Get data that passed from dispatcher component.
		 *
		 * @return boolean
		 */
		public function get result():Boolean
		{
			return mResult;
		}
	}
}
