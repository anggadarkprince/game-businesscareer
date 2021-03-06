package sketchproject.managers
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.leebrimelow.starling.StarlingPool;

	import sketchproject.interfaces.IParticle;
	import sketchproject.objects.particle.HazeParticle;

	import starling.core.Starling;
	import starling.display.Sprite;

	/**
	 * Manage haze particle in asset loader.
	 *
	 * @author Angga
	 */
	public class HazeManager implements IParticle
	{
		private var hazeContainer:Sprite;
		private var hazePool:StarlingPool;
		private var haze:HazeParticle;
		private var hazes:Array;

		/**
		 * Default constructor of HazeManager.
		 *
		 * @param hazeContainer particle container
		 */
		public function HazeManager(hazeContainer:Sprite)
		{
			this.hazeContainer = hazeContainer;
			hazes = new Array();
			hazePool = new StarlingPool(HazeParticle, 80);
		}

		/**
		 * Generating and updating particle position,
		 * spawn random by range and loop through the hazes then check if single haze has been moving 30px,
		 * add little tween to destroy haze.
		 *
		 * @return void
		 */
		public function update():void
		{
			if (Math.random() < 0.2)
			{
				var xPos:Number = Math.random() * (Starling.current.nativeStage.stageWidth - 100) + 50;
				var yPos:Number = Math.random() * (Starling.current.nativeStage.stageHeight - 300) + 50;
				spawn(xPos, yPos);
			}

			for (var i:int = hazes.length - 1; i >= 0; i--)
			{
				haze = hazes[i] as HazeParticle;
				haze.y -= 0.5;
				if ((haze.startPositionHaze - haze.y) > 30)
				{
					TweenMax.to(
						haze, 
						1.5, 
						{
							scaleX: 0, 
							scaleY: 0.1, 
							alpha: 0.1, 
							ease: Elastic.easeOut, 
							onComplete: destroyHaze, 
							onCompleteParams: [haze]
						}
					);
				}
			}
		}

		/**
		 * Destroy single haze particle.
		 *
		 * @params haze particle to be destroyed when condition meets
		 * @return void
		 */
		private function destroyHaze(haze:HazeParticle):void
		{
			for (var i:int = 0; i < hazes.length; i++)
			{
				if (haze == hazes[i])
				{
					hazes.splice(i, 1);
					haze.removeFromParent(true);
					hazePool.returnSprite(haze);
				}
			}
		}

		/**
		 * Spawn new particle by given position, add little tween to show up the haze.
		 *
		 * @params x for particle x position start
		 * @params y for particle y position start
		 * @return void
		 */
		public function spawn(x:int, y:int):void
		{
			var haze:HazeParticle = hazePool.getSprite() as HazeParticle;
			hazes.push(haze);
			haze.x = x;
			haze.y = y;
			haze.startPositionHaze = haze.y;
			hazeContainer.addChild(haze);
			TweenMax.to(
				haze, 
				1.5, 
				{
					scaleX: 1, 
					scaleY: 1, 
					alpha: 1, 
					ease: Elastic.easeOut
				}
			);
		}

		/**
		 * Destroy object haze pooling.
		 *
		 * @return void
		 */
		public function destroy():void
		{
			hazePool.destroy();
			hazePool = null;
			hazes = null;
		}
	}
}
