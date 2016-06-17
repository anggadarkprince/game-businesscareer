package sketchproject.interfaces
{
	import starling.events.Event;

	/**
	 * Dialog contract and trait.
	 * 
	 * @author Angga
	 */
	public interface IDialog
	{		
		function openDialog():void;
		function closeDialog():void;
		function onPrimaryTrigerred(event:Event):void;
	}
}