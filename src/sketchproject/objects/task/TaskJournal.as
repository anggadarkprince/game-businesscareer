package sketchproject.objects.task
{

	/**
	 * Task journal plain object extend Task, add transaction type of journal.
	 * 
	 * @author Angga
	 */
	public class TaskJournal extends Task
	{
		private var transaction:String;

		/**
		 * Default constructor of TaskJournal.
		 * 
		 * @param type of task
		 * @param reward of task
		 * @param decription of task
		 * @param texture of task
		 */
		public function TaskJournal(type:String, reward:int, decription:String, texture:String)
		{
			super(type, reward, decription, texture);
		}

		/**
		 * Set type of journal transaction.
		 * 
		 * @param transaction
		 */
		public function set transactionType(transaction:String):void
		{
			this.transaction = transaction;
		}

		/**
		 * Get type of journal transaction.
		 * 
		 * @return
		 */
		public function get transactionType():String
		{
			return transaction;
		}

		/**
		 * Check task status if complete, but special condition for task journal,
		 * completion task just after player clicked the icon and do the task immediately.
		 * 
		 * @param status
		 * @return
		 */
		public function checkTask(status:Boolean):Boolean
		{
			if (status)
			{
				return true;
			}
			return false;
		}

	}
}
