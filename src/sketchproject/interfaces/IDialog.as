package sketchproject.interfaces
{
	import starling.events.Event;

	public interface IDialog
	{		
		function openDialog():void;
		function closeDialog():void;
		function onPrimaryTrigerred(event:Event):void;
	}
}