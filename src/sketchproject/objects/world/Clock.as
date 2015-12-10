package sketchproject.objects.world
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	
	public class Clock extends Sprite
	{
		private var clockBase:Image;
		
		private var hourImage:Image;
		private var minuteImage:Image;
		private var secondImage:Image;
		
		private var cHours:int		= 24;
		private var cMinutes:int	= 0;
		private var cSeconds:int	= 0;
		
		public function Clock()
		{
			super();
			
			clockBase = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("clock_base"));
			clockBase.pivotX = clockBase.width * 0.5;
			clockBase.pivotY = clockBase.height * 0.5 + 2;
			addChild(clockBase);
			
			hourImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("clock_hour"));
			hourImage.pivotX = hourImage.width * 0.5;
			hourImage.pivotY = hourImage.height - 9;
			addChild(hourImage);
			
			minuteImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("clock_minute"));
			minuteImage.pivotX = minuteImage.width * 0.5;
			minuteImage.pivotY = minuteImage.height - 9;
			addChild(minuteImage);
			
			secondImage = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("clock_second"));
			secondImage.pivotX = secondImage.width * 0.5;
			secondImage.pivotY = secondImage.height - 3;
			addChild(secondImage);
		}
		
		public function update():void
		{
			this.cSeconds++;
			this.cMinutes += 2;
			
			if(this.cSeconds>=60){
				this.cSeconds = 0;
				//this.cMinutes++;
			}
			if(this.cMinutes>=60){
				this.cMinutes = 0;
				this.cHours++;
			}
			if(this.cHours>=24){
				this.cHours = 0;
			}
			
			updateClock();
		}
		
		public function updateClock():void
		{
			secondImage.rotation = deg2rad(6 * this.cSeconds); 
			minuteImage.rotation = deg2rad(6 * this.cMinutes + (this.cSeconds/10));
			hourImage.rotation = deg2rad(30 * this.cHours + this.cMinutes / 2);
		}
		
		public function set hour(cHour:int):void
		{
			cHours = cHour;
			updateClock();
		}
		
		public function get hour():int
		{
			return cHours;
		}
		
		public function set minute(cMinute:int):void
		{
			cMinutes = cMinute;
			updateClock();
		}
		
		public function get minute():int
		{
			return cMinutes;
		}
		
		public function set second(cSecond:int):void
		{
			cSecond = cSecond;
			updateClock();
		}
		
		public function get second():int
		{
			return cSeconds;
		}
	}
}