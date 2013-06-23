package core.game.weapon.hero 
{
	import flash.events.Event;
	
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
			_fire_type		= type;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void 
		{
			if (GameState.game.hero.is_kill) destroy();
			
			super.update(e);
		}
	}
}