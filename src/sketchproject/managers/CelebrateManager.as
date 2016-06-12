package sketchproject.managers
{
	import com.leebrimelow.starling.StarlingPool;

	import sketchproject.interfaces.IParticle;
	import sketchproject.objects.particle.PaperParticle;

	import starling.core.Starling;
	import starling.display.Sprite;

	public class CelebrateManager implements IParticle
	{

		private var celebrateContainer:Sprite;
		private var paperPool:StarlingPool;
		private var papers:Array;

		/**
		 * Celebrate manager contructor
		 */
		public function CelebrateManager(celebrateContainer:Sprite)
		{
			this.celebrateContainer = celebrateContainer;
			papers = new Array();
			paperPool = new StarlingPool(PaperParticle, 200);
		}

		/**
		 * Update particle movement
		 * @return void
		 */
		public function update():void
		{
			if (Math.random() < 0.3)
			{
				spawn(Math.random() * Starling.current.nativeStage.stageWidth, -50);
			}

			var paper:PaperParticle;
			for (var i:int = papers.length - 1; i > 0; i--)
			{
				paper = papers[i] as PaperParticle;
				paper.y += paper.dropSpeed;
				paper.x -= paper.windSpeed;

				if (paper.scaleX <= 0 || paper.scaleX >= 1)
				{
					paper.flipDirection = paper.flipDirection * -1;
				}
				paper.scaleX += paper.flipDirection;

				if (paper.y > Starling.current.nativeStage.stageHeight + 50)
				{
					destroyPaper(paper);
				}
			}
		}

		/**
		 * Destroy single paper particle
		 * @params $rain particle to be destroyed when condition meets
		 * @return void
		 */
		private function destroyPaper(paper:PaperParticle):void
		{
			for (var i:int = papers.length - 1; i >= 0; i--)
			{
				if (paper == papers[i])
				{
					papers.splice(i, 1);
					paper.removeFromParent(true);
					paperPool.returnSprite(paper);
				}
			}
		}

		/**
		 * Spawn new particle by position
		 * @params $x for particle x position start
		 * @params $y for particle y position start
		 * @return void
		 */
		public function spawn(x:int, y:int):void
		{
			var paper:PaperParticle = paperPool.getSprite() as PaperParticle;
			paper.dropSpeed = Math.random() * 1 + 3;
			paper.flipDirection = 0.04;
			paper.windSpeed = Math.random() * 2;
			paper.scaleX = (Math.random() * 2 + 8) / 10;
			paper.scaleY = (Math.random() * 2 + 8) / 10;
			paper.alpha = (Math.random() * 2 + 8) / 10
			papers.push(paper);
			paper.x = x;
			paper.y = y;
			celebrateContainer.addChild(paper);
		}

		/**
		 * Destroy object paper pooling
		 * @return void
		 */
		public function destroy():void
		{
			paperPool.destroy();
			paperPool = null;
			papers = null;
		}
	}
}
