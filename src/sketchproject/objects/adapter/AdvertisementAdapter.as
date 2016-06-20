package sketchproject.objects.adapter
{
	import feathers.controls.PickerList;
	import feathers.data.ListCollection;

	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Handle single advertisement setting.
	 *
	 * @author Angga
	 */
	public class AdvertisementAdapter extends Sprite
	{
		public static const ADVERTISEMENT_CHANGED:String = "advertisement";

		private var adverId:int;
		private var adverCost:int;
		private var advertise:TextField;
		private var advertiseIcon:Image;
		private var label:TextField;

		private var visibilityList:ListCollection = new ListCollection([{text: "NONE"}, {text: "LOW"}, {text: "AVG"}, {text: "HIGH"}]);
		private var levelList:ListCollection = new ListCollection([{text: "1"}, {text: "2"}, {text: "3"}]);
		private var listVisibility:PickerList;
		private var listLevel:PickerList;

		/**
		 * Default constructor of AdvertisementAdapter.
		 *
		 * @param id of advertisement
		 * @param adver type of advertisement
		 * @param texture icon
		 */
		public function AdvertisementAdapter(id:int, adver:String, texture:String)
		{
			super();

			adverId = id;
			adverCost = 0;

			advertiseIcon = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(texture));
			advertiseIcon.y = 5;
			addChild(advertiseIcon);

			advertise = new TextField(250, 50, adver, Assets.getFont(Assets.FONT_SSBOLD).fontName, 18, 0x333333);
			advertise.vAlign = VAlign.TOP;
			advertise.hAlign = HAlign.LEFT;
			advertise.x = 70;
			advertise.y = 0;
			addChild(advertise);

			label = new TextField(250, 50, "Visibility", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 70;
			label.y = 22;
			addChild(label);

			listVisibility = new PickerList();
			listVisibility.dataProvider = visibilityList;
			listVisibility.listProperties.@itemRendererProperties.labelField = "text";
			listVisibility.labelField = "text";
			listVisibility.width = 70;
			listVisibility.height = 20;
			listVisibility.x = 75;
			listVisibility.y = 45;
			addChild(listVisibility);

			label = new TextField(250, 50, "Level", Assets.getFont(Assets.FONT_SSBOLD).fontName, 14, 0x333333);
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.LEFT;
			label.x = 165;
			label.y = 22;
			addChild(label);

			listLevel = new PickerList();
			listLevel.prompt = "NONE";
			listLevel.dataProvider = levelList;
			listLevel.listProperties.@itemRendererProperties.labelField = "text";
			listLevel.labelField = "text";
			listLevel.width = 70;
			listLevel.height = 20;
			listLevel.x = 170;
			listLevel.y = 45;
			addChild(listLevel);

			for (var i:uint = 0; i < Data.advertising.length; i++)
			{
				if (Data.advertising[i][0] == adverId)
				{
					listVisibility.selectedIndex = Data.advertising[i][1];
					listLevel.selectedIndex = Data.advertising[i][2];
				}
			}

			listVisibility.addEventListener(Event.CHANGE, onVisibilityChanged);
			listLevel.addEventListener(Event.CHANGE, onLevelChanged);

			onVisibilityChanged(null);
		}

		/**
		 * Set id of advertisement.
		 * 
		 * @param adverId
		 */
		public function set id(adverId:int):void
		{
			this.adverId = adverId;
		}

		/**
		 * Get id of advertisement.
		 * 
		 * @return
		 */
		public function get id():int
		{
			return adverId;
		}

		/**
		 * On visibility of advertisement changed, calculate cost and set level 
		 * active when visibility selected.
		 * 
		 * @param event
		 */
		public function onVisibilityChanged(event:Event):void
		{
			getCost();
			if (listVisibility.selectedIndex == 0)
			{
				listLevel.selectedIndex = 0;
				listLevel.isEnabled = false;
			}
			else
			{
				listLevel.isEnabled = true;
			}
			dispatchEvent(new Event(AdvertisementAdapter.ADVERTISEMENT_CHANGED));
		}

		/**
		 * On level of advertisement, calculate cost.
		 * 
		 * @param event
		 */
		public function onLevelChanged(event:Event):void
		{
			getCost();
			dispatchEvent(new Event(AdvertisementAdapter.ADVERTISEMENT_CHANGED));
		}

		/**
		 * Calculate cost of this advertisement.
		 * 
		 * @return
		 */
		public function getCost():Number
		{
			updatePlayerAdvertising();
			for (var i:uint = 0; i < Config.advertisement.length; i++)
			{
				if (Config.advertisement[i][0] == adverId)
				{
					var visibility:Array = Config.advertisement[i][3];
					adverCost = visibility[listVisibility.selectedIndex] * (listLevel.selectedIndex + 1);
					return adverCost;
				}
			}
			return 0;
		}
		
		/**
		 * Update player's advertisement value.
		 */
		public function updatePlayerAdvertising():void
		{
			for (var i:uint = 0; i < Data.advertising.length; i++)
			{
				if (Data.advertising[i][0] == id)
				{
					Data.advertising[i][1] = listVisibility.selectedIndex;
					Data.advertising[i][2] = listLevel.selectedIndex;
				}
			}
		}
	}
}
