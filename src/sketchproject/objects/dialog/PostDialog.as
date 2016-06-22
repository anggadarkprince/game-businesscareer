package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.Event;
	
	import feathers.controls.PickerList;
	import feathers.data.ListCollection;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.RewardManager;
	import sketchproject.managers.ServerManager;
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
	 * Posting financial transaction into journal.
	 * 
	 * @author Angga
	 */
	public class PostDialog extends Sprite implements IDialog
	{
		public static const POSTING:String = "postingdone";
		public static const HINT:String = "hint";

		private var overlay:Quad;
		private var dialogBase:Image;
		private var advisorAvatar:Image;
		private var ballon:Image;
		private var label:TextField;
		private var question:TextField;

		private var buttonHint:Button;
		private var buttonPost:Button;

		private var type:String;
		private var hint:String;
		private var keyDebit:String;
		private var keyCredit:String;
		private var value:int;
		private var transaction:String;
		private var journalDescription:String;
		
		public var isTask:Boolean;
		public var isDestroyable:Boolean;

		private var fireworkManager:FireworkManager;

		private var listDebit:PickerList;
		private var listCredit:PickerList;
		private var server:ServerManager;
		private var coinManager:RewardManager;
		private var gemManager:RewardManager;

		private var dialogInfo:NativeDialog;
		private var hintDialog:HintDialog;

		/**
		 * Default constructor of PostDialog.
		 * 
		 * @param type of transaction
		 * @param value of transaction
		 * @param isTask is posting task (doesn't need to be saved)
		 * @param isDestroyable set as removable object dialog
		 */
		public function PostDialog(type:String = "Loan", value:Number = 0, isTask:Boolean = true, isDestroyable:Boolean = true)
		{
			super();

			new MetalWorksDesktopTheme();

			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			this.type = type;
			this.value = value;
			this.isTask = isTask;
			this.isDestroyable = isDestroyable;

			coinManager = new RewardManager(RewardManager.REWARD_COIN, RewardManager.SPAWN_AVERAGE);
			gemManager = new RewardManager(RewardManager.REWARD_GEM, RewardManager.SPAWN_AVERAGE);

			overlay = new Quad(Starling.current.stage.stageWidth * 2.5, Starling.current.stage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;
			overlay.color = 0x000000;
			addChild(overlay);

			dialogBase = new Image(Assets.getAtlas(Assets.PANEL, Assets.PANEL_XML).getTexture("dialog_posting"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);

			var advisorAva:String = String(Config.Adviser[Data.advisor]).replace(" ", "_");
			advisorAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("advisor_" + advisorAva.toLowerCase()));
			advisorAvatar.pivotX = advisorAvatar.width * 0.5;
			advisorAvatar.pivotY = advisorAvatar.height;
			advisorAvatar.x = -190;
			advisorAvatar.y = 170;
			addChild(advisorAvatar);

			ballon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("tips_spirit"));
			ballon.x = -310;
			ballon.y = -120;
			ballon.pivotX = ballon.width;
			ballon.pivotY = ballon.height;
			addChild(ballon);

			label = new TextField(250, 150, "Transaction", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.x = -80;
			label.y = -170;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			question = new TextField(320, 150, transaction, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x333333);
			question.x = -80;
			question.y = -140;
			question.vAlign = VAlign.TOP;
			question.hAlign = HAlign.LEFT;
			addChild(question);

			label = new TextField(250, 30, "Debit", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.x = -80;
			label.y = -80;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			listDebit = new PickerList();
			listDebit.prompt = "Select a Debit Account";
			listDebit.dataProvider = new ListCollection(Config.account);
			listDebit.listProperties.@itemRendererProperties.labelField = "text";
			listDebit.labelField = "text";
			//listDebit.selectedIndex = -1;	
			listDebit.width = 310;
			listDebit.height = 30;
			listDebit.x = -80;
			listDebit.y = -50;
			addChild(listDebit);

			label = new TextField(250, 30, "Credit", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.x = -80;
			label.y = -20;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			addChild(label);

			listCredit = new PickerList();
			listCredit.prompt = "Select a Credit Account";
			listCredit.dataProvider = new ListCollection(Config.account);
			listCredit.listProperties.@itemRendererProperties.labelField = "text";
			listCredit.labelField = "text";
			//listCredit.selectedIndex = -1;
			listCredit.width = 310;
			listCredit.height = 30;
			listCredit.x = -80;
			listCredit.y = 10;
			addChild(listCredit);

			buttonHint = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_hint"));
			buttonHint.addEventListener(starling.events.Event.TRIGGERED, onSecondaryTrigerred);
			buttonHint.pivotX = buttonHint.width * 0.5;
			buttonHint.pivotY = buttonHint.height * 0.5;
			buttonHint.x = 15;
			buttonHint.y = 100;
			addChild(buttonHint);

			buttonPost = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_post"));
			buttonPost.addEventListener(starling.events.Event.TRIGGERED, onPrimaryTrigerred);
			buttonPost.pivotX = buttonPost.width * 0.5;
			buttonPost.pivotY = buttonPost.height * 0.5;
			buttonPost.x = 165;
			buttonPost.y = 100;
			addChild(buttonPost);

			hintDialog = HintDialog(Game.overlayStage.getChildByName("hint"));

			dialogInfo = NativeDialog(Game.overlayStage.getChildByName("info"));

			preparePosting();

			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}

		/**
		 * Find the answer and hint for this transaction.
		 */
		public function preparePosting():void
		{
			for (var i:uint = 0; i < Config.transaction.length; i++)
			{
				if (this.type == Config.transaction[i][1])
				{
					transaction = String(Config.transaction[i][2]).split("[value]").join(ValueFormatter.numberFormat(value, "IDR"));
					hint = Config.transaction[i][3];
					keyDebit = Config.transaction[i][4];
					keyCredit = Config.transaction[i][5];
					question.text = transaction;
					journalDescription = Config.transaction[i][6];
				}
			}
		}

		/**
		 * Set debit answer.
		 * 
		 * @param keyDebit
		 */
		public function set debit(keyDebit:String):void
		{
			this.keyDebit = keyDebit;
		}

		/**
		 * Get debit answer.
		 * 
		 * @return 
		 */
		public function get debit():String
		{
			return keyDebit;
		}

		/**
		 * Set credit answer.
		 * 
		 * 
		 * @param keyCredit
		 */
		public function set credit(keyCredit:String):void
		{
			this.keyCredit = keyCredit;
		}

		/**
		 * Get credit answer.
		 * 
		 * @return 
		 */
		public function get credit():String
		{
			return keyCredit;
		}

		/**
		 * Set transaction value.
		 * 
		 * @param value
		 */
		public function set transactionValue(value:int):void
		{
			this.value = value;
		}

		/**
		 * Get transaction value.
		 * 
		 * @return 
		 */
		public function get transactionValue():int
		{
			return value;
		}

		/**
		 * Set transaction description / question.
		 * 
		 * @param transaction
		 */
		public function set transactionDescription(transaction:String):void
		{
			question.text = transaction;
			this.transaction = transaction;
		}

		/**
		 * Get transaction description.
		 * 
		 * @return 
		 */
		public function get transactionDescription():String
		{
			return transaction;
		}

		/**
		 * Set transaction type.
		 * 
		 * @param type
		 */
		public function set transactionType(type:String):void
		{
			this.type = type;
		}

		/**
		 * Get transaction type.
		 * 
		 * @return 
		 */
		public function get transactionType():String
		{
			return type;
		}

		/**
		 * Open / show posting dialog.
		 */
		public function openDialog():void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this, 
				0.7, 
				{
					ease: Back.easeOut, 
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					delay: 0.4, 
					onComplete: function():void {
						fireworkManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5);
					}
				}
			);
		}

		/**
		 * Close / hide posting dialog.
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
					onComplete: function():void {
						visible = false;
						trace("post dispatching");
						dispatchEventWith(PostDialog.POSTING);
						if (isDestroyable)
						{
							trace("post destroyed");
							destroy();
						}
					}
				}
			);
		}

		/**
		 * Check if player select correct answer.
		 * 
		 * @return status of answer
		 */
		public function isMatched():Boolean
		{
			if (listCredit.selectedItem.text == keyCredit && listDebit.selectedItem.text == keyDebit)
			{
				return true;
			}
			return false;
		}

		/**
		 * Search account id for store into database by account text.
		 * 
		 * @param account name
		 * @return account id
		 */
		public function searchAccountId(account:String):int
		{
			for (var i:uint = 0; i < Config.account.length; i++)
			{
				if (Config.account[i].text == account)
				{
					return Config.account[i].id;
				}
			}

			return 0;
		}

		/**
		 * Search account index of list drop down to corrent player's answer 
		 * when hit hint by account name.
		 * 
		 * @param account name
		 * @return account index
		 */
		public function searchAccountIndex(account:String):int
		{
			for (var i:uint = 0; i < Config.account.length; i++)
			{
				if (Config.account[i].text == account)
				{
					return i;
				}
			}

			return 0;
		}

		/**
		 * Post the answer, check and store if correct and show notify if fail.
		 * 
		 * @param event
		 */
		public function onPrimaryTrigerred(event:starling.events.Event):void
		{
			if (isMatched())
			{
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);

				if (!isTask)
				{
					Game.loadingScreen.show();

					var gameObject:Object = new Object();
					gameObject.token = Data.key;
					gameObject.debit = searchAccountId(this.debit);
					gameObject.credit = searchAccountId(this.credit);
					gameObject.description = journalDescription;
					gameObject.value = transactionValue;
					gameObject.day = Data.playtime;

					server = new ServerManager("accounting/post_transaction", gameObject);
					server.addEventListener(ServerManager.READY, function(event:flash.events.Event):void
					{
						Game.loadingScreen.hide();
						closeDialog();

						if (debit == "[Assets] Cash")
						{
							coinManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 700, 40, transactionValue, true);
						}
						else if (credit == "[Assets] Cash")
						{
							coinManager.spawn(700, 40, Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, transactionValue, false);
						}

						gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400, 40, 200);
					});
					server.sendRequest();
				}
				else
				{
					closeDialog();
				}
			}
			else
			{
				Game.overlayStage.swapChildren(dialogInfo, Game.overlayStage.getChildAt(Game.overlayStage.numChildren - 1));
				dialogInfo.dialogTitle = "Posting Salah";
				dialogInfo.dialogMessage = "Cek pilihan akun Debit dan Credit";
				dialogInfo.openDialog();
				Data.isFailAnswer = true;
			}
		}

		/**
		 * Show the correct answer and hint.
		 * 
		 * @param event
		 */
		public function onSecondaryTrigerred(event:starling.events.Event):void
		{
			Assets.sfxChannel = Assets.sfxHarp.play(0, 0, Assets.sfxTransform);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);

			listDebit.selectedIndex = searchAccountIndex(keyDebit);
			listCredit.selectedIndex = searchAccountIndex(keyCredit);
			if (Game.overlayStage.getChildByName("hint") != null)
			{
				Game.overlayStage.swapChildren(hintDialog, Game.overlayStage.getChildAt(Game.overlayStage.numChildren - 1));
			}

			hintDialog.title = type.toUpperCase();
			hintDialog.hint = hint;
			hintDialog.openDialog();

			Data.isUseHint = true;
		}

		/**
		 * Release posting dialog resources.
		 */
		public function destroy():void
		{
			removeFromParent(true);
		}
	}
}
