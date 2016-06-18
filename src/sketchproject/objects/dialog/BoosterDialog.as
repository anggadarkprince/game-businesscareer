package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.RewardManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	 * Show dialog booster and upgrade booster level.
	 *
	 * @author Angga
	 */
	public class BoosterDialog extends Sprite implements IDialog
	{
		private var overlay:Quad;
		private var dialogBase:Image;
		private var labelImage:Image;
		private var dialogTitle:TextField;
		private var buttonPrimary:Button;

		private var dialogTraining:NativeDialog;
		private var dialogShop:NativeDialog;
		private var dialogProduct:NativeDialog;
		private var dialogLucky:NativeDialog;
		private var dialogInfo:NativeDialog;

		private var containerTraining:Sprite;
		private var containerProduct:Sprite;
		private var containerShop:Sprite;
		private var containerLucky:Sprite;

		private var buttonIncreaseTraining:Button;
		private var buttonIncreaseProduct:Button;
		private var buttonIncreaseShop:Button;
		private var buttonIncreaseLucky:Button;

		private var totalCost:int;
		private var gemManager:RewardManager;
		private var fireworkManager:FireworkManager;

		private var dialogPost:PostDialog;

		/**
		 * Default constructor of BoosterDialog
		 */
		public function BoosterDialog()
		{
			super();
			initObjectProperty();
		}

		/**
		 * Initialize booster components.
		 */
		public function initObjectProperty():void
		{
			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			gemManager = new RewardManager(RewardManager.REWARD_GEM, RewardManager.SPAWN_HIGH);
			
			totalCost = 0;

			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5, Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			dialogBase = new Image(Assets.getAtlas(Assets.PANEL, Assets.PANEL_XML).getTexture("dialog_booster"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);

			dialogTitle = new TextField(350, 50, "Performance Booster", Assets.getFont("FontCarterOne").fontName, 24, 0xc0251e);
			dialogTitle.pivotX = dialogTitle.width * 0.5;
			dialogTitle.pivotY = dialogTitle.height * 0.5;
			dialogTitle.y = -200;
			addChild(dialogTitle);

			labelImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_menu"));
			labelImage.pivotX = labelImage.width * 0.5;
			labelImage.pivotY = labelImage.height * 0.5;
			addChild(labelImage);

			containerTraining = new Sprite();
			containerTraining.x = -20;
			containerTraining.y = -117;
			addChild(containerTraining);

			containerShop = new Sprite();
			containerShop.x = -20;
			containerShop.y = -30;
			addChild(containerShop);

			containerProduct = new Sprite();
			containerProduct.x = -20;
			containerProduct.y = 59;
			addChild(containerProduct);

			containerLucky = new Sprite();
			containerLucky.x = -20;
			containerLucky.y = 148;
			addChild(containerLucky);

			buttonIncreaseTraining = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_500k"));
			buttonIncreaseTraining.pivotX = buttonIncreaseTraining.width * 0.5;
			buttonIncreaseTraining.pivotY = buttonIncreaseTraining.height * 0.5;
			buttonIncreaseTraining.x = 125;
			buttonIncreaseTraining.y = -150;
			addChild(buttonIncreaseTraining);

			buttonIncreaseShop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_500k"));
			buttonIncreaseShop.pivotX = buttonIncreaseTraining.width * 0.5;
			buttonIncreaseShop.pivotY = buttonIncreaseTraining.height * 0.5;
			buttonIncreaseShop.x = 125;
			buttonIncreaseShop.y = -60;
			addChild(buttonIncreaseShop);

			buttonIncreaseProduct = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_500k"));
			buttonIncreaseProduct.pivotX = buttonIncreaseProduct.width * 0.5;
			buttonIncreaseProduct.pivotY = buttonIncreaseProduct.height * 0.5;
			buttonIncreaseProduct.x = 130;
			buttonIncreaseProduct.y = 30;
			addChild(buttonIncreaseProduct);

			buttonIncreaseLucky = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_500k"));
			buttonIncreaseLucky.pivotX = buttonIncreaseLucky.width * 0.5;
			buttonIncreaseLucky.pivotY = buttonIncreaseLucky.height * 0.5;
			buttonIncreaseLucky.x = 130;
			buttonIncreaseLucky.y = 120;
			addChild(buttonIncreaseLucky);

			buttonPrimary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_confirm_outline"));
			buttonPrimary.pivotX = buttonPrimary.width * 0.5;
			buttonPrimary.pivotY = buttonPrimary.height * 0.5;
			buttonPrimary.x = 0;
			buttonPrimary.y = 215;
			buttonPrimary.scaleX = 0.9;
			buttonPrimary.scaleY = 0.9;
			addChild(buttonPrimary);

			buttonIncreaseTraining.addEventListener(Event.TRIGGERED, onIncreaseTraining);
			buttonIncreaseShop.addEventListener(Event.TRIGGERED, onIncreaseShop);
			buttonIncreaseProduct.addEventListener(Event.TRIGGERED, onIncreaseProduct);
			buttonIncreaseLucky.addEventListener(Event.TRIGGERED, onIncreaseLucky);
			buttonPrimary.addEventListener(Event.TRIGGERED, onPrimaryTrigerred);

			dialogLucky = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Booster", "Beli Lucky Booster IDR 500 K?");
			dialogLucky.addEventListener(DialogBoxEvent.CLOSED, onLuckyDialogClosed);
			addChild(dialogLucky);

			dialogProduct = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Booster", "Beli Product Booster IDR 500 K?");
			dialogProduct.addEventListener(DialogBoxEvent.CLOSED, onProductDialogClosed);
			addChild(dialogProduct);

			dialogShop = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Booster", "Beli Shop Booster IDR 500 K?");
			dialogShop.addEventListener(DialogBoxEvent.CLOSED, onShopDialogClosed);
			addChild(dialogShop);

			dialogTraining = new NativeDialog(NativeDialog.DIALOG_QUESTION, "Booster", "Beli Training Booster IDR 500 K?");
			dialogTraining.addEventListener(DialogBoxEvent.CLOSED, onTrainingDialogClosed);
			addChild(dialogTraining);

			dialogInfo = new NativeDialog(NativeDialog.DIALOG_INFORMATION, "Information", "Kamu tidak punya cukup uang!");
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void {
				dialogInfo.closeDialog();
			});
			addChild(dialogInfo);

			dialogPost = new PostDialog("Booster", totalCost, false);
			dialogPost.x = Starling.current.stage.stageWidth * 0.5;
			dialogPost.y = Starling.current.stage.stageHeight * 0.5;
			dialogPost.isDestroyable = false;
			dialogPost.isTask = false;
			dialogPost.addEventListener(PostDialog.POSTING, function(event:starling.events.Event):void {
				Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				closeDialog();
			});
			Game.overlayStage.addChild(dialogPost);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;

			setup();
		}

		/**
		 * Upgrade lucky booster and check player's cash.
		 * 
		 * @param event
		 */
		private function onIncreaseLucky(event:Event):void
		{
			if (Data.cash < (totalCost + 500000))
			{
				dialogInfo.openDialog();
			}
			else
			{
				dialogLucky.openDialog();
			}
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}

		/**
		 * Confirm upgrade lucky booster.
		 * 
		 * @param event
		 */
		private function onLuckyDialogClosed(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				// primary action	
				Data.booster[3]++;
				totalCost += 500000;
				setup();
				dialogLucky.closeDialog();
				Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);

				gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400, 40, 500);
			}
			else
			{
				// secondary action	
				dialogLucky.closeDialog();
			}
		}

		/**
		 * Upgrade product booster and check player's cash.
		 * 
		 * @param event
		 */
		private function onIncreaseProduct(event:Event):void
		{
			if (Data.cash < (totalCost + 500000))
			{
				dialogInfo.openDialog();
			}
			else
			{
				dialogProduct.openDialog();
			}
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}

		/**
		 * Confirm upgrade product booster.
		 * 
		 * @param event
		 */
		private function onProductDialogClosed(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				// primary action	
				Data.booster[2]++;
				totalCost += 500000;
				setup();
				dialogProduct.closeDialog();
				Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);

				gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400, 40, 500);
			}
			else
			{
				// secondary action	
				dialogProduct.closeDialog();
			}
		}

		/**
		 * Upgrade shop booster and check player's shop.
		 * 
		 * @param event
		 */
		private function onIncreaseShop(event:Event):void
		{
			if (Data.cash < (totalCost + 500000))
			{
				dialogInfo.openDialog();
			}
			else
			{
				dialogShop.openDialog();
			}
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}

		/**
		 * Confirm upgrade shop booster.
		 * 
		 * @param event
		 */
		private function onShopDialogClosed(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				// primary action	
				Data.booster[1]++;
				totalCost += 500000;
				setup();
				dialogShop.closeDialog();
				Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);

				gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400, 40, 500);
			}
			else
			{
				// secondary action	
				dialogShop.closeDialog();
			}
		}

		/**
		 * Upgrade training booster and check player's cash.
		 * 
		 * @param event
		 */
		private function onIncreaseTraining(event:Event):void
		{
			if (Data.cash < (totalCost + 500000))
			{
				dialogInfo.openDialog();
			}
			else
			{
				dialogTraining.openDialog();
			}
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
		}

		/**
		 * Confirm upgrade training booster.
		 * 
		 * @param event
		 */
		private function onTrainingDialogClosed(event:DialogBoxEvent):void
		{
			if (event.result)
			{
				// primary action
				Data.booster[0]++;
				totalCost += 500000;
				setup();
				dialogTraining.closeDialog();
				Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);

				gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400, 40, 500);
			}
			else
			{
				// secondary action	
				dialogTraining.closeDialog();
			}
		}

		/**
		 * Update bosster bar after upgrade and init the dialog.
		 */
		public function setup():void
		{
			var bar:Image;

			containerTraining.removeChildren();
			for (var i:uint = 0; i < Data.booster[0]; i++)
			{
				if (i == 0)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_blue_side"));
				}
				else if (i == 4)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_blue_side"));
					bar.scaleX = -1;
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_blue_middle"));
				}
				bar.pivotX = bar.width * 0.5;
				bar.pivotY = bar.height * 0.5;
				bar.x = i * (bar.width + 3);
				containerTraining.addChild(bar);
			}

			containerShop.removeChildren();
			for (var j:uint = 0; j < Data.booster[1]; j++)
			{
				if (j == 0)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_orange_side"));
				}
				else if (j == 4)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_orange_side"));
					bar.scaleX = -1;
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_orange_middle"));
				}
				bar.pivotX = bar.width * 0.5;
				bar.pivotY = bar.height * 0.5;
				bar.x = j * (bar.width + 3);
				containerShop.addChild(bar);
			}

			containerProduct.removeChildren();
			for (var k:uint = 0; k < Data.booster[2]; k++)
			{
				if (k == 0)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_red_side"));
				}
				else if (k == 4)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_red_side"));
					bar.scaleX = -1;
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_red_middle"));
				}
				bar.pivotX = bar.width * 0.5;
				bar.pivotY = bar.height * 0.5;
				bar.x = k * (bar.width + 3);
				containerProduct.addChild(bar);
			}

			containerLucky.removeChildren();
			for (var l:uint = 0; l < Data.booster[3]; l++)
			{
				if (l == 0)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_green_side"));
				}
				else if (l == 4)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_green_side"));
					bar.scaleX = -1;
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("booster_green_middle"));
				}
				bar.pivotX = bar.width * 0.5;
				bar.pivotY = bar.height * 0.5;
				bar.x = l * (bar.width + 3);
				containerLucky.addChild(bar);
			}


			if (Data.booster[0] == 5)
			{
				buttonIncreaseTraining.visible = false;
			}
			if (Data.booster[1] == 5)
			{
				buttonIncreaseShop.visible = false;
			}
			if (Data.booster[2] == 5)
			{
				buttonIncreaseProduct.visible = false;
			}
			if (Data.booster[3] == 5)
			{
				buttonIncreaseLucky.visible = false;
			}
		}

		/**
		 * Open / show booster dialog.
		 */
		public function openDialog():void
		{
			totalCost = 0;
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 0.9, 
					scaleY: 0.9, 
					alpha: 1, 
					delay: 0.2
				}
			);
		}

		/**
		 * Close / hide booster dialog.
		 */
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			TweenMax.to(
				this, 
				0.5, 
				{
					ease: Back.easeIn, 
					scaleX: 0.5, 
					scaleY: 0.5, 
					alpha: 0, 
					delay: 0.2, 
					onComplete: function():void {
						visible = false;
					}
				}
			);
		}

		/**
		 * Close booster dialog, check if player upgraded the booster,
		 * if yes open dialog post and check posting.
		 * 
		 * @param event
		 */
		public function onPrimaryTrigerred(event:Event):void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			closeDialog();

			if (totalCost > 0)
			{
				dialogPost.transactionType = "Booster";
				dialogPost.transactionValue = totalCost;
				dialogPost.preparePosting();
				dialogPost.openDialog();
			}
		}
	}
}
