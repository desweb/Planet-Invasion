package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.MachineGun;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ReinforcementMachineGun extends MachineGun
	{
		
		public function ReinforcementMachineGun()
		{
			if (Common.IS_DEBUG) trace('create ReinforcementMachineGun');
			
			y = Tools.random(0, GameState.stageHeight);
		}
		
		override public function initialize(e:Event):void
		{
			moveSpeed = .5;
			targetX = GameState.stageWidth + 10;
			
			super.initialize(e);
		}
		
		override public function update(e:Event):void 
		{
			super.update(e);
			
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.isKilled || !hitTestObject(e_hit)) continue;
				
				e_hit.destroy();
				destroy();
			}
		}
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy ReinforcementMachineGun');
			
			super.destroy();
		}
	}
}