package sketchproject.objects.loading
{
	import sketchproject.core.Assets;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TransitionScreen extends Sprite {
		
		public static const SERVER_EXCLAMATION:uint = 0;
		public static const SERVER_PROGRESS:uint = 1;
		
		private var communicationType:uint;
	
		private var background:Image;
		
		private var mcExclamation:MovieClip;
		private var mcLoadingBar:MovieClip;
		
		private var textTitle:TextField;
		private var textSubtitle:TextField;
		
		private var title:String;
		private var sub:String;
		
		/**
		 * Server Checker constructor
		 */
		public function TransitionScreen(type:uint = 0, titleMessage:String = "Check", subMessage:String = "Loading") {
			super();
			communicationType = type;
			title = titleMessage;
			sub = subMessage;
			
			background = new Image(Assets.getAtlas(Assets.ADDITIONAL,Assets.ADDITIONAL_XML).getTexture("backdrop"));
			addChild(background);
			
			if(communicationType == SERVER_EXCLAMATION) {
				mcExclamation = new MovieClip(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTextures("exclamation_server"), 10);
				
				mcExclamation.pivotX = mcExclamation.width * 0.5;
				mcExclamation.x = this.width * 0.5;
				mcExclamation.y = 175;
				Starling.juggler.add(mcExclamation);	
				addChild(mcExclamation);
			}
			else if(communicationType == SERVER_PROGRESS) {
				mcLoadingBar = new MovieClip(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTextures("strip_loading"), 10);
				mcLoadingBar.pivotX = mcLoadingBar.width * 0.5;
				mcLoadingBar.x = this.width * 0.5;
				mcLoadingBar.y = 225;
				Starling.juggler.add(mcLoadingBar);
				addChild(mcLoadingBar);
			}
			
			textTitle = new TextField(300, 50, title, Assets.getFont(Assets.FONT_SSBOLD).fontName, 25, 0xE0DFDD, true);
			textTitle.pivotX = textTitle.width * 0.5;
			textTitle.x = this.width * 0.5;
			textTitle.y = 260;
			
			textSubtitle = new TextField(550, 100, sub, Assets.getFont(Assets.FONT_SSBOLD).fontName, 15, 0xbababa, true);
			textSubtitle.pivotX = textSubtitle.width * 0.5;
			textSubtitle.x = this.width * 0.5;
			textSubtitle.y = 270;
			
			addChild(textTitle);
			addChild(textSubtitle);		
		}
		
		/**
		 * Update screen info
		 * @params $titleMessages contain major information
		 * @Params $subMessage contain minor information
		 * @return void
		 */
		public function updateInfo(titleMessage:String = "Check", subMessage:String = "Loading"):void {
			textTitle.text = titleMessage;
			textSubtitle.text = subMessage
		}
		
		/**
		 * Destroy all data
		 * @return void
		 */
		public function destroy():void {
			title = null;
			sub = null;
			mcExclamation = null;
			mcLoadingBar = null;
			textTitle = null;
			textSubtitle = null;
			removeFromParent(true);
		}
		
	}
}