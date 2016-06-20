package sketchproject.objects.adapter
{
	import feathers.controls.Check;
	import feathers.themes.MetalWorksDesktopTheme;

	import sketchproject.core.Assets;
	import sketchproject.utilities.ValueFormatter;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Research list adapter.
	 * 
	 * @author Angga
	 */
	public class ResearchAdapter extends Sprite
	{
		public static const RESEARCH_CHANGED:String = "changed";

		private var id:int;
		private var checkResearch:Check;
		private var researchText:TextField;
		private var priceText:TextField;
		private var price:int;

		/**
		 * Default constructor of ResearchAdapter.
		 * 
		 * @param id of research
		 * @param research type
		 * @param price of research per day
		 */
		public function ResearchAdapter(id:int, research:String, price:int)
		{
			this.researchId = id;
			this.price = price;

			new MetalWorksDesktopTheme();

			checkResearch = new Check();
			addChild(checkResearch);

			researchText = new TextField(250, 50, research, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			researchText.hAlign = HAlign.LEFT;
			researchText.vAlign = VAlign.TOP;
			researchText.x = 40;
			addChild(researchText);

			priceText = new TextField(350, 50, "IDR " + ValueFormatter.format(price), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 16, 0x333333);
			priceText.hAlign = HAlign.LEFT;
			priceText.vAlign = VAlign.TOP;
			priceText.x = 280;
			addChild(priceText);

			checkResearch.addEventListener(Event.CHANGE, onResearchChanged);
		}

		/**
		 * Set research id.
		 * 
		 * @param id
		 */
		public function set researchId(id:int):void
		{
			this.id = id;
		}

		/**
		 * Get research id.
		 * 
		 * @return
		 */
		public function get researchId():int
		{
			return id;
		}

		/**
		 * Set research price.
		 * 
		 * @param price
		 */
		public function set researchPrice(price:int):void
		{
			this.price = price;
		}

		/**
		 * Get research price.
		 * 
		 * @return
		 */
		public function get researchPrice():int
		{
			return price;
		}

		/**
		 * check if this research is checked.
		 * 
		 * @return
		 */
		public function isChecked():Boolean
		{
			return checkResearch.isSelected;
		}

		/**
		 * Set as checked item.
		 * 
		 * @param check
		 */
		public function checked(check:Boolean):void
		{
			checkResearch.isSelected = check;
		}

		/**
		 * Dispatched when research item is changed.
		 * 
		 * @param event
		 */
		private function onResearchChanged(event:Event):void
		{
			dispatchEvent(new Event(ResearchAdapter.RESEARCH_CHANGED));
		}
	}
}
