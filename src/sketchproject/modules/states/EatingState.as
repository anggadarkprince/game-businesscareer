package sketchproject.modules.states
{
	import flash.geom.Point;
	
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.DecisionFunction;
	import sketchproject.modules.MotivationFunction;
	import sketchproject.modules.PathFinder;
	import sketchproject.modules.Shop;
	import sketchproject.utilities.GameUtils;
	import sketchproject.utilities.IsoHelper;

	/**
	 * Agent takes a choice of brands and visit the shop.
	 *
	 * @author Angga
	 */
	public class EatingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var shopName:String;
		private var shopCoordinate:Point;
		private var shop:Shop;
		private var motivationFunction:MotivationFunction;
		private var decisionFunction:DecisionFunction;

		/**
		 * Default constructor of EatingState.
		 *
		 * @param agent
		 */
		public function EatingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "eating";
			motivationFunction = new MotivationFunction();
			decisionFunction = new DecisionFunction();
		}

		/**
		 * Initialize and calculate agent's choice.
		 */
		public function initialize():void
		{
			trace("      |-- [state:eating] agent id", agent.agentId, ": onEnter");

			updated = false;

			shopCoordinate = new Point();
			
			var productIndex:int = GameUtils.randomFor(Shop.productList.length) - 1;
			var product:String = Shop.productList[productIndex];
			
			if (agent.role == Agent.ROLE_FREEMAN)
			{
				shop = decisionFunction.accidentalSelection(WorldManager.instance.listShop, agent);
			}
			else
			{
				// do the math
				var decisionMaking:uint = GameUtils.randomFor(100);
				if (decisionMaking < 80)
				{
					// optimistic agent					
					trace("        |-- [state:eating] method optimistic");
					shop = motivationFunction.motivation(WorldManager.instance.listShop, agent, product);
				}
				else if (decisionMaking < 90)
				{
					// pesimistic agent
					trace("        |-- [state:eating] method pesimistic");
					shop = decisionFunction.influenceSelection(WorldManager.instance.listShop, agent);
				}
				else
				{
					// neutral agent					
					trace("        |-- [state:eating] method neutral");
					shop = decisionFunction.accidentalSelection(WorldManager.instance.listShop, agent);
				}
			}

			agent.choice = shop.shopId;
			agent.choiceReaction(agent.choice);			

			shop.transactionTotal += 1;
			shop.grossProfit += motivationFunction.calculateProductPrice(shop, product) * 1000;

			shopCoordinate = shop.districtCoordinate;
			shopName = shop.shopName;

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, shopCoordinate.x, shopCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(shopCoordinate);
			agent.isMoving = true;
			agent.perceptReaction("need");

			trace("        |-- [state:eating] choice shop id", shop.shopId, "name", shop.shopName);
			trace("        |-- [state:eating] product", product, "price", motivationFunction.calculateProductPrice(shop, product));
			trace("        |-- [state:eating] transaction #", shop.transactionTotal, "profit", shop.grossProfit);
			trace("        |-- [state:eating] destination", shopCoordinate);
			trace("        |-- [state:eating] path", agent.path);
			
			// calculate marketplace
			var a:int = 0;
			var b:int = 0;
			var c:int = 0;
			
			for (var j:int = 0; j < WorldManager.instance.listAgent.length; j++)
			{
				if (WorldManager.instance.listAgent[j].choice == 1)
				{
					a++;
				}
				else if (WorldManager.instance.listAgent[j].choice == 2)
				{
					b++;
				}
				else if (WorldManager.instance.listAgent[j].choice == 3)
				{
					c++;
				}
			}
			
			// update marketshare list
			var aMarketshare:int = 100 * a / WorldManager.instance.listAgent.length;
			var bMarketshare:int = 100 * b / WorldManager.instance.listAgent.length;
			var cMarketshare:int = 100 * c / WorldManager.instance.listAgent.length;
			
			Shop(WorldManager.instance.listShop[0]).updateMarkershare(aMarketshare);
			Shop(WorldManager.instance.listShop[1]).updateMarkershare(bMarketshare);
			Shop(WorldManager.instance.listShop[2]).updateMarkershare(cMarketshare);
			
			Config.marketShare[0][0] = aMarketshare;
			Config.marketShare[1][0] = bMarketshare;
			Config.marketShare[2][0] = cMarketshare;
			
			Data.customer = a;
			Data.transactionAllShop++;
			
			if(shop.shopId == 1 && buyProduct(productIndex)){	
				if(product == Shop.productList[0]){
					Data.soldFood1++;
				} else if(product == Shop.productList[1]){
					Data.soldFood2++;
				} else if(product == Shop.productList[2]){
					Data.soldFood3++;
				} else if(product == Shop.productList[3]){
					Data.soldDrink1++;
				} else if(product == Shop.productList[4]){
					Data.soldDrink2++;
				}
				Data.transaction++;
				Data.marketshare = Shop(WorldManager.instance.listShop[0]).marketshare;
				Data.salesToday += int(Data.product[productIndex].prd_price);
				trace("        |-- [state:eating] product price", int(Data.product[productIndex].prd_price));
			}			
		}
		
		/**
		 * Check stock product is available.
		 * 
		 * @param productIndex
		 * @return 
		 */
		private function buyProduct(productIndex:int):Boolean
		{
			// check if material complete
			var totalMatch:int = 0;
			var dataNonExpired:Array = [12, 16, 17, 18, 19];
			for (var i:int = 0; i < Data.productMaterial[productIndex].material.length; i++)
			{
				for (var j:int = 0; j < Data.material.length; j++)
				{
					if (Data.productMaterial[productIndex].material[i] == Data.material[j].mtr_id)
					{
						var noExpired:Boolean = false;
						for (var k:int = 0; k < dataNonExpired.length; k++)
						{
							if(dataNonExpired[k] == Data.material[j].mtr_id){
								noExpired = true;
								break;
							}
						}
						if(!noExpired){
							if(Data.material[j].pma_expired_remaining > 0){								
								totalMatch++;
							}
						}
						else{
							totalMatch++;
						}
						break;
					}
				}
			}
			
			// remove 1 material
			if (totalMatch >= Data.productMaterial[productIndex].material.length)
			{
				for (i = 0; i < Data.productMaterial[productIndex].material.length; i++)
				{
					for (j = 0; j < Data.material.length; j++)
					{
						if (Data.productMaterial[productIndex].material[i] == Data.material[j].mtr_id)
						{
							if(Data.material[j].pma_stock > 0){
								Data.material[j].pma_stock--;
							}
						}
					}
				}
				
				return true;
			}
			else{
				return false;
			}
		}

		/**
		 * Update state of eating.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("      |-- [state:eating] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				var cartesian:Point = IsoHelper.get2dFromTileCoordinates(shopCoordinate, WorldManager.instance.map.tileHeight);
				var isometric:Point = IsoHelper.twoDToIso(cartesian);
				isometric.x = isometric.x + 50;

				agent.alpha = 0.3;
				WorldManager.instance.map.spawnCoin(isometric);
				
				agent.perceptReaction("satisfaction");

				trace("        |-- [state:eating] agent id", agent.agentId, "arrived in", shopName);
				
				agent.action.popState();
				agent.action.logState();
			}
		}

		/**
		 * Destroy eating state resources.
		 */
		public function destroy():void
		{
			trace("  |-- [state:eating] agent id", agent.agentId, ": onExit");

			updated = false;
			agent.isEating = false;
			agent.alpha = 1;
		}

		/**
		 * Print class name.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.EatingState";
		}
	}
}
