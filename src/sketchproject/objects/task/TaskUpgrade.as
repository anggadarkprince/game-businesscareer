package sketchproject.objects.task
{
	import sketchproject.core.Data;

	public class TaskUpgrade extends Task
	{
		private var targetItem:String;
		private var level:int;
		
		public function TaskUpgrade(type:String, reward:int, description:String, texture:String)
		{
			super(type, reward, description, texture);
		}
				
		public function set upgradeTarget(target:String):void
		{
			this.targetItem = target;
		}
		
		public function get upgradeTarget():String
		{
			return targetItem;
		}
		
		public function set upgradeLevel(level:int):void
		{
			this.level = level;
		}
		
		public function get upgradeLevel():int
		{
			return level;
		}
		
		public function checkTask():Boolean
		{			
			for(var i:int = 0; i<Data.asset.length; i++)
			{
				if(Data.asset[i].ast_type == targetItem && Data.asset[i].ast_level == level)
				{
					return true;
				}
			}
			return false;
		}
		
	}
}