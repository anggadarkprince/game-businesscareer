package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.CelebrateManager;
	import sketchproject.managers.FireworkManager;
	import sketchproject.utilities.TableGenerator;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Show daily report summary.
	 * 
	 * @author Angga
	 */
	public class DailyReportDialog extends Sprite
	{
		public static const REQUEST_POST:String = "requestPost";

		private var overlay:Quad;
		private var dialogBase:Image;

		private var buttonPost:Button;

		private var fireworkManager:FireworkManager;

		private var label:TextField;
		private var revenue:TextField;
		private var expense:TextField;
		private var gross:TextField;

		private var celebrateManager:CelebrateManager;
		private var celebrateContainer:Sprite;

		private var data:Array = [["Food A", "15 Item", "X", "IDR 14000", "IDR 21000"], ["Food B", "15 Item", "X", "IDR 14000", "IDR 21000"], ["Food C", "15 Item", "X", "IDR 14000", "IDR 21000"], ["Drink A", "15 Item", "X", "IDR 14000", "IDR 21000"], ["Drink B", "15 Item", "X", "IDR 14000", "IDR 21000"]];
		private var dataWidth:Array = [100, 70, 30, 90, 90];

		private var header:Array = ["Product Sold", "Total"];
		private var align:Array = [HAlign.LEFT, HAlign.RIGHT, HAlign.CENTER, HAlign.RIGHT, HAlign.RIGHT];
		private var headerWidth:Array = [280, 100];

		private var tableContainer:Sprite;
		private var fireworksTimer:Timer;

		/**
		 * Default constructor of DailyReportDialog.
		 */
		public function DailyReportDialog()
		{
			super();
			
			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			overlay = new Quad(Starling.current.stage.stageWidth * 2.5, Starling.current.stage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			celebrateContainer = new Sprite();
			celebrateContainer.x = -Starling.current.nativeStage.stageWidth * 0.5;
			celebrateContainer.y = -Starling.current.nativeStage.stageHeight * 0.5;
			addChild(celebrateContainer);

			celebrateManager = new CelebrateManager(celebrateContainer);

			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("notebook"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);

			label = new TextField(250, 40, "Business Summaries", Assets.getFont(Assets.FONT_SSBOLD).fontName, 20, 0xFFFFFF);
			label.x = -190;
			label.y = -115;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			tableContainer = new Sprite();
			tableContainer.x = -190;
			tableContainer.y = -80;
			addChild(tableContainer);

			overlay = new Quad(400, 2, 0xFFFFFF);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.y = 55;
			addChild(overlay);

			label = new TextField(100, 30, "Revenue", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0xFFFFFF);
			label.x = -35;
			label.y = 60;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			revenue = new TextField(120, 30, "IDR 1200000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0xFFFFFF);
			revenue.x = 55;
			revenue.y = 60;
			revenue.vAlign = VAlign.TOP;
			revenue.hAlign = HAlign.RIGHT;
			addChild(revenue);

			label = new TextField(100, 30, "Expense", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0xFFFFFF);
			label.x = -35;
			label.y = 80;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			expense = new TextField(120, 30, "IDR 1200000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0xFFFFFF);
			expense.x = 55;
			expense.y = 80;
			expense.vAlign = VAlign.TOP;
			expense.hAlign = HAlign.RIGHT;
			addChild(expense);

			label = new TextField(100, 30, "Gross Profit", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0xFFFFFF);
			label.x = -35;
			label.y = 100;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			gross = new TextField(120, 30, "IDR 1200000", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0xFFFFFF);
			gross.x = 55;
			gross.y = 100;
			gross.vAlign = VAlign.TOP;
			gross.hAlign = HAlign.RIGHT;
			addChild(gross);

			buttonPost = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_posting"));
			buttonPost.pivotX = buttonPost.width * 0.5;
			buttonPost.pivotY = buttonPost.height * 0.5;
			buttonPost.x = -130;
			buttonPost.y = 100;
			addChild(buttonPost);

			fireworksTimer = new Timer(1500);
			fireworksTimer.addEventListener(TimerEvent.TIMER, onFireworksTriggered);

			buttonPost.addEventListener(Event.TRIGGERED, onPostingRequested);

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}		

		/**
		 * Request posting dialog.
		 * 
		 * @param event
		 */
		private function onPostingRequested(event:Event):void
		{
			dispatchEventWith(REQUEST_POST);
		}

		/**
		 * Spawed fireworks random.
		 * 
		 * @param event
		 */
		private function onFireworksTriggered(event:TimerEvent):void
		{
			Assets.sfxChannel = Assets.sfxFireworks.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Math.random() * Starling.current.stage.stageWidth, Math.random() * Starling.current.stage.stageHeight);
		}
		
		/**
		 * Set daily report value and generate table.
		 * 
		 * @param revenue
		 * @param expenses
		 * @param profit
		 * @param sold
		 */
		public function generateDailyReport(revenue:int, expenses:int, profit:int, sold:Array):void
		{
			this.revenue.text = ValueFormatter.format(revenue, true, "IDR");
			this.expense.text = ValueFormatter.format(expenses, true, "IDR");
			this.gross.text = ValueFormatter.format(profit, true, "IDR");
			
			data = new Array();
			for (var i:int = 0; i < Data.product.length; i++)
			{
				data.push(new Array(
					Data.product[i].prd_product, 
					sold[i]+" Items", 
					"X", 
					ValueFormatter.numberFormat(Data.product[i].prd_price, "IDR"),
					ValueFormatter.numberFormat(sold[i] * Data.product[i].prd_price, "IDR")
				));
			}
			
			TableGenerator.headerColor = 0xfe7877;
			TableGenerator.oddColor = 0x4a5163;
			TableGenerator.evenColor = 0x6c7481;
			TableGenerator.headerFontColor = 0xFFFFFF;
			TableGenerator.dataFontColor = 0xFFFFFF;

			TableGenerator.createTable2(tableContainer, header, headerWidth, data, dataWidth, align);
		}

		/**
		 * Open / show daily report dialog.
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			fireworksTimer.start();
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					delay: 1
				}
			);
		}

		/**
		 * Close / hide daily report dialog.
		 */
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0, 0, Assets.sfxTransform);
			fireworksTimer.stop();
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
						destroy();
					}
				}
			);
		}

		/**
		 * Update current state.
		 * 
		 * @return void
		 */
		public function update():void
		{
			celebrateManager.update();
		}

		/**
		 * Release resources and destroy manager.
		 * 
		 * @return void
		 */
		public function destroy():void
		{
			removeFromParent(true);
		}
	}
}
