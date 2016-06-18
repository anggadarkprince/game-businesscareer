package sketchproject.states
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.events.NavigationEvent;
	import sketchproject.events.ZoomEvent;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.DataManager;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.ServerManager;
	import sketchproject.managers.TaskManager;
	import sketchproject.objects.QuickHelp;
	import sketchproject.objects.dialog.AvatarDialog;
	import sketchproject.objects.dialog.BoosterDialog;
	import sketchproject.objects.dialog.CompleteDialog;
	import sketchproject.objects.dialog.HelpDialog;
	import sketchproject.objects.dialog.HintDialog;
	import sketchproject.objects.dialog.Leaderboard;
	import sketchproject.objects.dialog.NativeDialog;
	import sketchproject.objects.dialog.NewTaskDialog;
	import sketchproject.objects.dialog.OptionDialog;
	import sketchproject.objects.dialog.PauseDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.objects.dialog.UnlockDialog;
	import sketchproject.objects.panel.AchievementPanel;
	import sketchproject.objects.panel.CustomerPanel;
	import sketchproject.objects.panel.ProfitPanel;
	import sketchproject.objects.panel.TaskPanel;
	import sketchproject.objects.world.GameMenu;
	import sketchproject.screens.AdvertisingScreen;
	import sketchproject.screens.BusinessScreen;
	import sketchproject.screens.EmployeeScreen;
	import sketchproject.screens.FinanceScreen;
	import sketchproject.screens.GameScreen;
	import sketchproject.screens.IssuesScreen;
	import sketchproject.screens.MapScreen;
	import sketchproject.screens.ProductScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Main game feature state, manage business, employee, promotion, finance and profile.
	 *
	 * @author Angga
	 */
	public class Play extends Sprite implements IState
	{
		private var game:Game;
		private var fireworkManager:FireworkManager;

		// layers
		private var hud:GameMenu;
		private var screens:Sprite;

		//screen
		private var mapScreen:MapScreen;
		private var businessScreen:BusinessScreen;
		private var productScreen:ProductScreen;
		private var employeeScreen:EmployeeScreen;
		private var issuesScreen:IssuesScreen;
		private var advertScreen:AdvertisingScreen;
		private var financeScreen:FinanceScreen;

		private var dialogHint:HintDialog = new HintDialog();
		private var dialogInfo:NativeDialog = new NativeDialog(NativeDialog.DIALOG_INFORMATION);

		// panels
		private var panelCustomer:CustomerPanel = new CustomerPanel();
		private var panelTask:TaskPanel = new TaskPanel();
		private var panelAchievement:AchievementPanel = new AchievementPanel();
		private var panelProfit:ProfitPanel = new ProfitPanel();

		// dialogs
		private var dialogHelp:HelpDialog;
		private var dialogProfile:AvatarDialog;
		private var dialogLeaderboard:Leaderboard;
		private var dialogBooster:BoosterDialog;
		private var dialogPause:PauseDialog;
		private var dialogOption:OptionDialog;
		private var dialogPost:PostDialog;

		private var unlockDialog:UnlockDialog = new UnlockDialog();
		private var completeDialog:CompleteDialog = new CompleteDialog();
		private var taskDialog:NewTaskDialog = new NewTaskDialog();

		// managers
		private var taskManager:TaskManager;

		private var isMapActive:Boolean;

		/**
		 * Default constructor of Play state.
		 *
		 * @param game root
		 */
		public function Play(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event:Event):void
		{
			initialize();
			trace("[STATE] PLAY");
		}

		/**
		 * Initialize all play state components.
		 */
		public function initialize():void
		{
			fireworkManager = FireworkManager.getInstance(Game.overlayStage);

			screens = new Sprite();
			addChild(screens);

			unlockDialog.x = stage.stageWidth * 0.5;
			unlockDialog.y = stage.stageHeight * 0.5;
			unlockDialog.name = "unlockAchievement";
			unlockDialog.addEventListener(UnlockDialog.ACHIEVEMENT_UNLOCKED, function(event:Event):void {
				unlockCheck();
			});
			Game.overlayStage.addChild(unlockDialog);

			completeDialog.x = stage.stageWidth * 0.5;
			completeDialog.y = stage.stageHeight * 0.5;
			completeDialog.name = "taskComplete";
			Game.overlayStage.addChild(completeDialog);

			taskDialog.x = stage.stageWidth * 0.5;
			taskDialog.y = stage.stageHeight * 0.5;
			taskDialog.name = "newTask";
			Game.overlayStage.addChild(taskDialog);

			dialogInfo.x = stage.stageWidth * 0.5;
			dialogInfo.y = stage.stageHeight * 0.5;
			dialogInfo.name = "info";
			dialogInfo.addEventListener(DialogBoxEvent.CLOSED, function(event:DialogBoxEvent):void {
				dialogInfo.closeDialog()
			});
			Game.overlayStage.addChild(dialogInfo);

			dialogPost = new PostDialog("Loan", 0, false, false);
			dialogPost.x = stage.stageWidth * 0.5;
			dialogPost.y = stage.stageHeight * 0.5;
			dialogPost.addEventListener(PostDialog.POSTING, recallPosting);
			Game.overlayStage.addChild(dialogPost);

			hud = new GameMenu();

			hud.addEventListener(NavigationEvent.SWITCH, onTriggered);
			hud.addEventListener(ZoomEvent.ZOOM_IN, onZoomIn);
			hud.addEventListener(ZoomEvent.ZOOM_OUT, onZoomOut);

			dialogHint.x = stage.stageWidth * 0.5;
			dialogHint.y = stage.stageHeight * 0.5;
			dialogHint.name = "hint";
			Game.overlayStage.addChild(dialogHint);

			mapScreen = new MapScreen();
			mapScreen.x = stage.stageWidth * 0.5;
			mapScreen.y = stage.stageHeight * 0.5;
			screens.addChild(mapScreen);

			businessScreen = new BusinessScreen(hud);
			businessScreen.x = stage.stageWidth * 0.5;
			businessScreen.y = stage.stageHeight * 0.5;
			screens.addChild(businessScreen);

			productScreen = new ProductScreen(hud);
			productScreen.x = stage.stageWidth * 0.5;
			productScreen.y = stage.stageHeight * 0.5;
			screens.addChild(productScreen);

			employeeScreen = new EmployeeScreen(hud);
			employeeScreen.x = stage.stageWidth * 0.5;
			employeeScreen.y = stage.stageHeight * 0.5;
			screens.addChild(employeeScreen);

			issuesScreen = new IssuesScreen();
			issuesScreen.x = stage.stageWidth * 0.5;
			issuesScreen.y = stage.stageHeight * 0.5;
			screens.addChild(issuesScreen);

			advertScreen = new AdvertisingScreen(hud);
			advertScreen.x = stage.stageWidth * 0.5;
			advertScreen.y = stage.stageHeight * 0.5;
			screens.addChild(advertScreen);

			financeScreen = new FinanceScreen();
			financeScreen.x = stage.stageWidth * 0.5;
			financeScreen.y = stage.stageHeight * 0.5;
			screens.addChild(financeScreen);

			addChild(hud);

			dialogHelp = new HelpDialog();
			dialogHelp.x = stage.stageWidth * 0.5;
			dialogHelp.y = stage.stageHeight * 0.5;
			addChild(dialogHelp);

			dialogOption = new OptionDialog();
			dialogOption.x = stage.stageWidth * 0.5;
			dialogOption.y = stage.stageHeight * 0.5;
			dialogOption.addEventListener(OptionDialog.SOUND_CHANGED, onSoundChanged);

			dialogProfile = new AvatarDialog();
			dialogProfile.x = stage.stageWidth * 0.5;
			dialogProfile.y = stage.stageHeight * 0.5;
			addChild(dialogProfile);

			dialogLeaderboard = new Leaderboard();
			dialogLeaderboard.x = stage.stageWidth * 0.5;
			dialogLeaderboard.y = stage.stageHeight * 0.5;
			addChild(dialogLeaderboard);

			dialogBooster = new BoosterDialog();
			dialogBooster.x = stage.stageWidth * 0.5;
			dialogBooster.y = stage.stageHeight * 0.5;
			addChild(dialogBooster);

			panelCustomer.x = stage.stageWidth * 0.5;
			panelCustomer.y = stage.stageHeight * 0.5;
			addChild(panelCustomer);

			panelTask.x = stage.stageWidth * 0.5;
			panelTask.y = stage.stageHeight * 0.5;
			addChild(panelTask);

			panelAchievement.x = stage.stageWidth * 0.5;
			panelAchievement.y = stage.stageHeight * 0.5;
			addChild(panelAchievement);

			panelProfit.x = stage.stageWidth * 0.5;
			panelProfit.y = stage.stageHeight * 0.5;
			addChild(panelProfit);

			dialogPause = new PauseDialog(game, dialogOption);
			dialogPause.x = stage.stageWidth * 0.5;
			dialogPause.y = stage.stageHeight * 0.5;
			addChild(dialogPause);
			addChild(dialogOption);

			taskManager = new TaskManager(hud);

			if (Config.firstOpen)
			{
				Config.firstOpen = false;
				var quickHelp:QuickHelp = new QuickHelp();
				quickHelp.x = stage.stageWidth * 0.5;
				quickHelp.y = stage.stageHeight * 0.5;
				quickHelp.addEventListener(DialogBoxEvent.CLOSED, onOpenShop);
				addChild(quickHelp);
				quickHelp.openDialog();
				Assets.sfxChannel = Assets.sfxWelcome.play(0, 0, Assets.sfxTransform);
			}

			isMapActive = true;

			switchScreen(mapScreen);

			unlockCheck();
		}

		/**
		 * Dispatched from option dialog to check sound status is muted or loud.
		 * 
		 * @param event
		 */
		private function onSoundChanged(event:Event):void
		{
			hud.checkSoundState();
		}

		/**
		 * Open post transaction if game is played for the first time.
		 * 
		 * @param event
		 */
		private function onOpenShop(event:Event):void
		{
			initialPosting();
		}

		/**
		 * Initial transaction must be posted when play the game for the first time.
		 */
		private function initialPosting():void
		{
			if (Config.firstPlay)
			{
				if (Config.transactionList.length > 0)
				{
					dialogPost.transactionType = Config.transactionList[0][0];
					dialogPost.transactionValue = Config.transactionList[0][1];
					dialogPost.preparePosting();
					dialogPost.openDialog();
					
					Config.transactionList.shift();
				}
				else
				{
					Config.firstPlay = false;
					
					var save:DataManager = new DataManager();
					save.saveGameData();
				}
			}
		}

		/**
		 * Recall posting dialog until initial transaction is empty.
		 * 
		 * @param event
		 */
		private function recallPosting(event:Event):void
		{
			initialPosting();
		}

		/**
		 * Check player has been unlock the achievement.
		 */
		private function unlockCheck():void
		{
			if (Config.achieved.length > 0)
			{
				var unlock:Object = Config.achieved.shift();
				unlockDialog.unlockInfo = "Kamu membuka achievement " + unlock.ach_achievement;
				unlockDialog.unlockIcon = unlock.ach_atlas;
				unlockDialog.openDialog();
				
				panelAchievement.updateEarned();
				
				Data.point += int(unlock.ach_reward);

				var gameObject:Object = new Object();
				gameObject.token = Data.key;
				gameObject.achievement = unlock.ach_id;

				var server:ServerManager = new ServerManager("achievement/unlock_achievement", gameObject);
				server.sendRequest();
			}
		}

		/**
		 * Event handler when player try to zoom out the map.
		 * 
		 * @param event
		 */
		private function onZoomOut(event:ZoomEvent):void
		{
			if (Config.zoom > 1)
			{
				hud.zoomControl(--Config.zoom);
				mapScreen.scaleX = Config.zoom;
				mapScreen.scaleY = Config.zoom;
				mapScreen.resetPosition();
			}
		}

		/**
		 * Event handler when player try to zoom in the map.
		 * 
		 * @param event
		 */
		private function onZoomIn(event:ZoomEvent):void
		{
			if (Config.zoom < 3)
			{
				hud.zoomControl(++Config.zoom);
				mapScreen.scaleX = Config.zoom;
				mapScreen.scaleY = Config.zoom;
				mapScreen.resetPosition();
			}
		}

		/**
		 * Event handler when player hit the menu.
		 * 
		 * @param event
		 */
		private function onTriggered(event:NavigationEvent):void
		{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			switch (event.navigate)
			{
				/** HUD menu list **/
				case NavigationEvent.NAVIGATE_CUSTOMER:
					trace("[PANEL] customer");
					panelCustomer.openDialog();
					break;
				case NavigationEvent.NAVIGATE_POINT:
					trace("[PANEL] POINT");
					panelTask.openDialog();
					break;
				case NavigationEvent.NAVIGATE_STAR:
					trace("[PANEL] achievement");
					panelAchievement.openDialog();
					break;
				case NavigationEvent.NAVIGATE_PROFIT:
					trace("[PANEL] profit");
					panelProfit.openDialog();
					break;

				/** Side menu list **/
				case NavigationEvent.NAVIGATE_HELP:
					trace("[DIALOG] help");
					dialogHelp.openDialog();
					break;
				case NavigationEvent.NAVIGATE_SETTING:
					trace("[DIALOG] setting");
					dialogOption.openDialog();
					break;
				case NavigationEvent.NAVIGATE_AVATAR:
					trace("[DIALOG] my avatar");
					dialogProfile.openDialog();
					break;
				case NavigationEvent.NAVIGATE_ACHIEVEMENT:
					trace("[PANEL] achievement");
					panelAchievement.openDialog();
					break;
				case NavigationEvent.NAVIGATE_LEADERBOARD:
					trace("[DIALOG] leaderboard");
					dialogLeaderboard.openDialog();
					break;
				case NavigationEvent.NAVIGATE_BOOSTER:
					trace("[DIALOG] booster");
					dialogBooster.openDialog();
					break;
				case NavigationEvent.NAVIGATE_PAUSE:
					trace("[DIALOG] pause");
					dialogPause.openDialog();
					break;
				case NavigationEvent.NAVIGATE_MARKET:
					trace("[PLAY] market");
					LoadingTransition.destination = Game.WORLD_STATE;
					trace(LoadingTransition.destination);
					game.changeState(Game.TRANSITION_STATE);
					break;

				/** Dashboard menu list **/				
				case NavigationEvent.NAVIGATE_MAP:
					trace("[MENU] launch map");
					switchScreen(mapScreen);
					break;
				case NavigationEvent.NAVIGATE_BUSINESS:
					trace("[MENU] launch business");
					businessScreen.update();
					switchScreen(businessScreen);
					break;
				case NavigationEvent.NAVIGATE_PRODUCT:
					trace("[MENU] launch product");
					switchScreen(productScreen);
					break;
				case NavigationEvent.NAVIGATE_EMPLOYEE:
					trace("[MENU] launch employee");
					switchScreen(employeeScreen);
					break;
				case NavigationEvent.NAVIGATE_ISSUES:
					trace("[MENU] launch issues");
					switchScreen(issuesScreen);
					break;
				case NavigationEvent.NAVIGATE_ADVERTISING:
					trace("[MENU] launch advertising");
					switchScreen(advertScreen);
					break;
				case NavigationEvent.NAVIGATE_FINANCE:
					trace("[MENU] launch finance");
					financeScreen.startRetrieveFinance();
					switchScreen(financeScreen);
					break;
			}
		}

		/**
		 * Change current active screen, set visible false all, 
		 * then visible the passed screen.
		 *
		 * @param screen
		 */
		public function switchScreen(screen:GameScreen):void
		{
			mapScreen.visible = false;
			businessScreen.visible = false;
			productScreen.visible = false;
			employeeScreen.visible = false;
			issuesScreen.visible = false;
			advertScreen.visible = false;
			financeScreen.visible = false;

			mapScreen.hideMenu();
			businessScreen.hideMenu();
			productScreen.hideMenu();
			employeeScreen.hideMenu();
			issuesScreen.hideMenu();
			advertScreen.hideMenu();
			financeScreen.hideMenu();

			if (screen == mapScreen)
			{
				isMapActive = true;
				hud.showHUD();
			}
			else
			{
				isMapActive = false;
				hud.hideHUD();
			}

			screen.showMenu();
			screen.visible = true;
		}

		/**
		 * Update screen and module component.
		 */
		public function update():void
		{
			hud.update();
			dialogOption.update();
			unlockDialog.update();
			
			if (isMapActive)
			{
				mapScreen.update();
				taskManager.update();
			}
		}

		/**
		 * Release all resources.
		 */
		public function destroy():void
		{
			hud.destroy();
			mapScreen.destroy();
			dialogOption.removeFromParent();
			dialogHelp.removeFromParent();
			dialogProfile.removeFromParent();
			removeFromParent(true);
		}

		/**
		 * Print current state.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.states.PlayState";
		}
	}
}
