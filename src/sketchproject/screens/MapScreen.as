package sketchproject.screens
{
	import flash.geom.Point;
	
	import sketchproject.core.Config;
	import sketchproject.managers.RainManager;
	import sketchproject.objects.particle.RainParticle;
	import sketchproject.objects.world.Map;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MapScreen extends GameScreen
	{
		private var rainManager:RainManager;
		private var rainContainer:Sprite;
		private var isRaining:Boolean;
		private var world:Map;
		
		private var _startXPos:int = 0;
		private var _startYPos:int = 0;
		private var currentXPos:int = 0;
		private var currentYPos:int = 0;
		private var newXPos:int = 0;
		private var newYPos:int = 0;
		
		private var minX:int = 0;
		private var maxX:int = 0;
		private var minY:int = 0;
		private var maxY:int = 0;
		
		private var globalPosition:Point = new Point();
		
		public function MapScreen()
		{
			super();			
			super.hideBase();
			
			world = new Map(false);
			world.scaleX = 0.9;
			world.scaleY = 0.9;
			world.x = -100;
			world.y = -550;
			addChild(world);
			
			if(Math.random() < 0.5)
			{
				isRaining = true;
			}
			else{
				isRaining = false;
			}
			
			if(isRaining){
				rainContainer = new Sprite();
				rainContainer.x = -Starling.current.stage.stageWidth * 0.5;
				rainContainer.y = -Starling.current.stage.stageHeight * 0.5;
				addChild(rainContainer);
				
				rainManager = new RainManager(rainContainer, RainParticle.HEAVY_RAIN);
			}
			
			resetPosition();
			
			world.addEventListener(TouchEvent.TOUCH, onWorldTouched);
		}
		
		public function resetPosition():void
		{			
			// set limits for target x width 2750 height 1404.15
			minX = (-Math.round((2750-250) - Starling.current.stage.stageWidth)/2) * Config.zoom;
			maxX = (Math.round((2750-150) - Starling.current.stage.stageWidth)/2)* Config.zoom; 
			
			// set limits for target y
			minY = -(1404.15-(Starling.current.stage.stageHeight/2)) * Config.zoom;  
			maxY = -(Starling.current.stage.stageHeight/2) * Config.zoom;
			
			trace("[ZOOM] reset map position");
		}		
		
		private function onWorldTouched(e:TouchEvent):void
		{	
			var touch:Touch = e.getTouch(stage);
			var target:DisplayObject = e.currentTarget as DisplayObject;
						
			if (touch == null)
			{
				return;
			}
			
			var position:Point = touch.getLocation(stage);
			
			if (touch.phase == TouchPhase.BEGAN )
			{
				// store start of drag x pos
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;
				
				_startXPos = target.globalToLocal(globalPosition).x;
				_startYPos = target.globalToLocal(globalPosition).y;
			}
			else if (touch.phase == TouchPhase.MOVED )
			{								
				// calculate new x based on touch's global coordinates
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;
				
				currentXPos = target.globalToLocal(globalPosition).x;
				currentYPos = target.globalToLocal(globalPosition).y;
				
				newXPos = target.x + currentXPos - _startXPos;
				newYPos = target.y + currentYPos - _startYPos;
				
				if (newXPos <= maxX && newXPos >= minX) // set target's x if it falls within limits
					target.x=newXPos;
				
				if (newYPos <= maxY && newYPos >= minY) // set target's y if it falls within limits
					target.y=newYPos;
			}
			
			return;
		}
		
		public function update():void
		{
			if(isRaining)
			{
				rainManager.update();
			}			
			world.update(12,0);
		}
		
		public function destroy():void
		{
			if(isRaining)
			{
				rainManager.destroy();
			}			
		}
		
	}
}