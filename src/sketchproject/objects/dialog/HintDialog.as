package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.events.DialogBoxEvent;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	public class HintDialog extends DialogOverlay
	{		
		private var titleText:TextField;
		private var hintText:TextField;		
		private var buttonOk:Button;
						
		public function HintDialog(type:String = "transaction", hint:String = "No Hint")
		{
			super(false);
						
			overlay = new Quad(570,360);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			addChild(overlay);
			
			overlay = new Quad(570,2,0x666666);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.y = -126;
			addChild(overlay);
			
			overlay = new Quad(570,2,0x666666);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.y = 108;
			addChild(overlay);
			
			
			titleText = new TextField(170, 50, type, Assets.getFont(Assets.FONT_SSBOLD).fontName, 26, 0x454545);
			titleText.pivotX = titleText.width * 0.5;
			titleText.vAlign = VAlign.TOP;
			titleText.y = -170;
			addChild(titleText);
			
			
			hintText = new TextField(450, 250, type, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0x454545);
			hintText.pivotX = hintText.width * 0.5;
			hintText.y = -130;
			addChild(hintText);
			
			buttonOk = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok"));
			buttonOk.pivotX = buttonOk.width * 0.5;
			buttonOk.pivotY = buttonOk.height * 0.5;
			buttonOk.y = 140;
			buttonOk.addEventListener(Event.TRIGGERED, onDialogClosed);
			addChild(buttonOk);
			
		}
		
		private function onDialogClosed(event:Event):void
		{
			closeDialog();
			dispatchEvent(new DialogBoxEvent(DialogBoxEvent.CLOSED, true));
		}
		
		public function set title(titleHint:String):void
		{
			this.titleText.text = titleHint;
		}
		
		public function get title():String
		{
			return titleText.text;
		}
		
		public function set hint(transactionHint:String):void
		{
			hintText.text = transactionHint;
		}
		
		public function get hint():String
		{
			return hintText.text;
		}
				
		
		
	}
}