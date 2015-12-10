package sketchproject.objects.world
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class WorldMap extends Sprite
	{
		private var world:Image;
		
		public function WorldMap()
		{
			super();
			
			world = new Image(Assets.getTexture("GameWorld"));
			world.pivotX = world.width * 0.5;
			world.pivotY = world.height * 0.5;
			addChild(world);
			
			scaleX = 0.7;
			scaleY = 0.7;
		}
	}
}