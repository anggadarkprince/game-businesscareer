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

	public class TaskManager
	{
		public static const TASK_JOURNAL:String ="journal";
		public static const TASK_SELLING:String = "selling";
		public static const TASK_ORDER:String = "order";
		public static const TASK_UPGRADE:String ="upgrade";
		
		private var worldLists:Sprite;
		
		private var gameMenu:GameMenu;
		
		private var task:Task;		
		private var tasks:Array;
		
		private var eventFactory:EventFactory;
		
		private var newTaskDialog:NewTaskDialog;
		private var completeDialog:CompleteDialog;
		private var post:PostDialog;
		
		private var gemManager:RewardManager;
		
		private var server:DataManager;
		
		public function TaskManager(hud:GameMenu)
		{
			this.gameMenu = hud;
			
			tasks = new Array();
			
			eventFactory = new EventFactory();
			
			worldLists = new Sprite();
			worldLists.x = 50;
			worldLists.y = 90;
			this.gameMenu.addTaskList(worldLists);
			
			newTaskDialog = NewTaskDialog(Game.overlayStage.getChildByName("newTask"));
			newTaskDialog.addEventListener(DialogBoxEvent.CLOSED, onTaskConfirmed);
			
			completeDialog = CompleteDialog(Game.overlayStage.getChildByName("taskComplete"));
			
			post = new PostDialog("Loan", 100000, true);
			
			gemManager = new RewardManager(RewardManager.REWARD_GEM);
			
			server = new DataManager();
			
			loadTask();
		}
		
		private function onTaskConfirmed(event:DialogBoxEvent):void
		{
			if(task.isComplete){						
				taskCompletion();
			}
			
			if(task.typeTask == TaskManager.TASK_JOURNAL && !task.isComplete){				
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
		
		private function onPostConfirmed(event:Event):void
		{
			if(post.isMatched()){
				taskCompletion();
			}
		}
		
		public function taskCompletion():void
		{							
			completeDialog.completeInfo = "You have done "+task.typeTask+" Task, you've got "+task.taskReward+" PTS";
			completeDialog.openDialog();
			Data.point += task.taskReward;
			destroyTask(task);
			gemManager.spawn(Starling.current.stage.stageWidth * 0.5, Starling.current.stage.stageHeight * 0.5, 400,40,1200);
			server.saveGameData();
		}
		
		public function loadTask():void
		{
			worldLists.removeChildren();
			for(var i:int = 0; i<Data.tasks.length; i++){
				switch(Data.tasks[i][0]){
					case TaskManager.TASK_JOURNAL:
						task = new TaskJournal(Data.tasks[i][0],Data.tasks[i][1],Data.tasks[i][2],Data.tasks[i][3]);						
						TaskJournal(task).transactionType = Data.tasks[i][4];
						break;
					case TaskManager.TASK_UPGRADE:
						task = new TaskUpgrade(Data.tasks[i][0],Data.tasks[i][1],Data.tasks[i][2],Data.tasks[i][3]);
						TaskUpgrade(task).upgradeTarget = Data.tasks[i][4];
						TaskUpgrade(task).upgradeLevel = Data.tasks[i][5];
						break;
					case TaskManager.TASK_SELLING:
						task = new TaskSelling(Data.tasks[i][0],Data.tasks[i][1],Data.tasks[i][2],Data.tasks[i][3]);
						TaskSelling(task).sellingTarget = Data.tasks[i][4];
						break;
					case TaskManager.TASK_ORDER:
						task = new TaskOrder(Data.tasks[i][0],Data.tasks[i][1],Data.tasks[i][2],Data.tasks[i][3]);
						TaskOrder(task).productTarget = Data.tasks[i][4];
						TaskOrder(task).quantityTarget = Data.tasks[i][5];
						break;
				}
				pushNewTask(task);
			}
		}
		
		public function pushNewTask(task:Task):void
		{
			task.scaleX = 0.8;
			task.scaleY = 0.8;
			task.showNotification();
			task.addEventListener(TouchEvent.TOUCH, onTaskSelected);
			tasks.push(task);
			worldLists.addChild(task);			
		}
		
		private function onTaskSelected(touch:TouchEvent):void
		{
			if(touch.getTouch(Task(touch.currentTarget),TouchPhase.ENDED)){
				Task(touch.currentTarget).showTaskDialog();
				task = Task(touch.currentTarget);
			}
		}
		
		public function generateNewTask():void
		{
			var taskLength:int = Data.tasks.length;
			if(Data.tasks.length < 4){
				if(Math.random() < 0.5){
					var totalGenerate:int = GameUtils.randomFor(4 - taskLength);
					for(var i:int = 0; i < totalGenerate; i++){
						var newTask:Array = EventFactory.generateTask();
						if(newTask.length != 0)
						{
							Data.tasks.push(newTask);
							switch(newTask[0]){
								case TaskManager.TASK_JOURNAL:
									task = new TaskJournal(newTask[0],newTask[1],newTask[2],newTask[3]);						
									TaskJournal(task).transactionType = newTask[4];
									break;
								case TaskManager.TASK_UPGRADE:
									task = new TaskUpgrade(newTask[0],newTask[1],newTask[2],newTask[3]);
									TaskUpgrade(task).upgradeTarget = newTask[4];
									TaskUpgrade(task).upgradeLevel = newTask[5];
									break;
								case TaskManager.TASK_SELLING:
									task = new TaskSelling(newTask[0],newTask[1],newTask[2],newTask[3]);
									TaskSelling(task).sellingTarget = newTask[4];
									break;
								case TaskManager.TASK_ORDER:
									task = new TaskOrder(newTask[0],newTask[1],newTask[2],newTask[3]);
									TaskOrder(task).productTarget = newTask[4];
									TaskOrder(task).quantityTarget = newTask[5];
									break;
							}
							pushNewTask(task);
						}
						else{
							trace("all assets has upgraded");
						}
					}
					server.saveGameData();
				}
				else{
					trace("skip generate task");
				}
			}
			else{
				trace("task allready 4");	
			}			
		}
		
		public function update():void
		{	
			completeDialog.update();
			
			for(var i:int = 0; i<tasks.length; i++){
				Task(tasks[i]).update();
				
				if(Task(tasks[i]).y < (3 * 70) - (i * 70)){
					Task(tasks[i]).y+=5;
				}			
				
				switch(Task(tasks[i]).typeTask){
					case TaskManager.TASK_JOURNAL:
						if(TaskJournal(tasks[i]).checkTask(false)){
							TaskJournal(tasks[i]).taskComplete();
						}
						break;
					case TaskManager.TASK_UPGRADE:
						if(TaskUpgrade(tasks[i]).checkTask()){
							TaskUpgrade(tasks[i]).taskComplete();
						}
						break;
					case TaskManager.TASK_SELLING:
						if(TaskSelling(tasks[i]).checkTask(Data.salesToday)){
							TaskSelling(tasks[i]).taskComplete();
						}
						break;
					case TaskManager.TASK_ORDER:
						for(var j:int = 0; j < Data.inventory.length; j++){
							if(TaskOrder(tasks[i]).checkTask(Data.inventory[j].mtr_id,Data.inventory[j].pma_stock)){
								TaskOrder(tasks[i]).taskComplete();
							}
						}						
						break;
				}
			}
		}	
		
		public function destroyTask(task:Task):void
		{
			for(var i:int = tasks.length-1; i>=0; i--){
				if(task == Task(tasks[i]))
				{										
					Task(tasks[i]).destroy();
					tasks.splice(i,1);
					Data.tasks.splice(i,1);
				}
			}
		}
	
	}
}