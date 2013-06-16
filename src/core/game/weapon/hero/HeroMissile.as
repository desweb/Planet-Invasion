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
			
			_owner	= GameState.game.hero;
			targetX	= GameState.stageWidth + 100;
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override public function destroy():void 
		{
			if (Common.IS_DEBUG) trace('destroy HeroMissile');
			
			super.destroy();
		}
	}
}