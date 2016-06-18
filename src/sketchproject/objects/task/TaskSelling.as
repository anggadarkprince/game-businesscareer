package sketchproject.objects.task
{

	/**
	 * Task sold item plain object extend Task, add selling target.
	 * 
	 * @author Angga
	 */
	public class TaskSelling extends Task
	{
		private var targetSelling:int;

		/**
		 * Default constructor of TaskSelling.
		 * 
		 * @param type
		 * @param reward
		 * @param description
		 * @param texture
		 */
		public function TaskSelling(type:String, reward:int, description:String, texture:String)
		{
			super(type, reward, description, texture);
		}

		/**
		 * Set selling target total.
		 * 
		 * @param target
		 */
		public function set sellingTarget(target:int):void
		{
			this.targetSelling = target;
		}

		/**
		 * Get selling target.
		 * 
		 * @return target
		 */
		public function get sellingTarget():int
		{
			return targetSelling;
		}

		/**
		 * Check if target selling is achieved.
		 * 
		 * @param sales total
		 * @return
		 */
		public function checkTask(sales:int):Boolean
		{
			if (sales >= targetSelling)
			{
				return true;
			}
			return false;
		}
	}
}
