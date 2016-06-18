package sketchproject.objects.task
{
	import com.greensock.TweenMax;

	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.objects.dialog.NewTaskDialog;

	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * Task icon float in map.
	 * 
	 * @author Angga
	 */
	public class Task extends Sprite
	{
		public var taskKey:int;

		protected var taskIcon:Image;
		protected var iconAnimate:Image;
		protected var newNotification:Image;
		protected var completeNotification:Image;

		private var type:String;
		private var reward:int;
		private var description:String;
		private var complete:Boolean;

		/**
		 * Default constructor of Task.
		 * 
		 * @param type
		 * @param reward
		 * @param description
		 * @param texture
		 */
		public function Task(type:String, reward:int, description:String, texture:String)
		{
			super();

			this.taskKey = Math.random() * 100000;

			this.type = type;
			this.reward = reward;
			this.description = description;

			iconAnimate = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("focus_circle"));
			iconAnimate.pivotX = iconAnimate.width * 0.5;
			iconAnimate.pivotY = iconAnimate.height * 0.5;
			addChild(iconAnimate);

			taskIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture));
			taskIcon.pivotX = taskIcon.width * 0.5;
			taskIcon.pivotY = taskIcon.height * 0.5;
			addChild(taskIcon);

			newNotification = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("new_task"));
			newNotification.pivotY = newNotification.height * 0.5;
			newNotification.x = 45;
			newNotification.alpha = 0;
			newNotification.visible = false;
			addChild(newNotification);

			completeNotification = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("label_check"));
			completeNotification.pivotY = newNotification.height * 0.5;
			completeNotification.x = 20;
			completeNotification.y = -20;
			completeNotification.visible = false;
			addChild(completeNotification);
		}

		/**
		 * Show new task notification.
		 */
		public function showNotification():void
		{
			newNotification.visible = true;
			TweenMax.to(
				newNotification, 
				0.5, 
				{
					alpha: 1, 
					delay: 5, 
					onComplete: function():void {
						TweenMax.to(
							newNotification, 
							0.7, 
							{
								repeat: 5, 
								x: newNotification.x + 30, 
								yoyo: true, 
								onComplete: function():void {
									TweenMax.to(
										newNotification, 
										0.5, 
										{
											alpha: 0, 
											x: newNotification.x + 30, 
											onComplete: function():void {
												newNotification.visible = false
											}
										}
									);
								}
							}
						);
					}
				}
			);
		}

		/**
		 * Set type of task.
		 * 
		 * @param type
		 */
		public function set typeTask(type:String):void
		{
			this.type = type;
		}

		/**
		 * Get type of task.
		 * 
		 * @return
		 */
		public function get typeTask():String
		{
			return type;
		}

		/**
		 * Set task reward.
		 * 
		 * @param reward
		 */
		public function set taskReward(reward:int):void
		{
			this.reward = reward;
		}

		/**
		 * Get task reward.
		 * 
		 * @return
		 */
		public function get taskReward():int
		{
			return reward;
		}

		/**
		 * Set task description.
		 * 
		 * @param description
		 */
		public function set taskDescription(description:String):void
		{
			this.description = description;
		}

		/**
		 * Get task description.
		 * 
		 * @return
		 */
		public function get taskDescription():String
		{
			return description;
		}

		/**
		 * Set status if a task is complete.
		 * 
		 * @param complete
		 */
		public function set isComplete(complete:Boolean):void
		{
			this.complete = complete;
		}

		/**
		 * Get status if a task is complete.
		 * 
		 * @return
		 */
		public function get isComplete():Boolean
		{
			return complete;
		}

		/**
		 * Open / show task instruction
		 */
		public function showTaskDialog():void
		{
			var newTask:NewTaskDialog = NewTaskDialog(Game.overlayStage.getChildByName("newTask"));
			newTask.taskInfo = description;
			newTask.taskReward = reward;
			newTask.taskType = type;
			newTask.openDialog();
		}

		/**
		 * Update icon rotation of task.
		 */
		public function update():void
		{
			iconAnimate.rotation += 0.1;
		}

		/**
		 * Set task is complete and give a check image.
		 */
		public function taskComplete():void
		{
			complete = true;
			completeNotification.visible = true;
		}

		/**
		 * Destroy and remove it if done.
		 */
		public function destroy():void
		{
			removeFromParent(true);
		}
	}
}
