package core.game.weapon.enemy 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.Laser;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class EnemyLaser extends Laser
	{
		private var _override_owner:Enemy;
		
		public function EnemyLaser(type:uint, enemy:Enemy) 
		{
			_fire_type				= type;
			_owner					= enemy;
			_override_owner	= enemy;
			_owner_type			= Common.OWNER_ENEMY;
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void 
		{
			if (_override_owner.is_kill) destroy();
			
			super.update(e);
		}
	}
}