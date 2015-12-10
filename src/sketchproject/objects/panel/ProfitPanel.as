package sketchproject.objects.panel
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.DataManager;
	import sketchproject.objects.dialog.NativeDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class ProfitPanel extends Panel
	{
		private var container:Sprite;
		private var label:TextField;
		private var totalInstalment:TextField;
		private var dialogConfirm:NativeDialog;
		private var dialogInfo:NativeDialog;
		private var buttonPay:Button;
		private var strip:Quad;
		private var server:DataManager;
		
		
		public function ProfitPanel()
		{
			super(
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_coin"),
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("title_profit"),
				"Earn income by analysis revenue and loss"
			);
			
			server = new DataManager();
			
			container = new Sprite();
			container.x = -350;
			container.y = -160;
			addChild(container);
			
			label = new TextField(300, 40, "Total Instalment", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.x = -350;
			label.y = 170;
			addChild(label);
			
			totalInstalment = new TextField(300, 40, ValueFormatter.numberFormat(Data.instalment,"IDR"), Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			totalInstalment.hAlign = HAlign.LEFT;
			totalInstalment.x = -350;
			totalInstalment.y = 190;
			addChild(totalInstalment);
			
			label = new TextField(300, 40, "Total Instalment", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0x333333);
			label.hAlign = HAlign.RIGHT;
			label.x = 50;
			label.y = 170;
			addChild(label);
			
			label = new TextField(300, 40, "IDR 8.000.000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.hAlign = HAlign.RIGHT;
			label.x = 50;
			label.y = 190;
			addChild(label);
			
			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION,"Instalment","You Don't have enough money");
			dialogInfo.x = Starling.current.stage.stageWidth * 0.5;
			dialogInfo.y = Starling.current.stage.stageHeight * 0.5;
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void{dialogInfo.closeDialog()});
			Game.overlayStage.addChild(dialogInfo);
			
			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION);
			dialogConfirm.x = Starling.current.stage.stageWidth * 0.5;
			dialogConfirm.y = Starling.current.stage.stageHeight * 0.5;
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, payLoan);
			Game.overlayStage.addChild(dialogConfirm);
			
			update();			
		}
		
		public function payLoan(event:DialogBoxEvent):void
		{
			if(event.result)
			{
				var dialog:PostDialog = new PostDialog("Instalment",1000000,false);
				dialog.x = stage.stageWidth * 0.5;
				dialog.y = stage.stageHeight * 0.5;
				Game.overlayStage.addChild(dialog);
				
				dialog.openDialog();
				dialog.addEventListener(PostDialog.POSTING, function(event:Event):void{
					Data.instalment+=1000000;
					update();				
					server.saveGameData();
				});
			}
			dialogConfirm.closeDialog();
		}
		
		public function update():void
		{
			container.removeChildren();
			
			for(var i:uint = 0; i<8; i++)
			{
				if(i%2==0)
				{
					strip = new Quad(580,40);
					strip.alpha = 0.7;	
					strip.color = 0xFFFFFF;
					strip.y = i*40;
					container.addChild(strip);
				}
				label = new TextField(300, 40, "Month "+(i+1), Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
				label.hAlign = HAlign.LEFT;
				label.x = 30;
				label.y = i*40;
				container.addChild(label);
				
				label = new TextField(370, 40, "Instalment IDR 1000.0000 / IDR "+ValueFormatter.numberFormat((i+1)*1000000), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x333333);
				label.hAlign = HAlign.LEFT;
				label.x = 140;
				label.y = i*40;
				container.addChild(label);
								
				if(i*1000000 <= Data.instalment)
				{
					buttonPay = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_pay"));
					buttonPay.pivotX = buttonPay.width * 0.5;
					buttonPay.pivotY = buttonPay.height * 0.5;
					buttonPay.x = 650;
					buttonPay.y = i*40 + 20;
					buttonPay.name = "Month " + (i+1);
					buttonPay.addEventListener(Event.TRIGGERED, onPayed);
					if(i*1000000 < Data.instalment)
					{
						buttonPay.enabled = false;	
					}
				}				
				
				container.addChild(buttonPay);
			}
			
			totalInstalment.text = ValueFormatter.numberFormat(Data.instalment,"IDR");
		}
		
		public function onPayed(event:Event):void
		{
			if((Data.cash - 1000000) < 0)
			{
				dialogInfo.openDialog();
			}
			else
			{
				dialogConfirm.dialogTitle = "Pay Confirm";
				dialogConfirm.dialogMessage = "Pay Instalment "+Button(event.currentTarget).name+"?";
				dialogConfirm.openDialog();
			}	
		}
	}
}