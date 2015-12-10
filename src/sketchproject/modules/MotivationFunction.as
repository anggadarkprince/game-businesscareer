package sketchproject.modules
{
	/**
	 * ...
	 * @author Angga Ari Wijaya
	 */
	public class MotivationFunction 
	{
		private var M:Number;
		private var PS:Number;
		private var P:Number;
		private var QS:Number;
		private var Q:Number;
		private var SUS:Number;
		private var AD:Number;
		private var FT:Number;
		private var INFL:Number;
		
		private var MList:Array = [];
		
		private var shop:Array = [];
		private var agent:Agent;
				
		public function MotivationFunction() 
		{
			
		}
		
		public function get m()
		{
			return this.M;
		}
		public function set m(Mi:Number)
		{
			this.M = Mi;
		}
		
		public function get ps()
		{
			return this.PS;
		}
		public function set ps(PSi:Number)
		{
			this.PS = PSi;
		}
		
		public function get p()
		{
			return this.P;
		}
		public function set p(Pi:Number)
		{
			this.P = Pi;
		}
		
		public function get qs()
		{
			return this.QS;
		}
		public function set qs(QSi:Number)
		{
			this.QS = QSi;
		}
		
		public function get q()
		{
			return this.Q;
		}
		public function set q(Qi:Number)
		{
			this.Q = Qi;
		}
		
		public function get sus()
		{
			return this.SUS;
		}
		public function set sus(susi:Number)
		{
			this.SUS = susi;
		}
		
		public function get ad()
		{
			return this.AD;
		}
		public function set ad(adi:Number)
		{
			this.AD = adi;
		}
						
		public function get ft()
		{
			return this.FT;
		}
		public function set ft(fti:Number)
		{
			this.FT = fti;
		}
		
		public function get infl()
		{
			return this.INFL;
		}
		public function set infl(infli:Number)
		{
			this.INFL = infli;
		}
		
		
		
		/* motivation */
		
		public function motivation(shop:Array, agent:Agent, product:String):void
		{
			this.shop = shop;
			this.agent = agent;
			MList = [];
			for (var i:int = 0; i < shop.length; i++) 
			{
				
				// find Pi
				p = calculateProductPrice(shop[i], product);
				
				// find Pave
				var pave:Number = calaculatePriceAvarage(shop, product);
				
				// find PSi
				ps = calculatePriceSensitivity(agent, p, pave);
				
				// find Qi
				q = calculateProductQuality(shop[i], agent, product);
				
				// find Qave
				var qave:Number = calculateQualityAverage(shop, agent, product);
				
				// find QSi
				qs = calculateQualitySensitivity(agent, q, qave);
				
				// find sus
				sus = susceptibility(agent);
				
				// find ad
				ad = advert(shop[i], agent);
				
				// find ft
				ft = followerTendency(agent);
				
				// find infl
				infl = influence(agent);
				
				m = (ps * p) + (qs * q) + (sus * ad) + (ft * infl);
				
				MList.push(m);
				
				trace("price "+product+" : " + shop[i].priceA);
				trace("price "+product+" average : " + pave);
				trace("price sensitivity : " + ps);
				
				trace("quality " + product + " : " + q);
				trace("quality "+product+" average : " + qave);
				
				trace("quality sensitivity : " + qs);
				trace("sus : " + sus);
				trace("ad : " + ad);
				trace("ft : " + ft);
				trace("infl : " + infl);
				trace("m : " + m);
				trace("------------------------------");
			}
			trace(shop[maxM(MList)].shop);
			agent.activeProductChoice = maxM(MList);
			agent.gotoAndStop(agent.activeProductChoice + 2);
			
		}
		
		public function maxM(data:Array):int
		{
			var max:Number = data[0];
			for (var i:int = 0; i < data.length; i++) 
			{
				if (data[i] > max)
				{
					max = data[i];
				}
			}
			
			return MList.indexOf(max);
		}
		
		
		/* quality function */
		
		public function calculateQualitySensitivity(agent:Agent, qi:Number, qavei:Number)
		{
			return Math.pow(agent._beta, Math.abs(qi - qavei)) + agent.qualitySensitivity;
		}
		
		public function calculateProductQuality(shop:Shop, agent:Agent, product:String):Number
		{
			var total:Number = 0;
			var j:int = 0;
			switch(product) {
				case "A":						
					for (j = 0; j < shop.qualityA.length; j++) 
					{
						total += shop.qualityA[j] * agent.qualityWeightA[j];
					}
					return total / shop.qualityA.length;
					break;
				case "B":
					for (j = 0; j < shop.qualityB.length; j++) 
					{
						total += shop.qualityB[j] * agent.qualityWeightB[j];
					}
					return total / shop.qualityB.length;
					break;
				case "C":
					for (j = 0; j < shop.qualityC.length; j++) 
					{
						total += shop.qualityC[j] * agent.qualityWeightC[j];
					}
					return total / shop.qualityC.length;
					break;
			}
			return 0;
		}
		
		public function calculateQualityAverage(shop:Array, agent:Agent, product:String) :Number
		{
			var total:Number = 0;
			var tempQ:Number = 0;
			for (var i:int = 0; i < shop.length; i++) 
			{
				total += calculateProductQuality(shop[i] as Shop, agent, product);				
			}
			return total/shop.length;
		}
		
		
		/* price function */
		
		public function calculatePriceSensitivity(agent:Agent, pi:Number, pavei:Number):Number
		{
			return Math.pow(agent._alpha, ((pi - pavei) * -1)) + agent.priceSensitivity;
		}
		
		public function calculateProductPrice(shop:Shop, product:String):Number
		{
			switch(product) {
				case "A":
					return shop.priceA;
					break;
				case "B":
					return shop.priceB;
					break;
				case "C":
					return shop.priceC;
					break;
			}
			return 0;
		}
		
		public function calaculatePriceAvarage(shop:Array, product:String):Number
		{
			var total:Number = 0;
			for (var i:int = 0; i < shop.length; i++) 
			{
				switch(product) {
					case "A":
						total += shop[i].priceA;
						break;
					case "B":
						total += shop[i].priceB;
						break;
					case "C":
						total += shop[i].priceC;
						break;
				}				
			}
			return total / shop.length;
		}
		
		
		/* constant */
		
		public function susceptibility(agent:Agent):Number 
		{
			// theta value 9
			return agent.contactVolume;
		}
		
		public function advert(shop:Shop, Agent:Agent):Number
		{
			var total:Number = 0;
			var ads:Number = 0;
			for (var ad:String in shop.advert) {
				if (shop.advert[ad] != 0)
				{
					total += shop.advert[ad] * Agent.informationAccess[ad];
					ads++;
				}
			}
			if (ads != 0) {
				return total / ads; 
			}
			return 0;
		}
		
		public function followerTendency(agent:Agent):Number
		{
			// lambda value 30
			return agent.influenceWeight;
		}
						
		public function influence(agent:Agent):Number
		{
			return agent.remainingInfluence;
		}
		
	}

}