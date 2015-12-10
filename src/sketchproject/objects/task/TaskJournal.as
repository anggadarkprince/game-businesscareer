package sketchproject.objects.task
{	
	public class TaskJournal extends Task
	{
		private var transaction:String;
		
		public function TaskJournal(type:String, reward:int, decription:String, texture:String)
		{
			super(type, reward, decription, texture);	
		}
							
		public function set transactionType(transaction:String):void
		{
			this.transaction = transaction;
		}
		
		public function get transactionType():String
		{
			return transaction;
		}
		
		public function checkTask(status:Boolean):Boolean
		{
			if(status){
				return true;
			}
			return false;
		}
		
	}
}