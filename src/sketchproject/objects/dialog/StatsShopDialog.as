package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.utilities.ValueFormatter;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class StatsShopDialog extends DialogOverlay
	{
		private var background:Image;
		private var container:Sprite;
		private var bar:Image;
		private var price:TextField;
		private var buttonPlayer:Button;
		private var buttonCompetitor1:Button;
		private var buttonCompetitor2:Button;
		private var buttonClose:Button;
		private var shopName:TextField;
		
		public function StatsShopDialog(destroyable:Boolean = false)
		{
			super(destroyable);
			
			background = new Image(Assets.getAtlas(Assets.ADDITIONAL, Assets.ADDITIONAL_XML).getTexture("setup_shop_panel"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			shopName = new TextField(300, 50, "Player Shop", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 20, 0x333333);
			shopName.pivotX = shopName.width;
			shopName.hAlign = HAlign.RIGHT;
			shopName.vAlign = VAlign.TOP;
			shopName.x = 421.5;
			shopName.y = -254;
			addChild(shopName);
			
			container = new Sprite();
			addChild(container);
						
			buttonPlayer = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_player")); 
			buttonPlayer.x = 77.05;
			buttonPlayer.y = 219.1;
			addChild(buttonPlayer);
			
			buttonPlayer.addEventListener(Event.TRIGGERED, function(event:Event):void{
				shopName.text = "Player Shop";
			});
			
			buttonCompetitor1 = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_other1")); 
			buttonCompetitor1.x = 197.8;
			buttonCompetitor1.y = 219.1;
			addChild(buttonCompetitor1);
			
			buttonCompetitor1.addEventListener(Event.TRIGGERED, function(event:Event):void{
				shopName.text = "Competitor 1 Shop";
			});
			
			buttonCompetitor2 = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_other2")); 
			buttonCompetitor2.x = 318.55;
			buttonCompetitor2.y = 219.1;
			addChild(buttonCompetitor2);
			
			buttonCompetitor2.addEventListener(Event.TRIGGERED, function(event:Event):void{
				shopName.text = "Competitor 2 Shop";
			});
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("button_stats_close")); 
			buttonClose.x = -65;
			buttonClose.y = 219.1;
			addChild(buttonClose);
			
			buttonClose.addEventListener(Event.TRIGGERED, function(event:Event):void{
				closeDialog();
			});
			
			update();
		}
		
		public function update():void
		{
			container.removeChildren();
			
			for(var i:int=0; i<Data.decoration.length;i++){
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = -326.6;
				bar.y = -146.15 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/10*Data.decoration[i];
				bar.x = -326.6;
				bar.y = -146.15 + (i*20);
				container.addChild(bar);
			}
			
			for(i=0; i<Data.cleanness.length;i++){
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = -326.6;
				bar.y = -60.15 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/10*Data.cleanness[i];
				bar.x = -326.6;
				bar.y = -60.15 + (i*20);
				container.addChild(bar);
			}
			
			for(i=0; i<Data.scent.length;i++){
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = -326.6;
				bar.y = 5.85 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/10*Data.scent[i];
				bar.x = -326.6;
				bar.y = 5.85 + (i*20);
				container.addChild(bar);
			}
			
			for(i=0; i<Data.booster.length;i++){
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = -326.6;
				bar.y = 123.95 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/5*Data.booster[i];
				bar.x = -326.6;
				bar.y = 123.95 + (i*20);
				container.addChild(bar);
			}
			
			
			for(i=0; i<Config.candidate.length;i++){
				var morale:int = 0;
				var services:int = 0;
				var productivity:int = 0;
				
				if(Config.candidate[i].emp_status == "hired")
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
					bar.width = 10;
					bar.x = -210;
					bar.y = -142.05 + (i*20);
					container.addChild(bar);
					
					for(var j:uint=0; j<Data.employee.length;j++){
						if(Data.employee[j].emp_id == Config.candidate[i].emp_id)
						{
							morale = Data.employee[j].pem_morale;
							services = Data.employee[j].pem_services;
							productivity = Data.employee[j].pem_productivity;
						}
					}
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
					bar.width = 10;
					bar.x = -210;
					bar.y = -142.05 + (i*20);
					container.addChild(bar);
				}
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = -63.1;
				bar.y = -141.05 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/5*morale;
				bar.x = -63.1;
				bar.y = -141.05 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = 13.4;
				bar.y = -141.05 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/5*services;
				bar.x = 13.4;
				bar.y = -141.05 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = 89.9;
				bar.y = -141.05 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/5*productivity;
				bar.x = 89.9;
				bar.y = -141.05 + (i*20);
				container.addChild(bar);
			}
			
			for(i=0; i<Data.research.length;i++){
				if(Data.research[i] == 1)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));					
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				}
				bar.width = 10;
				bar.x = -210;
				bar.y = 86.2 + (i*20);
				container.addChild(bar);
			}
			
			for(i=0; i<Data.program.length;i++){
				if(Data.program[i] == 1)
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));					
				}
				else
				{
					bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				}
				bar.width = 10;
				if(i<5)
				{
					bar.x = -53.45;
					bar.y = 86.2 + (i*20);
				}
				else
				{
					bar.x = 120.95;
					bar.y = 86.2 + ((i-5)*20);
				}
				
				container.addChild(bar);
			}
			
			for(i=0; i<Data.advertising.length;i++){
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark_light"));
				bar.width = 50;
				bar.x = 372.65;
				bar.y = 59.4 + (i*20);
				container.addChild(bar);
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("check_mark"));
				bar.width = 50/5*(Data.advertising[i][1]+Data.advertising[i][2]);
				bar.x = 372.65;
				bar.y = 59.4 + (i*20);
				container.addChild(bar);
			}
			
			for(i=0; i<Data.product.length;i++){
				price = new TextField(250, 50, ValueFormatter.numberFormat(Data.product[i].prd_price,"IDR "), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
				price.hAlign = HAlign.LEFT;
				price.vAlign = VAlign.TOP;
				price.x = 288.3;
				if(i<3)
				{					
					price.y = -149.5 + (i*21);
				}
				else
				{
					price.y = -47.5 + ((i-3)*21);;
				}
				
				addChild(price);
				
				price = new TextField(250, 50, "5/10", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
				price.hAlign = HAlign.LEFT;
				price.vAlign = VAlign.TOP;
				price.x = 375.55;
				if(i<3)
				{					
					price.y = -149.5 + (i*21);
				}
				else
				{
					price.y = -47.5 + ((i-3)*21);;
				}
				addChild(price);
			}
		}
	}
}