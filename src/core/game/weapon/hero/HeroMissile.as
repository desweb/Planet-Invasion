package core.game.weapon.hero 
{
	import core.Common;
	import core.GameState;
	import core.game.weapon.Missile;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissile extends Missile
	{
		
		public function HeroMissile()
		{
			if (Common.IS_DEBUG) trace('create HeroMissile');
			
			owner	= GameState.game.hero;
			targetX	= GameState.stageWidth + 100;
			
			super();
		}
	}
}