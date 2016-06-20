package sketchproject.objects.advertising
{
	import feathers.controls.Check;

	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.managers.DataManager;
	import sketchproject.objects.adapter.ResearchAdapter;
	import sketchproject.utilities.ValueFormatter;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Setting research and discount.
	 * 
	 * @author Angga
	 */
	public class ResearchFrame extends Sprite
	{
		private var backgroundAvatar:Image;
		private var label:TextField;
		private var researchList:Sprite;
		private var checkFirstDiscount:Check;
		private var checkLastDiscount:Check;
		private var research:Array;
		private var costText:TextField;
		private var server:DataManager;

		/**
		 * Default constructor of ResearchFrame.
		 */
		public function ResearchFrame()
		{
			super();

			server = new DataManager();

			backgroundAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_dian_sastro"));
			backgroundAvatar.x = -465;
			backgroundAvatar.y = -150;
			this.addChild(backgroundAvatar);

			backgroundAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_reza_radhian"));
			backgroundAvatar.x = 170;
			backgroundAvatar.y = -130;
			this.addChild(backgroundAvatar);

			backgroundAvatar = new Image(Assets.getAtlas(Assets.CHARACTER, Assets.CHARACTER_XML).getTexture("employee_vino_sebastian"));
			backgroundAvatar.x = 410;
			backgroundAvatar.y = -130;
			backgroundAvatar.scaleX = -1;
			this.addChild(backgroundAvatar);

			label = new TextField(100, 50, "Research", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -250;
			label.y = -200;
			addChild(label);

			label = new TextField(100, 50, "Daily Cost", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 40;
			label.y = -200;
			addChild(label);

			researchList = new Sprite();
			researchList.x = -240;
			researchList.y = -170;
			addChild(researchList);

			label = new TextField(100, 50, "Discount", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -250;
			label.y = 0;
			addChild(label);

			checkFirstDiscount = new Check();
			checkFirstDiscount.x = -240;
			checkFirstDiscount.y = 30;
			checkFirstDiscount.addEventListener(starling.events.Event.CHANGE, isFirstDiscountChecked);
			addChild(checkFirstDiscount);

			label = new TextField(200, 50, "First day of sale", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -200;
			label.y = 30;
			addChild(label);

			label = new TextField(200, 50, "5%", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 60;
			label.y = 30;
			addChild(label);

			checkLastDiscount = new Check();
			checkLastDiscount.x = -240;
			checkLastDiscount.y = 55;
			checkLastDiscount.addEventListener(starling.events.Event.CHANGE, isLastDiscountChecked);
			addChild(checkLastDiscount);

			label = new TextField(200, 50, "Last day of sale", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = -200;
			label.y = 55;
			addChild(label);

			label = new TextField(100, 50, "10%", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333, true);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 60;
			label.y = 55;
			addChild(label);

			costText = new TextField(200, 50, "Cost per hari " + Data.researchCost.toString(), Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			costText.hAlign = HAlign.LEFT;
			costText.vAlign = VAlign.TOP;
			costText.x = -200;
			costText.y = 85;
			addChild(costText);

			updateResearch();
		}

		/**
		 * Set research check list and
		 */
		public function updateResearch():void
		{
			Data.researchCost = 0;
			researchList.removeChildren();
			research = new Array();
			for (var i:int = 0; i < Config.research.length; i++)
			{
				var rsc:ResearchAdapter = new ResearchAdapter(Config.research[i][0], Config.research[i][1], Config.research[i][2]);
				rsc.y = i * 30;
				rsc.addEventListener(ResearchAdapter.RESEARCH_CHANGED, onChanged);
				researchList.addChild(rsc);
				research.push(rsc);
			}

			for (var j:int = 0; j < Data.research.length; j++)
			{
				if (Data.research[j])
				{
					ResearchAdapter(research[j]).checked(true);
				}
				else
				{
					ResearchAdapter(research[j]).checked(false);
				}
			}
		}

		/**
		 * Dispatched event when research check list is changed.
		 * 
		 * @param event
		 */
		private function onChanged(event:starling.events.Event):void
		{
			for (var j:int = 0; j < Data.research.length; j++)
			{
				if (ResearchAdapter(research[j]).isChecked())
				{
					Data.research[j] = 1;
				}
				else
				{
					Data.research[j] = 0;
				}
			}

			if (ResearchAdapter(event.target).isChecked())
			{
				Data.researchCost += ResearchAdapter(event.target).researchPrice;
			}
			else
			{
				Data.researchCost -= ResearchAdapter(event.target).researchPrice;
			}
			costText.text = "Cost per hari IDR " + ValueFormatter.format(Data.researchCost);

			server.saveGameData();
		}

		/**
		 * First discount setting updated.
		 * 
		 * @param event
		 */
		public function isFirstDiscountChecked(event:starling.events.Event):void
		{
			if (checkFirstDiscount.isSelected)
			{
				Data.discountFirst = 5;
			}
			else
			{
				Data.discountFirst = 0;
			}
		}

		/**
		 * Last discound setting updateed.
		 * 
		 * @param event
		 */
		public function isLastDiscountChecked(event:starling.events.Event):void
		{
			if (checkLastDiscount.isSelected)
			{
				Data.discountFirst = 5;
			}
			else
			{
				Data.discountFirst = 0;
			}
		}
	}
}
