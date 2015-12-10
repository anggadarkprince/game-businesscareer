package sketchproject.objects.loading
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	
	import sketchproject.core.Assets;
	import sketchproject.managers.HazeParticleManager;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	
	public class AssetsLoader extends Sprite {
		
		public var DELAY_STARBRUST:uint = 3;
		public var DELAY_LOADING_PROGRESS:uint = 20;
		public var DELAY_LOADING_INFO:uint = 10;
		
		private var background:Image;
		private var starbrust:Image;
		private var screenCharLeft:Image;
		private var screenCharRight:Image;
		private var gameLogo:Image;
		
		private var hazeManager:HazeParticleManager;
		private var hazeContainer:Sprite;
		
		private var loadingProgress:Sprite;
		
		private var delayStarbrustRotation:uint;
		private var delayLoadingProgress:uint;
		private var delayLoadingInfo:uint;
		private var totalProgressBar:uint;
		
		private var assetsTypeText:TextField;
		private var assetsDetailText:TextField;
		
		private var progressBar:Quad;
		
		private var typeAssetsIndex:uint;
		private var detailAssetsIndex:uint;
		
		private var loadingType:Array;
		private var loadingData:Array;
		
		private var loaded:Boolean;
		private var closed:Boolean;
		
		
		/**
		 * Assets loader sprite contructor
		 */
		public function AssetsLoader() {
			super();
			
			background = new Image(Assets.getAtlas(Assets.BACKGROUND,Assets.BACKGROUND_XML).getTexture("loading_background"));
			addChild(background);
			
			starbrust = new Image(Assets.getAtlas(Assets.ADDITIONAL,Assets.ADDITIONAL_XML).getTexture("starbrust"));
			starbrust.pivotX = starbrust.width * 0.5;
			starbrust.pivotY = starbrust.height * 0.5;
			starbrust.alpha = 0;
			starbrust.scaleX = 0.3;
			starbrust.scaleY = 0.3;			
			starbrust.x = this.width * 0.5;
			starbrust.y = 150;
			addChild(starbrust);
			
			hazeContainer = new Sprite();
			addChild(hazeContainer);
			
			gameLogo = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("game_logo"));
			gameLogo.pivotX = gameLogo.width * 0.5;
			gameLogo.x = this.width * 0.5;
			gameLogo.y = 40;
			gameLogo.scaleX = 0.3;
			gameLogo.scaleY = 0.3;
			gameLogo.alpha = 0;
			addChild(gameLogo);
			
			screenCharLeft = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("screen_char_left"));
			screenCharLeft.pivotX = screenCharLeft.width * 0.5;
			screenCharLeft.x = 250;
			screenCharLeft.y = this.height + 20;
			screenCharLeft.scaleX = 0.7;
			screenCharLeft.scaleY = 0.7;
			addChild(screenCharLeft);
			
			screenCharRight = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("screen_char_right"));
			screenCharRight.pivotX = screenCharLeft.width * 0.5;
			screenCharRight.x = 740;
			screenCharRight.y = this.height + 20;
			screenCharRight.scaleX = 0.7;
			screenCharRight.scaleY = 0.7;
			addChild(screenCharRight);
			
			assetsTypeText = new TextField(
				200, 
				50, 
				"Loading Assets", 
				Assets.getFont("FontSSPBold").fontName, 
				25, 
				0x333333
			);
			assetsTypeText.x = this.width * 0.5 - assetsTypeText.width * 0.5;
			assetsTypeText.y = 420;
			addChild(assetsTypeText);
			
			assetsDetailText = new TextField(
				200, 
				50, 
				"Background Menu Loading", 
				Assets.getFont("FontSSPRegular").fontName, 
				15, 
				0x555555
			);
			assetsDetailText.x = this.width * 0.5 - assetsDetailText.width * 0.5;
			assetsDetailText.y = 450;
			addChild(assetsDetailText);
			
			loadingProgress = new Sprite();
			for(var i:uint=0; i<4;i++) {
				progressBar = new Quad(14,14,0x333333);	
				progressBar.x = i * (progressBar.width + 12);
				loadingProgress.addChild(progressBar);
			}			
			loadingProgress.pivotX = loadingProgress.width * 0.5;
			loadingProgress.x = this.width * 0.5;
			loadingProgress.y = 500;
			loadingProgress.alpha = 0;
			loadingProgress.scaleX = 0.3;
			loadingProgress.scaleY = 0.3;
			addChild(loadingProgress);
			
			delayStarbrustRotation = 0;
			delayLoadingProgress = 0;
			totalProgressBar = 0;
			
			typeAssetsIndex = 0;
			detailAssetsIndex = 0;
			
			loaded = false;
			closed = false;
			
			loadingType = ["Assets Loading", "Sounds Stream", "Script Data"];			
			loadingData = [
				["Background Menu Loading","City Isometric Loading"," Item List Loading", "UI Graphics Loading", "Preloading 100%", "Menu 100%", "Option 100%", "Head User Display 100%", "Map Navigation 100%"],
				["SFX Sounds Loading","Environment Ambient","BGM Sounds Loading", "Channel Mixer 100%", "Track Loader 100%", "Byte Ambient Decoder 100%"],
				["Prepare Menu Action", "Server Route Script", "Rule Based Game", "Pooling Object Script", "Blitting Image", "Particle Generator"]
			];
			
			hazeManager = new HazeParticleManager(hazeContainer);
		}
				
		/**
		 * Asset loader open transition
		 * @return void
		 */
		public function openTransition():void {			
			TweenMax.to(
				starbrust,
				0.3,
				{
					alpha:1, 
					scaleX:1, 
					scaleY:1
				}
			);
			
			TweenMax.to(
				gameLogo,
				0.5,
				{
					alpha:1, 
					scaleX:1, 
					scaleY:1, 
					ease:Elastic.easeOut, 
					delay:0.2
				}
			);
			
			TweenMax.to(
				screenCharLeft,
				0.5,
				{
					y:250, 
					scaleX:1, 
					scaleY:1, 
					ease:Elastic.easeOut, 
					delay:0.5
				}
			);
			
			TweenMax.to(
				screenCharRight,
				0.5,
				{
					y:250, 
					scaleX:1, 
					scaleY:1, 
					ease:Elastic.easeOut, 
					delay:1
				}
			);
			
			TweenMax.to(
				loadingProgress,
				0.5,
				{
					alpha:1,
					scaleX:1, 
					scaleY:1, 
					ease:Elastic.easeOut, 
					delay:0.5
				}
			);
			
		}
		
		/**
		 * Asset loader close transition
		 * @return void
		 */
		public function closeTransition():void {
			assetsTypeText.removeFromParent(true);
			assetsDetailText.removeFromParent(true);
			
			TweenMax.to(
				screenCharLeft,
				1,
				{
					x:0,
					y:this.height + 20, 
					scaleX:1, 
					scaleY:1, 
					ease:Bounce.easeOut, 
					delay:0.5
				}
			);
			
			TweenMax.to(
				screenCharRight,
				1,
				{
					x:850,
					y:this.height + 20, 
					scaleX:1, 
					scaleY:1, 
					ease:Bounce.easeOut, 
					delay:1,
					onComplete:function():void {
						isClosed = true;
					}
				}
			);
			
			TweenMax.to(
				gameLogo,
				1,
				{
					y:20,
					alpha:0, 
					scaleX:0.5, 
					scaleY:0.5, 
					ease:Back.easeIn, 
					delay:0.8
				}
			);
			
			TweenMax.to(
				loadingProgress,
				0.5,
				{
					alpha:0,
					scaleX:0.5, 
					scaleY:0.5, 
					ease:Back.easeIn,
					delay:0.3
				}
			);
			
			TweenMax.to(
				starbrust,
				0.3,
				{
					alpha:0, 
					scaleX:0.3, 
					scaleY:0.3,
					delay:1
				}
			);
			
			TweenMax.to(
				hazeContainer,
				0.5,
				{
					alpha:0,
					delay:0.8
				}
			);
		}
		
		
		/**
		 * Setter game assets is loading done
		 * @params $done status game asset loading has closed
		 * @return void
		 */
		public function set isLoaded(done:Boolean):void {
			this.loaded = done;
		}
		
		/**
		 * Getter game assets is loading done
		 * @return Boolean
		 */
		public function get isLoaded():Boolean {
			return loaded;
		}
		
		/**
		 * Setter game assets sprite is closed
		 * @params $close status game asset sprite has closed
		 * @return void
		 */
		public function set isClosed(close:Boolean):void {
			this.closed = close;
		}
		
		/**
		 * Getter game assets sprite is closed
		 * @return Boolean
		 */
		public function get isClosed():Boolean {
			return closed;
		}
		
		/**
		 * Update current loading
		 * @return void
		 */
		public function update():void {
			delayStarbrustRotation++;
			if(delayStarbrustRotation == DELAY_STARBRUST) {
				delayStarbrustRotation = 0;
				starbrust.rotation += deg2rad(1);
			}
			
			if(!isLoaded) {
				delayLoadingInfo++;		
				
				if(delayLoadingInfo == DELAY_LOADING_INFO) {
					delayLoadingInfo = 0;
					
					if(detailAssetsIndex == loadingData[typeAssetsIndex].length) {
						typeAssetsIndex++;
						detailAssetsIndex = 0;
					}
					
					assetsTypeText.text = loadingType[typeAssetsIndex];
					assetsDetailText.text = loadingData[typeAssetsIndex][detailAssetsIndex++];
					
					if(typeAssetsIndex == loadingType.length-1 && detailAssetsIndex == loadingData[loadingType.length-1].length) {						
						isLoaded = true;
						closeTransition();
					}
				}
				
				delayLoadingProgress++;
				if(delayLoadingProgress == DELAY_LOADING_PROGRESS) {
					if(totalProgressBar>0){
						loadingProgress.removeChildren(4, 4+totalProgressBar);
					}
					
					if(totalProgressBar == 4) {
						totalProgressBar = 0;
					}
					else {
						totalProgressBar++;
					}				
					
					for(var i:uint=0; i<totalProgressBar;i++) {
						var mark:Quad = new Quad(10,10,0x5599CC);
						mark.x = loadingProgress.getChildAt(i).x + 2; 
						mark.y = loadingProgress.getChildAt(i).y + 2;
						loadingProgress.addChild(mark);
					}	
					
					delayLoadingProgress = 0;
				}
				
				hazeManager.update();
			}			
		}
		
		/**
		 * Garbage collection destroy all compenent and reset varable
		 * @return void
		 */
		public function destroy():void
		{
			hazeManager.destroy();
			delayLoadingInfo = 0;
			delayLoadingProgress = 0;
			delayStarbrustRotation = 0;
			loadingType = null;
			loadingData =null;	
			loaded = false;
			closed = false;
		}
	}
}