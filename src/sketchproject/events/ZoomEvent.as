package sketchproject.events
{
	import starling.events.Event;

	/**
	 * Zooming event dispatcher.
	 *
	 * @author Angga
	 */
	public class ZoomEvent extends Event
	{
		/**
		 * Dispatch zoom in event.
		 * @default
		 */
		public static const ZOOM_IN:String = "zoomin";

		/**
		 * Dispatch zoom out event.
		 * @default
		 */
		public static const ZOOM_OUT:String = "zoomout";

		/**
		 * Default constructor of ZoomEvent.
		 *
		 * @param type of event
		 * @param bubbles is the event bubbling up
		 * @param data that passed through event
		 */
		public function ZoomEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
