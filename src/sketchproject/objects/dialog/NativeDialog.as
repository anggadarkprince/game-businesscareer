package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.interfaces.IDialog;
	import sketchproject.managers.FireworkManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class NativeDialog extends Sprite implements IDialog
	{
		public static const DIALOG_QUESTION:String = "question";
		public static const DIALOG_INFORMATION:String = "information";
		
		private var overlay:Quad;
		private var dialogBase:Image;
		private var buttonPrimary:Button;
		private var buttonSecondary:Button;
		
		private var textTitle:TextField;
		private var textMessage:TextField;
		
		private var fireworkManager:FireworkManager;
		
		public function NativeDialog(type:String = DIALOG_INFORMATION, title:String = "No Title", message:String = "No Message")
		{
			super();
			
			fireworkManager = FireworkManager.getInstance(Game.overlayStage);
			
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			dialogBase = new Image(Assets.getAtlas(Assets.DIALOG, Assets.DIALOG_XML).getTexture("dialog_custom"));
			dialogBase.pivotX = dialogBase.width * 0.5;
			dialogBase.pivotY = dialogBase.height * 0.5;
			addChild(dialogBase);
			
			textTitle = new TextField(450,100,title, Assets.getFont(Assets.FONT_SSBOLD).fontName,30, 0xFFFFFF);
			textTitle.pivotX = textTitle.width * 0.5;
			textTitle.pivotY = textTitle.height * 0.5;
			textTitle.x = 0;
			textTitle.y = -100;			
			addChild(textTitle);
			
			textMessage = new TextField(420,100,message, Assets.getFont(Assets.FONT_SSBOLD).fontName,20, 0x222222);
			textMessage.pivotX = textMessage.width * 0.5;
			textMessage.pivotY = textMessage.height * 0.5;
			textMessage.x = 0;
			textMessage.y = -15;
			addChild(textMessage);
			
			buttonPrimary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_yes_flat"));
			buttonPrimary.pivotX = buttonPrimary.width * 0.5;
			buttonPrimary.pivotY = buttonPrimary.height * 0.5;
			buttonPrimary.x = -80;
			buttonPrimary.y = 60;
			addChild(buttonPrimary);
			
			if(type == NativeDialog.DIALOG_QUESTION){				
				buttonSecondary = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_no_flat"));
				buttonSecondary.pivotX = buttonSecondary.width * 0.5;
				buttonSecondary.pivotY = buttonSecondary.height * 0.5;
				buttonSecondary.x = 80;
				buttonSecondary.y = 60;
				addChild(buttonSecondary);
				
				buttonSecondary.addEventListener(Event.TRIGGERED, onSecondaryTrigerred);
			}
			else if(type == NativeDialog.DIALOG_INFORMATION){
				buttonPrimary.upState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok_flat");
				buttonPrimary.downState = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_ok_flat");
				buttonPrimary.x = 0;
			}
			
			
			buttonPrimary.addEventListener(Event.TRIGGERED, onPrimaryTrigerred);			
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}
		
		public function set dialogTitle(title:String):void{
			textTitle.text = title;
		}
		
		public function get dialogTitle():String{
			return textTitle.text;
		}
		
		public function set dialogMessage(message:String):void{
			textMessage.text = message;
		}
			
		public function get dialogMessage():String{
			return textMessage.text;
		}
		
		/**
		 * Secondary button event / [NO] Button
		 * @params $event passing triggered event
		 * @return void
		 */
		public function onSecondaryTrigerred(event:Event):void	{
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			dispatchEvent(new DialogBoxEvent(DialogBoxEvent.CLOSED, false));
		}
		
		/**
		 * Secondary button event / [YES]-[OK] Button
		 * @params $event passing triggered event
		 * @return void
		 */
		public function onPrimaryTrigerred(event:Event):void {
			fireworkManager.spawn(Game.cursor.x, Game.cursor.y);
			dispatchEvent(new DialogBoxEvent(DialogBoxEvent.CLOSED, true));
		}		
		
		/**
		 * Native dialog open transition
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
		 * Native dialog close transition
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
		
	}
}