package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.geom.Rectangle;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.managers.FireworkManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class HelpDialog extends Sprite
	{
		private static var instance:HelpDialog;
		
		private var overlay:Quad;
		private var background:Image;
		private var menuHelp:Image;
		private var menuSelected:Image;
		
		private var buttonClose:Button;
		private var slider:Image;
		private var track:Image;
		private var contentMask:Quad;				
		private var content:Image;
		
		private var pageActive:uint;
		
		private var buttonHelpWelcome:Quad;
		private var buttonHelpSupply:Quad;
		private var buttonHelpAccounting:Quad;
		private var buttonHelpIssues:Quad;
		private var buttonHelpCompetitor:Quad;
		private var buttonHelpCustomer:Quad;
		private var buttonHelpCash:Quad;
		
		private var mask:Sprite;
		
		private var fireworkManager:FireworkManager;
		
		public function HelpDialog()
		{
			super();
			
			fireworkManager = new FireworkManager(Game.overlayStage);
			
			pageActive = 1;
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;		
			overlay.color = 0x000000;
			addChild(overlay);
			
			background = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_help"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_cross"));
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = background.width * 0.5 - 110;
			buttonClose.y = -background.height * 0.5 + 90;
			addChild(buttonClose);
			
			menuSelected = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("help_menu_selected"));
			menuSelected.x = -330;
			menuSelected.y = -119;
			addChild(menuSelected);
			
			menuHelp = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("help_menu"));
			menuHelp.x = -300;
			menuHelp.y = -100;
			addChild(menuHelp);
			
			track = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("help_slider_track"));
			track.pivotX = track.width * 0.5;
			track.x = 310;
			track.y = -100;
			addChild(track);
			
			slider = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("help_slider"));
			slider.pivotX = slider.width * 0.5;
			slider.pivotY = slider.height * 0.5;
			slider.x = 310;
			slider.y = -100 + (slider.height * 0.5);
			addChild(slider);
			
			contentMask = new Quad(380,300,0xFFFFFF);
			contentMask.x = -85;
			contentMask.y = -100;
			contentMask.alpha = 0;			
			addChild(contentMask);
			
			mask = new Sprite();
			addChild(mask);

			content = new Image(Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_welcome"));
			content.x = -75;
			content.y = -95;
			mask.addChild(content);
				
			mask.clipRect = new Rectangle(-85, -100, 380, 305);
			
			buttonHelpWelcome = new Quad(200, 40);
			buttonHelpWelcome.x = -320;
			buttonHelpWelcome.y = -109;
			buttonHelpWelcome.alpha = 0;
			addChild(buttonHelpWelcome);
			
			buttonHelpSupply = new Quad(200, 40);
			buttonHelpSupply.x = -320;
			buttonHelpSupply.y = buttonHelpWelcome.y + buttonHelpWelcome.height + 6;
			buttonHelpSupply.alpha = 0;
			addChild(buttonHelpSupply);
			
			buttonHelpAccounting = new Quad(200, 40);
			buttonHelpAccounting.x = -320;
			buttonHelpAccounting.y = buttonHelpSupply.y + buttonHelpSupply.height + 6;
			buttonHelpAccounting.alpha = 0;
			addChild(buttonHelpAccounting);
			
			buttonHelpIssues = new Quad(200, 40);
			buttonHelpIssues.x = -320;
			buttonHelpIssues.y = buttonHelpAccounting.y + buttonHelpAccounting.height + 6;
			buttonHelpIssues.alpha = 0;
			addChild(buttonHelpIssues);
			
			buttonHelpCompetitor = new Quad(200, 40);
			buttonHelpCompetitor.x = -320;
			buttonHelpCompetitor.y = buttonHelpIssues.y + buttonHelpIssues.height + 6;
			buttonHelpCompetitor.alpha = 0;
			addChild(buttonHelpCompetitor);
			
			buttonHelpCustomer = new Quad(200, 40);
			buttonHelpCustomer.x = -320;
			buttonHelpCustomer.y = buttonHelpCompetitor.y + buttonHelpCompetitor.height + 6;
			buttonHelpCustomer.alpha = 0;
			addChild(buttonHelpCustomer);
			
			buttonHelpCash = new Quad(200, 40);
			buttonHelpCash.x = -320;
			buttonHelpCash.y = buttonHelpCustomer.y + buttonHelpCustomer.height + 6;
			buttonHelpCash.alpha = 0;
			addChild(buttonHelpCash);
		
			addEventListener(TouchEvent.TOUCH, switchHelpPage);
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}
		
		/**
		 * Singeleton pattern
		 * @return instance of Help Dialog
		 */
		public static function getInstance():HelpDialog{
			if(instance == null){
				instance = new HelpDialog();
			}
			return instance;
		}
			
		/**
		 * Switch page and touch event
		 * @params $touch passing event touch
		 */
		private function switchHelpPage(touch:TouchEvent):void
		{				
			if (touch.getTouch(buttonHelpWelcome, TouchPhase.ENDED)) {
				TweenMax.to(menuSelected,0.3,{y:buttonHelpWelcome.y-10});
				pageActive = 1;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_welcome");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}	
			if (touch.getTouch(buttonHelpSupply, TouchPhase.ENDED))	{
				TweenMax.to(menuSelected,0.3,{y:buttonHelpSupply.y-10});
				pageActive = 2;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_supply");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonHelpAccounting, TouchPhase.ENDED))	{
				TweenMax.to(menuSelected,0.3,{y:buttonHelpAccounting.y-10});
				pageActive = 3;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_accounting");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonHelpIssues, TouchPhase.ENDED))	{
				TweenMax.to(menuSelected,0.3,{y:buttonHelpIssues.y-10});
				pageActive = 4;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_issues");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonHelpCompetitor, TouchPhase.ENDED))	{
				TweenMax.to(menuSelected,0.3,{y:buttonHelpCompetitor.y-10});
				pageActive = 5;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_competitor");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonHelpCustomer, TouchPhase.ENDED)) {
				TweenMax.to(menuSelected,0.3,{y:buttonHelpCustomer.y-10});
				pageActive = 6;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_customer");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonHelpCash, TouchPhase.ENDED)) {
				TweenMax.to(menuSelected,0.3,{y:buttonHelpCash.y-10});
				pageActive = 7;
				content.texture = Assets.getAtlas(Assets.HELP, Assets.HELP_XML).getTexture("help_cash");
				content.readjustSize();
				verifyHeight();
				Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			}
			
			
			if (touch.getTouch(slider, TouchPhase.MOVED)) {
				if(slider.y >= track.y + (slider.height * 0.5) && slider.y <= (track.y + track.height) - (slider.height * 0.5)){
					slider.y = touch.getTouch(this).getLocation(this).y;
				}
				if(slider.y < track.y + (slider.height * 0.5)) {
					slider.y = track.y + (slider.height * 0.5);
				}
				if(slider.y > track.y + track.height - (slider.height * 0.5)) {
					slider.y = track.y + track.height - (slider.height * 0.5);
				}
				updateContentPosition();
			}
			
			if (touch.getTouch(buttonClose, TouchPhase.ENDED)) {
				fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
				closeDialog();
			}
		}
		
		/**
		 * Open dialog transition
		 * @return void
		 */
		public function openDialog():void
		{			
			Assets.sfxChannel = Assets.sfxCoin.play(0,0,Assets.sfxTransform);
			visible = true;
			TweenMax.to(
				this,
				0.7,
				{
					ease:Back.easeOut,
					scaleX:1,
					scaleY:1,
					alpha:1,
					delay:0.2
				}
			);	
		}
		
		/**
		 * Close dialog transition
		 * @return void
		 */
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxSwitch.play(0,0,Assets.sfxTransform);
			TweenMax.to(
				this,
				0.5,
				{
					ease:Back.easeIn,
					scaleX:0.5,
					scaleY:0.5,
					alpha:0,
					delay:0.2,
					onComplete:function():void{
						visible = false;
					}
				}
			);
		}
				
		/**
		 * Update content position
		 * @return void
		 */
		private function updateContentPosition():void {
			var scrollPercent:Number =  100 / (track.height - slider.height)  * (slider.y - track.y - (slider.height * 0.5));
			var newContentY:Number = contentMask.y + (contentMask.height - content.height) / 100 * scrollPercent;
			content.y = newContentY;
		}
		
		/**
		 * Check if scrollbar is necessary
		 * @return void
		 */
		private function verifyHeight():void {
			content.y = -100;
			slider.y = -100 + (slider.height * 0.5);
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			if (contentMask.height >= content.height) {
				slider.visible = false;
				track.visible = false;
			}
			else {
				slider.visible = true;
				track.visible = true;
			}
		}
		
	}
}