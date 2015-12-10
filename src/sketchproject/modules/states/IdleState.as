package sketchproject.modules.states
{
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.utilities.GameUtils;
	
	import starling.events.Event;
	
	public class IdleState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var counter:int;
		private var counterLimit:int;
		private var action:int;
		private var currentHour:int;
		private var lastHour:int;

		public function IdleState(agent:Agent)
		{
			this.agent = agent;
			this.name = "idle";
			
			this.counter = 0;
			this.counterLimit = 50 + GameUtils.randomFor(50);
			this.action = 0;
		}
		
		public function initialize():void
		{
			trace(agent.agentId+" : onEnter idle transition execute");
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_stand"));
			agent.baseCharacter.loop = false;
			agent.baseCharacter.stop();
						
			agent.baseCharacter.addEventListener(Event.COMPLETE, function(event:Event):void{
				GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_stand"));
			});
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate idle transition execute");
			
			currentHour = WorldManager.instance.map.hour;
			lastHour = currentHour;
			
			this.counter++;
			if(this.counter == counterLimit)
			{
				this.action = GameUtils.randomFor(10);
				if(action > 6)
				{
					agent.facing = (agent.facing == "right")?"left":"right";
					agent.flipFacing();
				}
				else if(action > 4)
				{
					GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_yup"));
					agent.baseCharacter.play();
				}
				else if(action > 2)
				{
					GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_tada"));
					//agent.baseCharacter.setFrameSound(2, Assets.sfxGirlSaysYes);
					agent.baseCharacter.play();
				}
				
				counter = 0;
			}
			
			currentHour = WorldManager.instance.map.hour;
			if(currentHour!=lastHour){
				if(agent.action.checkState(agent.studyingAction))
				{
					agent.stress = GameUtils.randomFor(1, false);
					trace(agent.agentId, agent.role, "agent stress",agent.stress);
				}
				else if(agent.action.checkState(agent.tradingAction))
				{
					agent.stress = GameUtils.randomFor(1, false);
					trace(agent.agentId, agent.role, "agent stress",agent.stress);
				}
				else if(agent.action.checkState(agent.workingAction))
				{
					agent.stress = GameUtils.randomFor(1, false);
					trace(agent.agentId, agent.role, "agent stress",agent.stress);
				}
								
				lastHour = currentHour;
			}			
			
		}
		
		public function destroy():void
		{
			agent.action.checkState(agent.playingAction, true);
			agent.action.checkState(agent.vacationAction, true);
			agent.action.checkState(agent.studyingAction, true);
			agent.action.checkState(agent.workingAction, true);
			agent.action.checkState(agent.tradingAction, true);
			trace(agent.agentId+" : onExit idle transition execute");
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.IdleState";
		}
	}
}