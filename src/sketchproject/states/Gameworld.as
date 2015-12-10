package sketchproject.states
{
	import flash.geom.Point;
	
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.objects.dialog.DailyReportDialog;
	import sketchproject.objects.dialog.PostDialog;
	import sketchproject.objects.world.GameStats;
	import sketchproject.objects.world.Map;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Gameworld extends Sprite implements IState
	{
		// game component
		private var game:Game;
		private var map:Map;
		private var stats:GameStats;
		
		// map drag and drop property
		private var _startXPos:int = 0;
		private var _startYPos:int = 0;
		private var currentXPos:int = 0;
		private var currentYPos:int = 0;
		private var newXPos:int = 0;
		private var newYPos:int = 0;	
		private var minX:int = 0;
		private var maxX:int = 0;
		private var minY:int = 0;
		private var maxY:int = 0;
		private var globalPosition:Point = new Point();
					
		private var isSimulationStarted:Boolean;
		private var isDailyReportShowed:Boolean;
		
		private var dailyReport:DailyReportDialog;
		private var postDialog:PostDialog;
		
		public function Gameworld(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void
		{
			initialize();
			trace("[STATE] GAMEWORLD");
		}
		
		public function initialize():void
		{
			isSimulationStarted = true;
			isDailyReportShowed = false;
			
			map = new Map();
			map.x = 500;
			map.y = -300;
			addChild(map);
			
			stats = new GameStats();
			addChild(stats);
			
			map.addEventListener(TouchEvent.TOUCH, onWorldTouched);
			stats.addEventListener(GameStats.SHOP_OPEN, onShopOpen);
			stats.addEventListener(GameStats.SHOP_CLOSE, onShopClose);
			
			minX = -300 * Config.zoom;
			maxX = 1450 * Config.zoom; 
			minY = -831 * Config.zoom;
			maxY = 13 * Config.zoom; 
			
			postDialog = new PostDialog("Revenue",Data.salesToday,false,false);
			postDialog.x = stage.stageWidth * 0.5;
			postDialog.y = stage.stageHeight * 0.5;
			postDialog.addEventListener(PostDialog.POSTING, function(event:Event):void{
				Config.transactionList.splice(0,1);
				retrievePosting();
			});
			Game.overlayStage.addChild(postDialog);
			
			dailyReport = new DailyReportDialog();
			dailyReport.x = Starling.current.stage.stageWidth * 0.5;
			dailyReport.y = Starling.current.stage.stageHeight * 0.5;
			dailyReport.addEventListener(DailyReportDialog.REQUEST_POST, function(event:Event):void{
				isDailyReportShowed = false;
				dailyReport.closeDialog();
				retrievePosting();
			});
			addChild(dailyReport);
		}
				
		private function retrievePosting():void
		{
			if(Config.transactionList.length>0)
			{
				postDialog.transactionType = Config.transactionList[0][0];
				postDialog.transactionValue = Config.transactionList[0][1];
				postDialog.preparePosting();
				postDialog.openDialog();
			}			
			else
			{
				LoadingTransition.destination = Game.PLAY_STATE;
				game.changeState(Game.TRANSITION_STATE);
			}
		}
		
		private function onShopClose(event:Event):void
		{
			/*
			isSimulationStarted = false;
			isDailyReportShowed = true;
											
			Config.transactionList = new Array();
			
			// check business revenue
			if(Data.salesToday > 0)
				Config.transactionList.push(new Array("Revenue",Data.salesToday));
			
			// check business cost of good
			if(Data.firstCostOfGood - Data.lastCostOfGood > 0)
				Config.transactionList.push(new Array("Cost",Data.firstCostOfGood - Data.lastCostOfGood));
			
			// check business employee
			if(Data.employee.length > 0)
			{
				var totalSalary:int = 0;
				for(var i:uint = 0;i<Data.employee.length;i++)
				{
					totalSalary+=int(Data.employee[i].pem_salary);
				}
				Config.transactionList.push(new Array("Employee",totalSalary));
			}
			
			// check advertisement
			if(Data.advertisingCost[0][1] > 0)
				Config.transactionList.push(new Array("Advertising TV",Data.advertisingCost[0][1]));
			if(Data.advertisingCost[1][1] > 0)
				Config.transactionList.push(new Array("Advertising Radio",Data.advertisingCost[1][1]));
			if(Data.advertisingCost[2][1] > 0)
				Config.transactionList.push(new Array("Advertising Newspaper",Data.advertisingCost[2][1]));
			if(Data.advertisingCost[3][1] > 0)
				Config.transactionList.push(new Array("Advertising Internet",Data.advertisingCost[3][1]));
			if(Data.advertisingCost[4][1] > 0)
				Config.transactionList.push(new Array("Advertising Event",Data.advertisingCost[4][1]));
			if(Data.advertisingCost[5][1] > 0)
				Config.transactionList.push(new Array("Advertising Billboard",Data.advertisingCost[5][1]));
			
			// check research
			if(Data.researchCost > 0)
				Config.transactionList.push(new Array("Quality",Data.researchCost));
						
			// check program
			if(Data.programCost > 0)
				Config.transactionList.push(new Array("Training",Data.programCost));
			
			dailyReport.generateDailyReport();
			dailyReport.openDialog();
			*/
		}
		
		private function onShopOpen(event:Event):void
		{			
			trace("shop open-----prepare the simulation");
		}
		
		private function onWorldTouched(e:TouchEvent):void
		{	
			var touch:Touch = e.getTouch(stage);
			var target:DisplayObject = e.currentTarget as DisplayObject;
			
			if (touch == null)
			{
				return;
			}
			
			var position:Point = touch.getLocation(stage);
			
			if (touch.phase == TouchPhase.BEGAN )
			{
				// store start of drag x pos
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;
				
				_startXPos = target.globalToLocal(globalPosition).x;
				_startYPos = target.globalToLocal(globalPosition).y;
			}
			else if (touch.phase == TouchPhase.MOVED )
			{				
				// calculate new x based on touch's global coordinates
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;
				
				currentXPos = target.globalToLocal(globalPosition).x;
				currentYPos = target.globalToLocal(globalPosition).y;
				
				newXPos = target.x + currentXPos - _startXPos;
				newYPos = target.y + currentYPos - _startYPos;
				
				if (newXPos <= maxX && newXPos>=minX) // set target's x if it falls within limits
					target.x=newXPos;
				
				if (newYPos <= maxY && newYPos>=minY) // set target's y if it falls within limits
					target.y=newYPos;
			}
			
			return;
		}
		
		public function update():void
		{
			if(isSimulationStarted)
			{
				map.update(stats.clock.hour, stats.clock.minute);
				map.checkRadianceAtmosphere(stats.clock.hour);
				map.checkEventOperation(stats.clock.hour);
				stats.update();
			}
			else if(isDailyReportShowed)
			{
				dailyReport.update();
			}
						
		}
		
		public function destroy():void
		{
			removeFromParent(true);
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.VacationState";
		}
	}
}