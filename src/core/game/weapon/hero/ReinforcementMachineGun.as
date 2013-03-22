package core.game.weapon.hero 
{
	import core.Common;
	import core.GameState;
	import core.game.weapon.MachineGun;
	import core.utils.Tools;
	import flash.events.Event;
	
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
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy ReinforcementMachineGun');
			
			super.destroy();
		}
	}
}