package sketchproject.objects.business
{
	import feathers.controls.PickerList;
	import feathers.data.ListCollection;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.events.DialogBoxEvent;
	import sketchproject.objects.world.Avatar;
	import sketchproject.objects.world.MobileCart;
	import sketchproject.objects.dialog.NativeDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class ShopFrame extends Sprite
	{
		private var label:TextField;
		private var points:TextField;
		private var rank:TextField;
		private var starContainer:Sprite;
		
		private var image:Image;
		private var buttonMood:Button;
		private var buttonOpenShop:Button;
		private var buttonCharacterCustom:Button;
		private var avatar:Avatar;
		private var cart:MobileCart;
		private var listLocation:PickerList;
		
		private var decorationWrapper:Sprite;
		private var scentWrapper:Sprite;
		private var cleanessWrapper:Sprite;
		private var popularityWrapper:Sprite;
		private var boosterWrapper:Sprite;	
		
		private var star:Image;
		private var attributeLevel:Quad;
		
		private var decorationLevel:int;
		private var scentLevel:int;
		private var cleanessLevel:int;
		private var popularityLevel:int;
		private var boosterLevel:int
		private var confirmDialog:NativeDialog;
		private var indexLocation:int;
		private var cancelAction:Boolean;
		
		public function ShopFrame()
		{
			super();
			
			new MetalWorksDesktopTheme();
			
			cancelAction = false;
			for(var i:int = 0; i<Config.district.length;i++)
			{
				if(Data.district == Config.district[i][1].toString())
				{
					indexLocation = i;
				}				
			}
			
			cart = new MobileCart();
			cart.x = -435;
			cart.y = -190;
			cart.scaleX = 1.1;
			cart.scaleY = 1.1;
			cart.stopAdvisorSignal();
			addChild(cart);
			
			label = new TextField(250, 50, "Management Team and Profit", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -180;
			label.y = -185;
			addChild(label);
			
			label = new TextField(265, 200, "Your goal is to generate as much profit as posible. the market isestabilished, your focus will be on winning market share from competitor", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -180;
			label.y = -160;
			addChild(label);
			
			label = new TextField(250, 50, "Achievement", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -180;
			label.y = -80;
			addChild(label);
			
			starContainer = new Sprite();
			starContainer.pivotX = starContainer.width;
			starContainer.pivotY = starContainer.height * 0.5;
			starContainer.x = -45;
			starContainer.y = -78;
			starContainer.scaleX = 0.9;
			starContainer.scaleY = 0.9;
			addChild(starContainer);
			
			label = new TextField(250, 50, "Points", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -180;
			label.y = -50;
			addChild(label);
			
			points = new TextField(250, 50, ValueFormatter.format(Data.point)+" PTS", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			points.vAlign = VAlign.TOP;
			points.hAlign = HAlign.RIGHT;
			points.x = -180;
			points.y = -50;
			addChild(points);
			
			label = new TextField(250, 50, "World Rank", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -180;
			label.y = -20;
			addChild(label);
			
			rank = new TextField(250, 50, "#"+Data.worldRank+" World", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			rank.vAlign = VAlign.TOP;
			rank.hAlign = HAlign.RIGHT;
			rank.x = -180;
			rank.y = -20;
			addChild(rank);
			
			label = new TextField(250, 50, "Location", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = -180;
			label.y = 30;
			addChild(label);
			
			listLocation = new PickerList();
			listLocation.dataProvider = new ListCollection(Config.location);
			listLocation.listProperties.@itemRendererProperties.labelField = "text";
			listLocation.labelField = "text";
			listLocation.width = 250;
			listLocation.height = 30;
			listLocation.x = -180;
			listLocation.y = 60;
			listLocation.selectedIndex = indexLocation;
			listLocation.addEventListener(Event.CHANGE, onlocationChanged);
			addChild(listLocation);
			
			label = new TextField(250, 50, "Shop", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 115;
			label.y = -185;
			addChild(label);
			
			label = new TextField(250, 50, "Decoration", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.x = 115;
			label.y = -155;
			addChild(label);
			
			decorationWrapper = new Sprite();
			decorationWrapper.x = 120;
			decorationWrapper.y = -115;
			addChild(decorationWrapper);
			
			label = new TextField(250, 50, "Scent", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.x = 115;
			label.y = -110;
			addChild(label);
			
			scentWrapper = new Sprite();
			scentWrapper.x = 120;
			scentWrapper.y = -70;
			addChild(scentWrapper);
			
			label = new TextField(250, 50, "Cleaness", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.x = 115;
			label.y = -65;
			addChild(label);
			
			cleanessWrapper = new Sprite();
			cleanessWrapper.x = 120;
			cleanessWrapper.y = -25;
			addChild(cleanessWrapper);
			
			label = new TextField(250, 50, "Popularity", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.x = 115;
			label.y = -20;
			addChild(label);
			
			popularityWrapper = new Sprite();
			popularityWrapper.x = 120;
			popularityWrapper.y = 20;
			addChild(popularityWrapper);
			
			label = new TextField(250, 50, "Booster", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.x = 115;
			label.y = 25;
			addChild(label);
			
			boosterWrapper = new Sprite();
			boosterWrapper.x = 120;
			boosterWrapper.y = 65;
			addChild(boosterWrapper);
			
			label = new TextField(250, 50, "Your Avatar", Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 250;
			label.y = -185;
			addChild(label);
			
			buttonMood = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("tile_player_mood"));
			buttonMood.pivotX = buttonMood.width * 0.5;
			buttonMood.pivotY = buttonMood.height * 0.5;
			buttonMood.x = 370;
			buttonMood.y = -85;
			addChild(buttonMood);
			
			buttonCharacterCustom = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("tile_customize_avatar"));
			buttonCharacterCustom.pivotX = buttonCharacterCustom.width * 0.5;
			buttonCharacterCustom.pivotY = buttonCharacterCustom.height * 0.5;
			buttonCharacterCustom.x = 405;
			buttonCharacterCustom.y = -29;
			addChild(buttonCharacterCustom);
			
			buttonOpenShop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("tile_open_market"));
			buttonOpenShop.pivotX = buttonOpenShop.width * 0.5;
			buttonOpenShop.pivotY = buttonOpenShop.height * 0.5;
			buttonOpenShop.x = 370;
			buttonOpenShop.y = 25;
			addChild(buttonOpenShop);

			avatar = new Avatar();
			avatar.x = 265;
			avatar.y = -120;
			avatar.scaleX = 0.85;
			avatar.scaleY = 0.85;
			addChild(avatar);
			
			confirmDialog = new NativeDialog(NativeDialog.DIALOG_QUESTION);
			confirmDialog.addEventListener(DialogBoxEvent.CLOSED, onChangeConfirmed);
			addChild(confirmDialog);
			
			updateStatus();
		}
		
		private function onChangeConfirmed(event:DialogBoxEvent):void
		{
			if(event.result)
			{
				var dialog:PostDialog = new PostDialog("Move",int(Config.district[listLocation.selectedIndex][7]),false);
				dialog.x = stage.stageWidth * 0.5;
				dialog.y = stage.stageHeight * 0.5;
				Game.overlayStage.addChild(dialog);
				dialog.addEventListener(PostDialog.POSTING, function(event:Event):void{
					indexLocation = listLocation.selectedIndex;		
					Data.district = listLocation.selectedItem.text;
				});			
				dialog.openDialog();
			}
			else
			{
				cancelAction = true;
				listLocation.selectedIndex = indexLocation;					
				cancelAction = false;
			}
			confirmDialog.closeDialog();
			
		}
		
		private function onlocationChanged(event:Event):void
		{
			if(!cancelAction)
			{
				confirmDialog.dialogTitle = "Change Location";
				confirmDialog.dialogMessage = "Do you want to change "+Config.district[listLocation.selectedIndex][1]+" for "+Config.district[listLocation.selectedIndex][7]+"?";
				confirmDialog.openDialog();
			}			
		}
		
		public function updateStatus():void
		{
			avatar.updateAvatar();
			cart.update();
			
			decorationLevel = Math.ceil((Data.decoration[0] + Data.decoration[1] + Data.decoration[2]) * 5 / 30);
			scentLevel = Math.ceil((Data.scent[0] + Data.scent[1] + Data.scent[2]) * 5 / 30);
			cleanessLevel = Math.ceil((Data.cleanness[0] + Data.cleanness[1]) * 5 / 20);
			popularityLevel = Math.ceil((decorationLevel + scentLevel + cleanessLevel) * 5 / 15);
			boosterLevel = Math.ceil((Data.booster[0] + Data.booster[1] + Data.booster[2] + Data.booster[3]) * 5 / 20);
			
			decorationWrapper.removeChildren();
			scentWrapper.removeChildren();
			cleanessWrapper.removeChildren();
			popularityWrapper.removeChildren();
			boosterWrapper.removeChildren();
			starContainer.removeChildren();
			
			rank.text = "#"+Data.worldRank+" World";
			
			for(var i:uint = 0 ;i<5; i++)
			{
				if(i<Data.stars){
					star = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_orange"));					
				}
				else {
					star = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("star_dark"));
				}
				star.x = (i * (star.width + 4));
				starContainer.addChild(star);		
				
				
				if(i<decorationLevel){
					attributeLevel = new Quad(10,10,0xfb7477);					
				}
				else{
					attributeLevel = new Quad(10,10,0xc9cdc8);
				}
				attributeLevel.x = (i * (attributeLevel.width + 5));
				decorationWrapper.addChild(attributeLevel);
				
				if(i<scentLevel){
					attributeLevel = new Quad(10,10,0x0097fe);					
				}
				else{
					attributeLevel = new Quad(10,10,0xc9cdc8);
				}
				attributeLevel.x = (i * (attributeLevel.width + 5));
				scentWrapper.addChild(attributeLevel);
				
				if(i<cleanessLevel){
					attributeLevel = new Quad(10,10,0xf59b0b);					
				}
				else{
					attributeLevel = new Quad(10,10,0xc9cdc8);
				}
				attributeLevel.x = (i * (attributeLevel.width + 5));
				cleanessWrapper.addChild(attributeLevel);
				
				if(i<popularityLevel){
					attributeLevel = new Quad(10,10,0xa100a5);					
				}
				else{
					attributeLevel = new Quad(10,10,0xc9cdc8);
				}
				attributeLevel.x = (i * (attributeLevel.width + 5));
				popularityWrapper.addChild(attributeLevel);
				
				if(i<boosterLevel){
					attributeLevel = new Quad(10,10,0x9ccd00);					
				}
				else{
					attributeLevel = new Quad(10,10,0xc9cdc8);
				}
				attributeLevel.x = (i * (attributeLevel.width + 5));
				boosterWrapper.addChild(attributeLevel);
			}
			
		}
	}
}