package sketchproject.objects.particle
{
	import sketchproject.core.Assets;
		
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class HazeParticle extends Sprite
	{
		private var haze:Image;
		private var position:Number;
		
		/**
		 * Haze particle sprite contructor
		 */
		public function HazeParticle()
		{
			super();
			this.pivotX = this.width * 0.5;
			this.pivotY = this.height * 0.5;
			this.alpha = 0;
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			
			haze = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("haze"));
			haze.pivotX = haze.width * 0.5;
			haze.pivotY = haze.height * 0.5;
			addChild(haze);
		}
		
		/**
		 * Setter haze y position
		 * @params $percent game loading precentage
		 * @return void
		 */
		public function set startPositionHaze(posY:Number):void	{
			this.position = posY;
		}
		
		/**
		 * Getter haze y position
		 * @return Number y position
		 */
		public function get startPositionHaze():Number {
			return this.position;
		}
	}
}