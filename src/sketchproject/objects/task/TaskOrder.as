package sketchproject.objects.task
{
	public class TaskOrder extends Task
	{
		private var product:int;
		private var quantity:int;
		
		public function TaskOrder(type:String, reward:int, description:String, texture:String)
		{
			super(type, reward, description, texture);
		}
		
		public function set productTarget(product:int):void
		{
			this.product = product;
		}
		
		public function get productTarget():int
		{
			return product;
		}
		
		public function set quantityTarget(quantity:int):void
		{
			this.quantity = quantity;
		}
		
		public function get quantityTarget():int
		{
			return quantity;
		}
		
		public function checkTask(product:int, quantity:int):Boolean
		{
			if(this.product == product && quantity >= this.quantity){
				return true;
			}
			return false;
		}
		
	}
}