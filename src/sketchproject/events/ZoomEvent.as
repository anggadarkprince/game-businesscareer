package sketchproject.events
{
	import starling.events.Event;
	
	public class ZoomEvent extends Event
	{
		public static const ZOOM_IN:String = "zoomin";
		public static const ZOOM_OUT:String = "zoomout";
		
		public function ZoomEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}