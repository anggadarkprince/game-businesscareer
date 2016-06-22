package sketchproject.managers
{
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.modules.EventFactory;
	import sketchproject.objects.dialog.CompleteDialog;
	import sketchproject.objects.dialog.NewTaskDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.objects.task.Task;
	import sketchproject.objects.task.TaskJournal;
	import sketchproject.objects.task.TaskOrder;
	import sketchproject.objects.task.TaskSelling;
	import sketchproject.objects.task.TaskUpgrade;
	import sketchproject.objects.world.GameMenu;
	import sketchproject.utilities.GameUtils;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Manage task list on screen.
	 *
	 * @author Angga
	 */
	public class TaskManager
	{
		public static const TASK_JOURNAL:String = "journal";
		public static const TASK_SELLING:String = "selling";
		public static const TASK_ORDER:String = "order";
		public static const TASK_UPGRADE:String = "upgrade";

		private var taskContainer:Sprite;
		private var gameMenu:GameMenu;

		private var task:Task;
		private var tasks:Array;

		private var newTaskDialog:NewTaskDialog;
		private var completeDialog:CompleteDialog;
		private var post:PostDialog;

		private var eventFactory:EventFactory;
		private var gemManager:RewardManager;
		private var server:DataManager;

		/**
		 * Default constructor of TaskManager.
		 *
		 * @param hud
		 */
		public function TaskManager(hud:GameMenu)
		{
			gameMenu = hud;

			tasks = new Array();

			eventFactory = new EventFactory();

			taskContainer = new Sprite();
			taskContainer.x = 50;
			taskContainer.y = 90;
			gameMenu.addTaskList(taskContainer);

			newTaskDialog = NewTaskDialog(Game.overlayStage.getChildByName("newTask"));
			newTaskDialog.addEventListener(DialogBoxEvent.CLOSED, onTaskConfirmed);

			completeDialog = CompleteDialog(Game.overlayStage.getChildByName("taskComplete"));

			post = new PostDialog("Loan", 100000, true);

			gemManager = new RewardManager(RewardManager.REWARD_GEM);

			server = new DataManager();

			loadTask();
		}

		/**
		 * Load task from player's data and generate by its type.
		 */
		public function loadTask():void
		{
			taskContainer.removeChildren();
			for (var i:int = 0; i < Data.tasks.length; i++)
			{
				switch (Data.tasks[i][0])
				{
					case TaskManager.TASK_JOURNAL:
						task = new TaskJournal(Data.tasks[i][0], Data.tasks[i][1], Data.tasks[i][2], Data.tasks[i][3]);
						TaskJournal(task).transactionType = Data.tasks[i][4];
						break;
					case TaskManager.TASK_UPGRADE:
						task = new TaskUpgrade(Data.tasks[i][0], Data.tasks[i][1], Data.tasks[i][2], Data.tasks[i][3]);
						TaskUpgrade(task).upgradeTarget = Data.tasks[i][4];
						TaskUpgrade(task).upgradeLevel = Data.tasks[i][5];
						break;
					case TaskManager.TASK_SELLING:
						task = new TaskSelling(Data.tasks[i][0], Data.tasks[i][1], Data.tasks[i][2], Data.tasks[i][3]);
						TaskSelling(task).sellingTarget = Data.tasks[i][4];
						break;
					case TaskManager.TASK_ORDER:
						task = new TaskOrder(Data.tasks[i][0], Data.tasks[i][1], Data.tasks[i][2], Data.tasks[i][3]);
						TaskOrder(task).productTarget = Data.tasks[i][4];
						TaskOrder(task).quantityTarget = Data.tasks[i][5];
						break;
				}
				pushNewTask(task);
			}
		}

		/**
		 * Push new task into container and collection.
		 *
		 * @param task
		 */
		public function pushNewTask(task:Task):void
		{
			task.scaleX = 0.8;
			task.scaleY = 0.8;
			task.showNotification();
			task.addEventListener(TouchEvent.TOUCH, onTaskSelected);

			tasks.push(task);

			taskContainer.addChild(task);
		}

		/**
		 * Event handler when task is clicked.
		 *
		 * @param touch
		 */
		private function onTaskSelected(touch:TouchEvent):void
		{
			if (touch.getTouch(Task(touch.currentTarget), TouchPhase.ENDED))
			{
				task = Task(touch.currentTarget);
				task.showTaskDialog();
			}
		}

		/**
		 * Task confirmed, dispatched from task dialog.
		 *
		 * @param event
		 */
		private function onTaskConfirmed(event:DialogBoxEvent):void
		{
			if (task.isComplete)
			{
				taskCompletion();
			}

			if (task.typeTask == TaskManager.TASK_JOURNAL && !task.isComplete)
			{
				post.transactionType = TaskJournal(task).transactionType;
				post.transactionValue = 100000;
				post.isTask = true;
				post.isDestroyable = false;
				post.preparePosting();
				post.x = Starling.current.stage.stageWidth * 0.5;
				post.y = Starling.current.stage.stageHeight * 0.5;
				post.addEventListener(PostDialog.POSTING, onPostConfirmed);
				Game.overlayStage.addChild(post);
				post.openDialog();
			}
		}

		/**
		 * Confirm post task triggered.
		 *
		 * @param event
		 */
		private function onPostConfirmed(event:Event):void
		{
			if (post.isMatched())
			{
				taskCompletion();
			}
		}

		/**
		 * Task complete and show complete dialog.
		 */
		public function taskCompletion():void
		{
			completeDialog.completeInfo = "Berhasil menyelesaikan task " + task.typeTask + ", kamu mendapat " + task.taskReward + " PTS";
			completeDialog.openDialog();
			Data.point += task.taskReward;
			destroyTask(task);
			gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400, 40, 1200);
			server.saveGameData();
		}

		/**
		 * Remove task from list if complete.
		 *
		 * @param task has completed
		 */
		public function destroyTask(task:Task):void
		{
			for (var i:int = tasks.length - 1; i >= 0; i--)
			{
				if (task == Task(tasks[i]))
				{
					Task(tasks[i]).destroy();
					tasks.splice(i, 1);
					Data.tasks.splice(i, 1);
				}
			}
		}

		/**
		 * Add new task into list, max 4 task active.
		 */
		public function generateNewTask():void
		{
			var taskLength:int = Data.tasks.length;
			if (Data.tasks.length < 4)
			{
				if (Math.random() < 0.5)
				{
					var totalGenerate:int = GameUtils.randomFor(4 - taskLength);
					for (var i:int = 0; i < totalGenerate; i++)
					{
						var newTask:Array = EventFactory.generateTask();
						if (newTask.length != 0)
						{
							Data.tasks.push(newTask);
							switch (newTask[0])
							{
								case TaskManager.TASK_JOURNAL:
									task = new TaskJournal(newTask[0], newTask[1], newTask[2], newTask[3]);
									TaskJournal(task).transactionType = newTask[4];
									break;
								case TaskManager.TASK_UPGRADE:
									task = new TaskUpgrade(newTask[0], newTask[1], newTask[2], newTask[3]);
									TaskUpgrade(task).upgradeTarget = newTask[4];
									TaskUpgrade(task).upgradeLevel = newTask[5];
									break;
								case TaskManager.TASK_SELLING:
									task = new TaskSelling(newTask[0], newTask[1], newTask[2], newTask[3]);
									TaskSelling(task).sellingTarget = newTask[4];
									break;
								case TaskManager.TASK_ORDER:
									task = new TaskOrder(newTask[0], newTask[1], newTask[2], newTask[3]);
									TaskOrder(task).productTarget = newTask[4];
									TaskOrder(task).quantityTarget = newTask[5];
									break;
							}
							pushNewTask(task);
						}
						else
						{
							trace("all assets has upgraded");
						}
					}
					server.saveGameData();
				}
				else
				{
					trace("skip generate task");
				}
			}
			else
			{
				trace("task allready 4");
			}
		}

		/**
		 * Update task position and check if task if complete.
		 */
		public function update():void
		{
			if (completeDialog.visible)
			{
				completeDialog.update();
			}

			for (var i:int = 0; i < tasks.length; i++)
			{
				Task(tasks[i]).update();

				if (Task(tasks[i]).y < (3 * 70) - (i * 70))
				{
					Task(tasks[i]).y += 5;
				}

				switch (Task(tasks[i]).typeTask)
				{
					case TaskManager.TASK_JOURNAL:
						if (TaskJournal(tasks[i]).checkTask(false))
						{
							TaskJournal(tasks[i]).taskComplete();
						}
						break;
					case TaskManager.TASK_UPGRADE:
						if (TaskUpgrade(tasks[i]).checkTask())
						{
							TaskUpgrade(tasks[i]).taskComplete();
						}
						break;
					case TaskManager.TASK_SELLING:
						if (TaskSelling(tasks[i]).checkTask(Data.salesToday))
						{
							TaskSelling(tasks[i]).taskComplete();
						}
						break;
					case TaskManager.TASK_ORDER:
						for (var j:int = 0; j < Data.material.length; j++)
						{
							if (TaskOrder(tasks[i]).checkTask(Data.material[j].mtr_id, Data.material[j].pma_stock))
							{
								TaskOrder(tasks[i]).taskComplete();
							}
						}
						break;
				}
			}
		}
	}
}
