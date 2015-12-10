package sketchproject.objects.particle
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	
	public class PaperParticle extends Sprite
	{
		private var paper:Image;
		private var speed:Number;
		private var flip:Number;
		private var wind:Number;
		private var colorCollection:Array = [0x00CCFF, 0xFF9900, 0xFFFF00, 0xFF0066, 0x990066, 0x99CC00, 0xFFFFFF];		
		
		/**
		 * Haze particle sprite contructor
		 */
		public function PaperParticle()
		{
			super();
			this.pivotX = this.width * 0.5;
			this.pivotY = this.height * 0.5;
			
			if(Math.random() < 0.5){
				this.rotation = deg2rad(180);
			}
						
			paper = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("particle_celebrate"));
			paper.pivotX = paper.width * 0.5;
			paper.pivotY = paper.height * 0.5;			
			paper.color = colorCollection[Math.ceil(Math.random()*colorCollection.length)];
			addChild(paper);
		}	
		
		public function set dropSpeed(speed:Number):void
		{
			this.speed = speed;
		}
		
		public function get dropSpeed():Number
		{
			return speed;
		}
		
		public function set flipDirection(flip:Number):void
		{
			this.flip = flip;
		}
		
		public function get flipDirection():Number
		{
			return flip;
		}
		
		public function set windSpeed(wind:Number):void
		{
			this.wind = wind;
		}
		
		public function get windSpeed():Number
		{
			return wind;
		}
	}
}