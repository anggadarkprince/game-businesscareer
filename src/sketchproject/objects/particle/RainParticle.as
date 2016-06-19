package sketchproject.objects.particle
{
	import sketchproject.core.Assets;

	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * Single rain drop and particle.
	 *
	 * @author Angga
	 */
	public class RainParticle extends Sprite
	{
		public static var LIGHT_RAIN:String = "lightRain";
		public static var HEAVY_RAIN:String = "heavyRain";
		public static var STORM_RAIN:String = "stormRain";

		private var rain:Image;
		private var speed:Number;
		private var wind:Number;
		private var yDest:Number;
		private var type:String;

		/**
		 * Default constructor of RainParticle.
		 */
		public function RainParticle()
		{
			super();

			rain = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_rain"));
			rain.pivotX = rain.width * 0.5;
			rain.pivotY = rain.height * 0.5;
			addChild(rain);
		}

		/**
		 * Set rain type if light, heavy or storm.
		 *
		 * @param type
		 */
		public function set rainType(type:String):void
		{
			this.type = type;
			if (type == RainParticle.LIGHT_RAIN)
			{
				rain.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_rain");
			}
			else if (type == RainParticle.HEAVY_RAIN)
			{
				rain.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_heavy_rain");
			}
			else
			{
				rain.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_storm");
			}
			rain.readjustSize();
		}

		/**
		 * Get type of rain.
		 *
		 * @return
		 */
		public function get rainType():String
		{
			return this.type;
		}

		/**
		 * Set rain drop speed.
		 *
		 * @param speed
		 */
		public function set dropSpeed(speed:Number):void
		{
			this.speed = speed;
		}

		/**
		 * Get rain drop speed.
		 *
		 * @return
		 */
		public function get dropSpeed():Number
		{
			return speed;
		}

		/**
		 * Set wind affect the rain dropping.
		 *
		 * @param wind
		 */
		public function set windSpeed(wind:Number):void
		{
			this.wind = wind;
		}

		/**
		 * Set wind affect the rain dropping.
		 *
		 * @return
		 */
		public function get windSpeed():Number
		{
			return wind;
		}

		/**
		 * Set y drop destination.
		 *
		 * @param yPos
		 */
		public function set dropPosition(yPos:Number):void
		{
			this.yDest = yPos;
		}

		/**
		 * Get y drop destination.
		 *
		 * @return
		 */
		public function get dropPosition():Number
		{
			return yDest;
		}
	}
}
