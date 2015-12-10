package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.utilities.GameUtils;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class EmployeeAdapter extends Sprite
	{
		private var empIndex:int;
		private var empId:int;
		private var employeeName:TextField;
		
		public function EmployeeAdapter(index:int, id:int, name:String)
		{
			this.empIndex = index;
			this.empId = id;
			employeeName = new TextField(200, 50, name, Assets.getFont(Assets.FONT_CORegular).fontName, 13, 0x333333);
			employeeName.hAlign = HAlign.LEFT;
			addChild(employeeName);
		}
		
		public function set employeeIndex(index:int):void{
			this.empIndex = index;
		}
		
		public function get employeeIndex():int{
			return empIndex;
		}
		
		public function set employeeId(id:int):void{
			this.empId = id;
		}
		
		public function get employeeId():int{
			return empId;
		}
		
		public function offer(sallary:int):Boolean{
			var minimum:int = int(Config.candidate[empIndex].emp_salary_goal);
			var over:int = (10/100) * minimum;
			var target:int = minimum + over + (Math.random() * over);
			if(sallary >= target){				
				return true;
			}
			return false;			
		}
				
		public function dismiss():Boolean{			
			Data.employee[employeeIndex][16] = "dismiss";
			return true;
		}
		
		public function train():Boolean{
			if(Math.random() < 0.5){
				Data.employee[employeeIndex][15]++;
				return true;
			}
			return false;			
		}
	}
}