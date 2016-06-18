package sketchproject.objects.task
{

	/**
	 * Task order item plain object extend Task, add product type and total target.
	 * 
	 * @author Angga
	 */
	public class TaskOrder extends Task
	{
		private var product:int;
		private var quantity:int;

		/**
		 * Default constructor of TaskOrder.
		 * 
		 * @param type of task
		 * @param reward of task
		 * @param description of task
		 * @param texture of task
		 */
		public function TaskOrder(type:String, reward:int, description:String, texture:String)
		{
			super(type, reward, description, texture);
		}

		/**
		 * Set product type.
		 * 
		 * @param product
		 */
		public function set productTarget(product:int):void
		{
			this.product = product;
		}

		/**
		 * Get product type.
		 * 
		 * @return 
		 */
		public function get productTarget():int
		{
			return product;
		}

		/**
		 * Set product total.
		 * 
		 * @param quantity
		 */
		public function set quantityTarget(quantity:int):void
		{
			this.quantity = quantity;
		}

		/**
		 * Get product total.
		 * 
		 * @return 
		 */
		public function get quantityTarget():int
		{
			return quantity;
		}

		/**
		 * Check if task is achieved.
		 * 
		 * @param product
		 * @param quantity
		 * @return 
		 */
		public function checkTask(product:int, quantity:int):Boolean
		{
			if (this.product == product && quantity >= this.quantity)
			{
				return true;
			}
			return false;
		}
	}
}
