package sketchproject.objects.adapter
{
	import sketchproject.core.Assets;
	import sketchproject.objects.task.Task;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TaskAdapter extends Sprite
	{
		private var baseList:Image;
		private var iconList:Task;
		private var textTitle:TextField;
		private var textDescription:TextField;
		private var textPoint:TextField;
		private var textProgress:TextField;
		
		private var totalTask:int;
		
		private var task:Array;
		
		public function TaskAdapter(title:String, description:String, point:uint, total:uint)
		{
			super();
			
			baseList = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("task_list"));
			baseList.pivotX = baseList.width * 0.5;
			baseList.pivotY = baseList.height * 0.5;
			addChild(baseList);
			
			textTitle = new TextField(700,80,title, "Carter",38, 0x222222);;
			textTitle.x = 120;
			textTitle.y = 10;			
			addChild(textTitle);
			
			textDescription = new TextField(700,80,description, "Carter",25, 0x222222);
			textDescription.x = 120;
			textDescription.y = 10;			
			addChild(textDescription);
			
			textPoint = new TextField(700,80,point, "Carter",25, 0x222222);
			textPoint.pivotX = textTitle.width;
			textPoint.x = 120;
			textPoint.y = 10;			
			addChild(textPoint);
			
			textProgress = new TextField(700,80,title, "Carter",25, 0x222222);
			textProgress.pivotX = textTitle.width;
			textProgress.x = 120;
			textProgress.y = 10;			
			addChild(textProgress);
			
			
		}
	}
}