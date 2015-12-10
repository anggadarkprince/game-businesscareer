package sketchproject.events
{
	import starling.events.Event;
	
	public class DialogBoxEvent extends Event
	{
		public static const CLOSED:String = "closed";
		
		private var mResult:Boolean;
		
		public function DialogBoxEvent(type:String, data:Boolean, bubbles:Boolean=false)
		{
			super(type, bubbles);
			this.mResult = data;
		}
		
		public function get result():Boolean 
		{ 
			return mResult; 
		}
	}
}