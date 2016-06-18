package sketchproject.objects.task
{
	import sketchproject.core.Data;

	/**
	 * Task upgrade plain object extend Task, add asset type and level target.
	 * 
	 * @author Angga
	 */
	public class TaskUpgrade extends Task
	{
		private var targetItem:String;
		private var level:int;

		/**
		 * Default constructor of TaskUpgrade.
		 * 
		 * @param type of task
		 * @param reward of task
		 * @param description of task
		 * @param texture of task
		 */
		public function TaskUpgrade(type:String, reward:int, description:String, texture:String)
		{
			super(type, reward, description, texture);
		}

		/**
		 * Set asset to be upgraded.
		 * 
		 * @param target
		 */
		public function set upgradeTarget(target:String):void
		{
			this.targetItem = target;
		}

		/**
		 * Get asset to be upgraded.
		 * 
		 * @return
		 */
		public function get upgradeTarget():String
		{
			return targetItem;
		}

		/**
		 * Set level of asset must upgraded.
		 * 
		 * @param level
		 */
		public function set upgradeLevel(level:int):void
		{
			this.level = level;
		}

		/**
		 * Get level of asset must upgraded.
		 * 
		 * @return
		 */
		public function get upgradeLevel():int
		{
			return level;
		}

		/**
		 * Check if player has complete upgrade the asset.
		 * 
		 * @return status of task
		 */
		public function checkTask():Boolean
		{
			for (var i:int = 0; i < Data.asset.length; i++)
			{
				if (Data.asset[i].ast_type == targetItem && Data.asset[i].ast_level == level)
				{
					return true;
				}
			}
			return false;
		}
	}
}
