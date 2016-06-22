package sketchproject.objects.product
{
	import com.greensock.TweenMax;

	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Game;
	import sketchproject.objects.dialog.InfoDistrictDialog;
	import sketchproject.objects.dialog.SupplierDialog;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	 * Provide supplier and material transaction.
	 *
	 * @author Angga
	 */
	public class SupplierFrame extends Sprite
	{
		private var mapContainer:Sprite;

		private var label:TextField;
		private var gasRemaining:TextField;
		private var distanceRemaining:TextField;
		private var mapBackground:Image;
		private var marker:Button;
		private var supplierButton:Button;

		private var ship1:Image;
		private var ship2:Image;

		private var listInfoMarker:Array;
		private var listMarketMarker:Array;
		private var market:Array;

		private var supplier:SupplierDialog;
		private var dialogDistrict:InfoDistrictDialog;

		/**
		 * Default constructor of SupplierDialog.
		 */
		public function SupplierFrame()
		{
			super();

			listInfoMarker = new Array();
			listMarketMarker = new Array();
			market = new Array();

			mapContainer = new Sprite();
			mapContainer.x = -Starling.current.stage.stageWidth * 0.5;
			mapContainer.y = -Starling.current.stage.stageHeight * 0.5;
			addChild(mapContainer);

			mapBackground = new Image(Assets.getAtlas(Assets.PANEL, Assets.PANEL_XML).getTexture("map"));
			mapContainer.addChild(mapBackground);

			ship1 = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("ship"));
			ship1.pivotX = ship1.width * 0.5;
			ship1.pivotY = ship1.height * 0.5;
			ship1.x = 374;
			ship1.y = -32;
			mapContainer.addChild(ship1);
			shipMovement(ship1, 374, -32, -80, 130, 30);

			ship2 = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("ship"));
			ship2.pivotX = ship2.width * 0.5;
			ship2.pivotY = ship2.height * 0.5;
			ship2.scaleX = -1;
			ship2.x = -60;
			ship2.y = 280;
			mapContainer.addChild(ship2);
			shipMovement(ship2, -60, 280, 430, 595, 20);

			dialogDistrict = new InfoDistrictDialog();
			dialogDistrict.x = Starling.current.stage.stageWidth * 0.5;
			dialogDistrict.y = Starling.current.stage.stageHeight * 0.5;
			Game.overlayStage.addChild(dialogDistrict);

			for (var i:int = 0; i < Config.district.length; i++)
			{
				marker = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Config.district[i][6][0]));
				marker.pivotX = marker.width * 0.5;
				marker.pivotY = marker.height * 0.5;
				marker.x = Config.district[i][6][1];
				marker.y = Config.district[i][6][2];
				marker.name = Config.district[i][0];
				marker.addEventListener(Event.TRIGGERED, onDistrictSelected);
				mapContainer.addChild(marker);
				bounceMarker(marker);
				listInfoMarker.push(marker);
			}

			for (var j:int = 0; j < Config.supplier.length; j++)
			{
				supplierButton = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture(Config.supplier[j].spl_marker_atlas));
				supplierButton.pivotX = supplierButton.width * 0.5;
				supplierButton.pivotY = supplierButton.height * 0.5;
				supplierButton.x = Config.supplier[j].spl_marker_x;
				supplierButton.y = Config.supplier[j].spl_marker_y;
				supplierButton.addEventListener(Event.TRIGGERED, onSupplierCalled);
				mapContainer.addChild(supplierButton);
				bounceMarket(supplierButton);
				listMarketMarker.push(supplierButton);

				supplier = new SupplierDialog(Config.supplier[j]);
				supplier.x = Starling.current.stage.stageWidth * 0.5;
				supplier.y = Starling.current.stage.stageHeight * 0.5;
				Game.overlayStage.addChild(supplier);
				market.push(supplier);
			}
		}

		/**
		 * Marker district is selected and show district information dialog.
		 * 
		 * @param event
		 */
		private function onDistrictSelected(event:Event):void
		{
			var id:String = Button(event.currentTarget).name;
			for (var i:int = 0; i < Config.district.length; i++)
			{
				if (Config.district[i][0] == id)
				{
					dialogDistrict.openDialog(Config.district[i][1], Config.district[i][3], Config.district[i][2], 30);
				}
			}
		}

		/**
		 * Marker supplier is selected and show dialog.
		 * 
		 * @param event
		 */
		private function onSupplierCalled(event:Event):void
		{
			for (var i:int = 0; i < listMarketMarker.length; i++)
			{
				if (event.currentTarget == listMarketMarker[i])
				{
					SupplierDialog(market[i]).openDialog();
				}
			}
		}

		/**
		 * Bounce the marker of info.
		 * 
		 * @param marker
		 */
		public function bounceMarker(marker:DisplayObject):void
		{
			TweenMax.to(
				marker, 
				0.7, 
				{
					repeat: 1, 
					y: marker.y - 5, 
					yoyo: true, 
					onComplete: function():void {
						bounceMarker(marker);
					}
				}
			);
		}

		/**
		 * Bounce the marker of market.
		 * 
		 * @param supplier
		 */
		public function bounceMarket(supplier:DisplayObject):void
		{
			TweenMax.to(
				supplier, 
				1, 
				{
					repeat: 1, 
					scaleX: 0.8, 
					scaleY: 0.8, 
					yoyo: true, 
					delay: 2, 
					onComplete: function():void {
						bounceMarket(supplier);
					}
				}
			);
		}

		/**
		 * Move ships from location to another location.
		 * 
		 * @param ship current ship sprite
		 * @param xStart x start position
		 * @param yStart y start position
		 * @param xDest x destination postion
		 * @param yDest y destination position
		 * @param duration in seconds from start to destination
		 */
		public function shipMovement(ship:DisplayObject, xStart:Number, yStart:Number, xDest:Number, yDest:Number, duration:Number):void
		{
			TweenMax.to(
				ship, 
				duration, 
				{
					x: xDest, 
					y: yDest, 
					delay: 3, 
					onComplete: function():void {
						ship.x = xStart;
						ship.y = yStart;
						shipMovement(ship, xStart, yStart, xDest, yDest, duration);
					}
				}
			);
		}

	}
}
