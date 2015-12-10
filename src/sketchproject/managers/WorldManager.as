package sketchproject.managers
{
	import sketchproject.core.Data;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	import sketchproject.modules.RuleTracer;
	import sketchproject.modules.states.VacationState;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;
	import sketchproject.utilities.GameUtils;
	
	public class WorldManager
	{
		public static var instance:WorldManager;
		
		public var map:Map;
		public var listAgents:Array;
		public var listShop:Array;
		
		private var agent:Agent;		
		private var agentGenerator:AgentGenerator;		
		private var ruleTracer:RuleTracer;
		private var delay:uint;
		
		private var generateProbability:Number;
		private var dx:Number;
		private var dy:Number;		
		
		private var change:int = 0;
		
		public function WorldManager(map:Map, isSimulation:Boolean)
		{
			WorldManager.instance = this;
			this.map = map;
			
			listAgents = new Array();
			listShop = new Array();
			
			agentGenerator = new AgentGenerator();
			
			if(isSimulation){				
				agentGenerator.generateAgent(listAgents, listShop, map);
				
				ruleTracer = new RuleTracer();
				ruleTracer.initialize(listAgents, map);
			}
			else{
				agentGenerator.generateFreeman(listAgents, 100, map);
			}
			
			delay = 0;
		}
					
		
		public function update():void
		{			
			for(var i:uint; i<listAgents.length; i++){
				agent = listAgents[i] as Agent;
				agent.update();
				
				if(delay++%10==0){
					/*if(actionEvaluationAgainstDay(agent) && actionEvaluationAgainstWeather(agent))
					{
						trace(agent.role,"agent do main task");
						agent.isGoingTask = true;
					}*/
					//mainRoleRule(agent, map.hour, map.minute);
					if(eventEvaluation(agent)){
						trace(agent.role,"visit event");
					}
					delay = 0;
				}
				
				/*
				trace(change);
				if(change++ == 1200)
				{
					trace("-------------vacation");
					//agent.action.popState();
					agent.action.pushState(agent.vacationAction);
					trace("------state "+agent.action.getCurrentState().toString());
				}
				else if(change++ == 4000)
				{
					trace("-------------pop vacation, back wandering");
					agent.action.popState();	
					trace("------state "+agent.action.getCurrentState().toString());
				}
				*/
			}
		}
		
		public function mainRoleRule(agent:Agent, hour:int, minute:int):void
		{
			if(!agent.mainRoleDone)
			{
				// student
				if(hour == 7 && agent.role == Agent.ROLE_STUDENT)
				{
					agent.action.pushState(agent.studyingAction);
				}
				else if(hour == 13 && agent.role == Agent.ROLE_STUDENT)
				{
					agent.action.checkState(agent.studyingAction, true);
					agent.action.pushState(agent.homewardAction);
				}
				
				// worker
				if(hour == 8 && agent.role == Agent.ROLE_WORKER)
				{
					agent.action.pushState(agent.workingAction);
				}
				else if(hour == 15 && agent.role == Agent.ROLE_WORKER)
				{
					agent.action.checkState(agent.workingAction, true);
					agent.action.pushState(agent.homewardAction);
				}
				
				// trader
				if(hour == 9 && agent.role == Agent.ROLE_TRADER)
				{
					agent.action.pushState(agent.tradingAction);
				}
				else if(hour == 17 && agent.role == Agent.ROLE_TRADER)
				{
					agent.action.checkState(agent.tradingAction, true);
					agent.action.pushState(agent.homewardAction);
				}
			}			
		}
		
		public function actionEvaluationAgainstDay(agent:Agent):Boolean
		{
			// student
			if(GameUtils.probability(0.08) && agent.role == Agent.ROLE_STUDENT)
			{
				trace(Agent.ROLE_STUDENT,"agent doesn't go because day accidental probability");
				agent.mainRoleDone = true;
				return false;
			}
			else if((DayCounter.isFreeday() || DayCounter.isHoliday()) && agent.role == Agent.ROLE_STUDENT)
			{				
				if(GameUtils.probability(0.1))
				{
					return true;	
				}
				trace(Agent.ROLE_STUDENT,"agent doesn't go because today is freeday or holiday");
				agent.mainRoleDone = true;
				return false;
			}
			
			// worker
			if(GameUtils.probability(0.03) && agent.role == Agent.ROLE_WORKER)
			{
				trace(Agent.ROLE_WORKER,"agent doesn't go because day accidental probability");
				agent.mainRoleDone = true;
				return false;
			}
			else if((DayCounter.isFreeday() || DayCounter.isWeekend()) && agent.role == Agent.ROLE_WORKER)
			{			
				if(GameUtils.probability(0.1))
				{
					return true;	
				}
				trace(Agent.ROLE_WORKER,"agent doesn't go because today is weekend or freeday");
				agent.mainRoleDone = true;
				return false;
			}
			
			// trader
			if(GameUtils.probability(0.05) && agent.role == Agent.ROLE_TRADER)
			{
				trace(Agent.ROLE_TRADER,"agent doesn't go because day accidental probability");
				agent.mainRoleDone = true;
				return false;
			}
			else if((DayCounter.isFreeday() || DayCounter.isWeekend()) && agent.role == Agent.ROLE_TRADER)
			{				
				if(GameUtils.probability(0.1))
				{
					trace(Agent.ROLE_TRADER,"agent doesn't go because accidental probability in weekend or freeday");
					agent.mainRoleDone = true;
					return false;
				}
			}
			return true;
		}
		
		public function actionEvaluationAgainstWeather(agent:Agent):Boolean
		{
			generateProbability = Number(Data.weather[0][5]);
			trace("probability weather",generateProbability);
			if(agent.actionWill > 7){
				generateProbability += 1;
			}
			else if(agent.actionWill > 4){
				generateProbability += 0.7;
			}
			else{
				generateProbability += 0.5;
			}
			
			generateProbability = generateProbability / 2;
			
			if(GameUtils.probability(generateProbability)){
				if(GameUtils.probability(0.1))
				{
					trace(agent.role,"agent doesn't go because 10% weather accidental probability");
					return false;
				}
				return true;
			}
			trace(agent.role,"agent doesn't go because weather against action will probability",generateProbability, agent.actionWill);
			return false;
		}
		
		public function eventEvaluation(agent:Agent):Boolean
		{
			if(map.isEventExist && !agent.isGoingEvent)
			{
				for(var i:int = 0;i < Data.event.length; i++)
				{
					if(map.hour >= Data.event[i][2] && map.hour < Data.event[i][3])
					{
						generateProbability = 30 - (Math.abs(agent.education - Data.event[i][6][0]) + Math.abs(agent.art - Data.event[i][6][1]) + Math.abs(agent.athletic - Data.event[i][6][2]));
						if(GameUtils.randomFor(30) < generateProbability){
							if(GameUtils.probability(0.1))
							{
								trace(agent.role,"agent doesn't go because 10% event accidental probability",generateProbability);
								return false;
							}
							agent.isGoingEvent = true;
							return true;
						}
						else
						{
							trace(agent.role,"agent doesn't go because unmatch enough",generateProbability);
							return false;
						}
					}
				}
			}
			return false;
		}
		
		public function stressEvaluation(agent:Agent):Boolean
		{
			if(agent.stress > 8)
			{
				if(GameUtils.probability(0.1))
				{
					trace(agent.agentId,"agent doesn't playing/vacation because 10% accidental probability");
					return false;
				}
				return true;
			}
			return false;
		}		
		
		public function influenceEvaluation(agent:Agent, listAgent:Array):Boolean
		{
			for (var j:int = 0; j < listAgent.length; j++)
			{
				if(agent.agentId != Agent(listAgent[j]).agentId)
				{
					dx = agent.x - Agent(listAgent[j]).x;
					dy = agent.y - Agent(listAgent[j]).y;
					
					if(GameUtils.getDistance(dx,dy) < 30)
					{
						if(GameUtils.probability(0.3))
						{
							return true;
						}
					}
				}				
			}
			return false;
		}
	}
}