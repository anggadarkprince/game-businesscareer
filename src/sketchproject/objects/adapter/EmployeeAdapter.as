package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	/**
	 * Handle single employee data and avatar.
	 *
	 * @author Angga
	 */
	public class EmployeeAdapter extends Sprite
	{
		private var empIndex:int;
		private var empId:int;
		private var employeeName:TextField;

		/**
		 * Default constructor of EmployeeAdapter.
		 *
		 * @param index
		 * @param id
		 * @param name
		 */
		public function EmployeeAdapter(index:int, id:int, name:String)
		{
			this.empIndex = index;
			this.empId = id;
			employeeName = new TextField(200, 50, name, Assets.getFont(Assets.FONT_CORegular).fontName, 13, 0x333333);
			employeeName.hAlign = HAlign.LEFT;
			addChild(employeeName);
		}

		/**
		 * Set employee index.
		 *
		 * @param index
		 */
		public function set employeeIndex(index:int):void
		{
			this.empIndex = index;
		}

		/**
		 * Get employee index.
		 *
		 * @return
		 */
		public function get employeeIndex():int
		{
			return empIndex;
		}

		/**
		 * Set employee id.
		 *
		 * @param id
		 */
		public function set employeeId(id:int):void
		{
			this.empId = id;
		}

		/**
		 * Get employee id.
		 *
		 * @return
		 */
		public function get employeeId():int
		{
			return empId;
		}

		/**
		 * Offering salary to this employee.
		 *
		 * @param sallary which offered.
		 * @return status this employee accept the offer or not
		 */
		public function offer(salary:int):Boolean
		{
			var minimum:int = int(Config.candidate[empIndex].emp_salary_goal);
			var over:int = (10 / 100) * minimum;
			var target:int = minimum + over + (Math.random() * over);
			if (salary >= target)
			{
				return true;
			}
			return false;
		}

		/**
		 * Dismiss the employee.
		 *
		 * @return
		 */
		public function dismiss():Boolean
		{
			Data.employee[employeeIndex][16] = "dismiss";
			return true;
		}

		/**
		 * Train the employee level.
		 *
		 * @return
		 */
		public function train():Boolean
		{
			if (Math.random() < 0.5)
			{
				Data.employee[employeeIndex][15]++;
				return true;
			}
			return false;
		}
	}
}
