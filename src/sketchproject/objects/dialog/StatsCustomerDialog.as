package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.utilities.GameUtils;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class StatsCustomerDialog extends DialogOverlay
	{
		private var background:Image;
		private var buttonRandom:Button;
		private var buttonClose:Button;
		private var role:TextField;
		private var state:TextField;
		private var position:TextField;
		private var choice:TextField;
		private var emotion:TextField;
		private var education:TextField;
		private var athletic:TextField;
		private var art:TextField;
		private var consumption:TextField;
		private var district:TextField;
		private var priceSensitivity:TextField;
		private var priceThreshold:TextField;
		private var qualitySensitivity:TextField;
		private var qualityThreshold:TextField;
		private var acceptance:TextField;
		private var rejection:TextField;
		private var tv:TextField;
		private var radio:TextField;
		private var newspaper:TextField;
		private var internet:TextField;
		private var event:TextField;
		private var billboard:TextField;
		private var food1:TextField;
		private var food2:TextField;
		private var food3:TextField;
		private var drink1:TextField;
		private var drink2:TextField;
		
		private var npc:Agent;
		
		public function StatsCustomerDialog(destroyable:Boolean = false)
		{
			super(destroyable);
			
			background = new Image(Assets.getAtlas(Assets.ADDITIONAL, Assets.ADDITIONAL_XML).getTexture("customer_view_panel"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			role = new TextField(200, 50, "Student", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			role.hAlign = HAlign.LEFT;
			role.vAlign = VAlign.TOP;
			role.x = -29.75;
			role.y = -119.45;
			addChild(role);
			
			state = new TextField(200, 50, "Walking", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			state.hAlign = HAlign.LEFT;
			state.vAlign = VAlign.TOP;
			state.x = -29.75;
			state.y = -99.45;
			addChild(state);
			
			position = new TextField(200, 50, "[4,3]", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			position.hAlign = HAlign.LEFT;
			position.vAlign = VAlign.TOP;
			position.x = -29.75;
			position.y = -79.45;
			addChild(position);
			
			choice = new TextField(200, 50, "Food 1 [Competitor]", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			choice.hAlign = HAlign.LEFT;
			choice.vAlign = VAlign.TOP;
			choice.x = -29.75;
			choice.y = -59.45;
			addChild(choice);
			
			emotion = new TextField(200, 50, "Happy", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			emotion.hAlign = HAlign.LEFT;
			emotion.vAlign = VAlign.TOP;
			emotion.x = -29.75;
			emotion.y = -39.45;
			addChild(emotion);
			
			education = new TextField(200, 50, "2", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			education.hAlign = HAlign.LEFT;
			education.vAlign = VAlign.TOP;
			education.x = 220.4;
			education.y = -119.45;
			addChild(education);
			
			athletic = new TextField(200, 50, "4", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			athletic.hAlign = HAlign.LEFT;
			athletic.vAlign = VAlign.TOP;
			athletic.x = 220.4;
			athletic.y = -99.45;
			addChild(athletic);
			
			art = new TextField(200, 50, "5", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			art.hAlign = HAlign.LEFT;
			art.vAlign = VAlign.TOP;
			art.x = 220.4;
			art.y = -79.45;
			addChild(art);
			
			consumption = new TextField(200, 50, "3X/Day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			consumption.hAlign = HAlign.LEFT;
			consumption.vAlign = VAlign.TOP;
			consumption.x = 220.4;
			consumption.y = -59.45;
			addChild(consumption);
			
			district = new TextField(200, 50, "Murbawisma", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			district.hAlign = HAlign.LEFT;
			district.vAlign = VAlign.TOP;
			district.x = 220.4;
			district.y = -39.45;
			addChild(district);
			
			priceSensitivity = new TextField(200, 50, "4", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			priceSensitivity.hAlign = HAlign.LEFT;
			priceSensitivity.vAlign = VAlign.TOP;
			priceSensitivity.x = -163.9;
			priceSensitivity.y = 38.35;
			addChild(priceSensitivity);
			
			priceThreshold = new TextField(200, 50, "6", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			priceThreshold.hAlign = HAlign.LEFT;
			priceThreshold.vAlign = VAlign.TOP;
			priceThreshold.x = -163.9;
			priceThreshold.y = 58.35;
			addChild(priceThreshold);
			
			qualitySensitivity = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			qualitySensitivity.hAlign = HAlign.LEFT;
			qualitySensitivity.vAlign = VAlign.TOP;
			qualitySensitivity.x = -163.9;
			qualitySensitivity.y = 78.35;
			addChild(qualitySensitivity);
			
			qualityThreshold = new TextField(200, 50, "2", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			qualityThreshold.hAlign = HAlign.LEFT;
			qualityThreshold.vAlign = VAlign.TOP;
			qualityThreshold.x = -163.9;
			qualityThreshold.y = 98.35;
			addChild(qualityThreshold);
			
			acceptance = new TextField(200, 50, "4", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			acceptance.hAlign = HAlign.LEFT;
			acceptance.vAlign = VAlign.TOP;
			acceptance.x = -163.9;
			acceptance.y = 118.7;
			addChild(acceptance);

			rejection = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			rejection.hAlign = HAlign.LEFT;
			rejection.vAlign = VAlign.TOP;
			rejection.x = -163.9;
			rejection.y = 138.7;
			addChild(rejection);
			
			tv = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			tv.hAlign = HAlign.LEFT;
			tv.vAlign = VAlign.TOP;
			tv.x = 24.85;
			tv.y = 38.35;
			addChild(tv);
			
			radio = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			radio.hAlign = HAlign.LEFT;
			radio.vAlign = VAlign.TOP;
			radio.x = 24.85;
			radio.y = 58.35;
			addChild(radio);
			
			newspaper = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			newspaper.hAlign = HAlign.LEFT;
			newspaper.vAlign = VAlign.TOP;
			newspaper.x = 24.85;
			newspaper.y = 78.35;
			addChild(newspaper);
			
			internet = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			internet.hAlign = HAlign.LEFT;
			internet.vAlign = VAlign.TOP;
			internet.x = 24.85;
			internet.y = 98.35;
			addChild(internet);
			
			event = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			event.hAlign = HAlign.LEFT;
			event.vAlign = VAlign.TOP;
			event.x = 24.85;
			event.y = 118.35;
			addChild(event);
			
			billboard = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			billboard.hAlign = HAlign.LEFT;
			billboard.vAlign = VAlign.TOP;
			billboard.x = 24.85;
			billboard.y = 139.05;
			addChild(billboard);
			
			food1 = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			food1.hAlign = HAlign.LEFT;
			food1.vAlign = VAlign.TOP;
			food1.x = 226.25;
			food1.y = 38.35;
			addChild(food1);
			
			food2 = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			food2.hAlign = HAlign.LEFT;
			food2.vAlign = VAlign.TOP;
			food2.x = 226.25;
			food2.y = 58.35;
			addChild(food2);
			
			food3 = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			food3.hAlign = HAlign.LEFT;
			food3.vAlign = VAlign.TOP;
			food3.x = 226.25;
			food3.y = 78.35;
			addChild(food3);
			
			drink1 = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			drink1.hAlign = HAlign.LEFT;
			drink1.vAlign = VAlign.TOP;
			drink1.x = 226.25;
			drink1.y = 98.35;
			addChild(drink1);
			
			drink2 = new TextField(200, 50, "3", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			drink2.hAlign = HAlign.LEFT;
			drink2.vAlign = VAlign.TOP;
			drink2.x = 226.25;
			drink2.y = 118.35;
			addChild(drink2);
			
			buttonRandom = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_random")); 
			buttonRandom.x = 74.95;
			buttonRandom.y = 191.9;
			addChild(buttonRandom);
			
			buttonRandom.addEventListener(Event.TRIGGERED, function(event:Event):void{
				update();
			});
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_close")); 
			buttonClose.x = 189.95;
			buttonClose.y = 191.9;
			addChild(buttonClose);
			
			buttonClose.addEventListener(Event.TRIGGERED, function(event:Event):void{
				closeDialog();
			});
			
			update();
		}
		
		public function update():void
		{
			if(npc != null)
			{
				npc.removeFromParent(true);
			}
			npc = Agent(WorldManager.instance.listAgent[GameUtils.randomFor(WorldManager.instance.listAgent.length)-1]);
			npc.x = -300;
			npc.y = -20;
			npc.facing = "east";
			npc.baseCharacter.play();
			addChild(npc);
		}
	}
}