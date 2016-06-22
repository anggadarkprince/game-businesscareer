package sketchproject.objects.product.inventory
{
	import flash.events.Event;

	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.managers.ServerManager;
	import sketchproject.objects.dialog.NativeDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.utilities.ValueFormatter;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Inventory asset summaries and depreciation.
	 * 
	 * @author Angga
	 */
	public class InventoryAssets extends Sprite
	{
		private var title:TextField;

		private var bar:Quad;
		private var buttonRepair:Quad;
		private var label:TextField;
		private var depreciationText:TextField;
		private var upgrade:Image;
		private var dialogConfirm:NativeDialog;

		private var depreciation:int;
		private var server:ServerManager;
		private var dialogInfo:NativeDialog;

		/**
		 * Default constructor of InventoryAssets.
		 */
		public function InventoryAssets()
		{
			super();

			title = new TextField(200, 50, "Shop Assets", Assets.getFont(Assets.FONT_CORegular).fontName, 22, 0xFFFFFF);
			title.hAlign = HAlign.LEFT;
			addChild(title);

			label = new TextField(200, 50, "Assets List", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.x = 30;
			label.y = 45;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			bar = new Quad(385, 60, 0x212121);
			bar.x = 30;
			bar.y = 90;
			addChild(bar);

			for (var i:int = 0; i < Data.asset.length; i++)
			{
				upgrade = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Data.asset[i][3]));
				upgrade.pivotX = upgrade.width * 0.5;
				upgrade.pivotY = upgrade.height * 0.5;
				upgrade.x = i * 60 + 75;
				upgrade.y = 120;
				upgrade.scaleX = 0.3;
				upgrade.scaleY = 0.3;
				addChild(upgrade);
			}

			label = new TextField(200, 50, "Depresiasi", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.x = 30;
			label.y = 150;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			label = new TextField(300, 50, "Penurunan nilai asset", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0xFFFFFF);
			label.x = 30;
			label.y = 170;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			label = new TextField(150, 50, "Depreciation Expense", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.x = 30;
			label.y = 220;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			label = new TextField(300, 50, "Cost Fixed Asset  -  Residual Value", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.x = 150;
			label.y = 200;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			bar = new Quad(265, 3, 0xFFFFFF);
			bar.x = 150;
			bar.y = 241;
			addChild(bar);

			label = new TextField(200, 50, "Nilai ekonomis Asset", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.x = 210;
			label.y = 235;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			label = new TextField(150, 50, "Akumulasi", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.x = 30;
			label.y = 270;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			depreciationText = new TextField(150, 50, "IDR 30400", Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0xFFFFFF);
			depreciationText.x = 30;
			depreciationText.y = 290;
			depreciationText.hAlign = HAlign.LEFT;
			addChild(depreciationText);

			buttonRepair = new Quad(240, 35, 0xfb7477);
			buttonRepair.x = 165;
			buttonRepair.y = 290;
			addChild(buttonRepair);

			bar = new Quad(240, 5, 0xff4a4e);
			bar.x = 165;
			bar.y = 320;
			addChild(bar);

			label = new TextField(230, 30, "ASSETS REPARATION", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0xFFFFFF);
			label.pivotX = label.width * 0.5;
			label.hAlign = HAlign.CENTER;
			label.x = 170 + bar.width * 0.5;
			label.y = 290;
			addChild(label);

			buttonRepair = new Quad(270, 35, 0xfb7477);
			buttonRepair.x = 150;
			buttonRepair.y = 290;
			buttonRepair.alpha = 0;
			addChild(buttonRepair);

			dialogConfirm = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Repair", "Do you want to repair asset?");
			dialogConfirm.x = Starling.current.stage.stageWidth * 0.5;
			dialogConfirm.y = Starling.current.stage.stageHeight * 0.5;
			dialogConfirm.addEventListener(DialogBoxEvent.CLOSED, onRepairConfirmed);
			Game.overlayStage.addChild(dialogConfirm);

			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION, "Information", "You don't have cash enough");
			dialogInfo.x = Starling.current.stage.stageWidth * 0.5;
			dialogInfo.y = Starling.current.stage.stageHeight * 0.5;
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void
			{
				dialogInfo.closeDialog();
			});
			Game.overlayStage.addChild(dialogInfo);

			buttonRepair.addEventListener(TouchEvent.TOUCH, onRepairTouched);

			update();
		}

		/**
		 * Repairing assets.
		 * 
		 * @param touch
		 */
		private function onRepairTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonRepair, TouchPhase.ENDED))
			{
				if (depreciation <= 0)
				{
					dialogInfo.dialogMessage = "Perbaikan tidak dibutuhkan";
					Game.overlayStage.swapChildren(dialogInfo, Game.overlayStage.getChildAt(Game.overlayStage.numChildren - 1));
					dialogInfo.openDialog();
				}
				else if (Data.cash - depreciation < 0)
				{
					dialogInfo.dialogMessage = "Kamu tidak punya cukup uang";
					Game.overlayStage.swapChildren(dialogInfo, Game.overlayStage.getChildAt(Game.overlayStage.numChildren - 1));
					dialogInfo.openDialog();
				}
				else
				{
					Game.overlayStage.swapChildren(dialogConfirm, Game.overlayStage.getChildAt(Game.overlayStage.numChildren - 1));
					dialogConfirm.openDialog();
				}
			}
		}

		/**
		 * Repair material confirmed.
		 * 
		 * @param event
		 */
		private function onRepairConfirmed(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				var dialog:PostDialog = new PostDialog("Repair", depreciation, false);
				dialog.x = stage.stageWidth * 0.5;
				dialog.y = stage.stageHeight * 0.5;
				dialog.addEventListener(PostDialog.POSTING, function(event:starling.events.Event):void
				{
					Game.loadingScreen.show();

					var gameObject:Object = new Object();
					gameObject.token = Data.key;

					server = new ServerManager("inventory/repair_asset", gameObject);
					server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void
					{
						Game.loadingScreen.hide();
					});
					server.sendRequest();
				});
				Game.overlayStage.addChild(dialog);
				dialog.openDialog();
			}
			dialogConfirm.closeDialog();
		}

		/**
		 * Update nilai depresiasi.
		 */
		public function update():void
		{
			depreciation = 0;
			for (var i:uint = 0; i < Data.asset.length; i++)
			{
				depreciation += int(Data.asset[i].pas_depreciation);
			}
			depreciationText.text = "IDR " + ValueFormatter.format(depreciation, true);
		}
	}
}
