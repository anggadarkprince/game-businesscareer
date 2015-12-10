package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class StatsTrendDialog extends DialogOverlay
	{
		private var background:Image;
		private var trend:TextField;
		private var event:TextField;
		private var buttonClose:Button;
		
		public function StatsTrendDialog(destroyable:Boolean = false)
		{
			super(destroyable);
			
			background = new Image(Assets.getAtlas(Assets.ADDITIONAL, Assets.ADDITIONAL_XML).getTexture("trend_panel"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			trend = new TextField(490, 150, Data.shoppingStreet, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			trend.hAlign = HAlign.LEFT;
			trend.vAlign = VAlign.TOP;
			trend.x = -235.4;
			trend.y = -100;
			addChild(trend);
			
			event = new TextField(490, 200, "No Event", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			event.hAlign = HAlign.LEFT;
			event.vAlign = VAlign.TOP;
			event.x = -235.4;
			event.y = -10;
			addChild(event);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_close")); 
			buttonClose.x = 113.45;
			buttonClose.y = 157.4;
			addChild(buttonClose);
			
			buttonClose.addEventListener(Event.TRIGGERED, function(event:Event):void{
				closeDialog();
			});
			
			update();
		}
		
		public function update():void
		{
			event.text = "";
			for(var i:int = 0; i<Data.event.length; i++){
				event.text += (i+1)+". "+Data.event[i][0]+"\n";
			}
			
			trend.text = Data.shoppingStreet;
		}
	}
}