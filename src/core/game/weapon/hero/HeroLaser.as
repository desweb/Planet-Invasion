package core.game.weapon.hero 
{
	import core.Common;
	import core.GameState;
	import core.game.weapon.Laser;
	
	/**
	 * Basic class of weapons of the hero
	 * @author desweb
	 */
	public class HeroLaser extends Laser
	{
		
		public function HeroLaser(type:uint)
		{
			if (Common.IS_DEBUG) trace('create HeroLazer');
			
			_fire_type		= type;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override public function destroy():void 
		{
			if (Common.IS_DEBUG) trace('destroy HeroLazer');
			
			super.destroy();
		}
	}
}