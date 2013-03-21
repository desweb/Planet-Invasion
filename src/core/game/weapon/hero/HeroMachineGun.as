package core.game.weapon.hero 
{
	import core.Common;
	import core.GameState;
	import core.game.weapon.MachineGun;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMachineGun extends MachineGun
	{
		public function HeroMachineGun()
		{
			if (Common.IS_DEBUG) trace('create HeroMachineGun');
			
			owner	= GameState.game.hero;
			targetX	= GameState.stageWidth + 100;
			
			super();
		}
	}
}