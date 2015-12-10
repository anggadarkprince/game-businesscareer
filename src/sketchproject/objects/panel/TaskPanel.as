package sketchproject.objects.panel
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.managers.TaskManager;
	import sketchproject.objects.adapter.TaskAdapter;
	import sketchproject.objects.task.Task;
	import sketchproject.objects.task.TaskJournal;
	import sketchproject.objects.task.TaskOrder;
	import sketchproject.objects.task.TaskSelling;
	import sketchproject.objects.task.TaskUpgrade;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class TaskPanel extends Panel
	{
		private var taskList:Sprite;
		private var task:Task;
		private var tasks:Array;
		private var taskContainer:Sprite;
		private var baseList:Image;
		
		public function TaskPanel()
		{
			super(
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("icon_diamond"),
				Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("title_points"),
				"Earn points by accomplish task list and daily transaction"
			);
			
			taskList = new Sprite();
			taskList.x = -425;
			taskList.y = -170;
			addChild(taskList);	
			
			tasks = new Array();
			
			loadTask();
		}
				
		public function loadTask():void
		{
			taskList.removeChildren();
			for(var i:int = 0; i<Data.tasks.length; i++){
				taskContainer = new Sprite();
				
				baseList = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("task_list"));
				taskContainer.addChild(baseList);
				
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
				task.x = 80;
				task.y = 35;
				task.name = "task";
				taskContainer.addChild(task);
				
				var titleTask:TextField = new TextField(600, 35, "TASK "+Data.tasks[i][0].toString().toUpperCase(), Assets.getFont(Assets.FONT_ITCERAS).fontName, 22, 0x333333);			
				titleTask.x = 150;
				titleTask.y = 10;
				titleTask.hAlign = HAlign.LEFT;
				titleTask.vAlign = VAlign.TOP;
				taskContainer.addChild(titleTask);
				
				titleTask = new TextField(600, 35, Data.tasks[i][2], Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);			
				titleTask.x = 150;
				titleTask.y = 40;
				titleTask.hAlign = HAlign.LEFT;
				titleTask.vAlign = VAlign.TOP;
				taskContainer.addChild(titleTask);
				
				titleTask = new TextField(150, 35, Data.tasks[i][1] + " PTS", Assets.getFont(Assets.FONT_ITCERAS).fontName, 22, 0x333333);			
				titleTask.x = 670;
				titleTask.y = 10;
				titleTask.hAlign = HAlign.RIGHT;
				titleTask.vAlign = VAlign.TOP;
				taskContainer.addChild(titleTask);
				
				titleTask = new TextField(150, 35, "0/1", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);			
				titleTask.x = 670;
				titleTask.y = 40;
				titleTask.hAlign = HAlign.RIGHT;
				titleTask.vAlign = VAlign.TOP;
				taskContainer.addChild(titleTask);
				
				taskContainer.y = i * 90;
				
				taskList.addChild(taskContainer);
				//pushNewTask(taskContainer);
			}
		}
		
		public function pushNewTask(task:Sprite):void
		{
			task.addEventListener(TouchEvent.TOUCH, onTaskSelected);
			tasks.push(task);
			taskList.addChild(task);			
		}
		
		public function destroyTask(task:Task):void
		{
			for(var i:int = tasks.length-1; i>0; i--){
				if(task == task[i])
				{
					tasks.splice(i,1);
					Task(task[i]).destroy();
				}
			}
		}
		
		private function onTaskSelected(touch:TouchEvent):void
		{
			if(touch.getTouch(Sprite(touch.currentTarget),TouchPhase.ENDED)){	
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				Task(Sprite(touch.currentTarget).getChildByName("task")).showTaskDialog();
			}
		}
		
		override public function openDialog():void
		{
			loadTask();
			Assets.sfxChannel = Assets.sfxCoin.play(0,0,Assets.sfxTransform);			
			visible = true;
			TweenMax.to(
				this,
				0.7,
				{
					ease:Back.easeOut,
					scaleX:1,
					scaleY:1,
					alpha:1,
					delay:0.2
				}
			);	
		}
	}
}