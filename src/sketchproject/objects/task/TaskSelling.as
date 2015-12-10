package sketchproject.objects.task
{
	public class TaskSelling extends Task
	{
		private var targetSelling:int;
		
		public function TaskSelling(type:String, reward:int, description:String, texture:String)
		{
			super(type, reward, description, texture);
		}
		
		public function set sellingTarget(target:int):void
		{
			this.targetSelling = target;
		}
		
		public function get sellingTarget():int
		{
			return targetSelling;
		}
		
		public function checkTask(sales:int):Boolean
		{
			if(sales >= targetSelling)
			{
				return true;
			}
			return false;
		}
	}
}