package core.game.weapon.enemy 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.Missile;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class EnemyMissile extends Missile
	{
		
		public function EnemyMissile(type:uint, enemy:Enemy)
		{
			_fire_type		= type;
			_owner			= enemy;
			_owner_type	= Common.OWNER_ENEMY;
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_TOP_LEFT				: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_TOP_RIGHT				: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_MIDDLE_DEFAULT	: _target_y = _owner.y; break;
				case Common.FIRE_MIDDLE_LEFT			: _target_y = _owner.y; break;
				case Common.FIRE_MIDDLE_RIGHT		: _target_y = _owner.y; break;
				case Common.FIRE_BOTTOM_DEFAULT	: _target_y = _owner.y + GameState.stageHeight; break;
				case Common.FIRE_BOTTOM_LEFT			: _target_y = _owner.y + GameState.stageHeight; break;
				case Common.FIRE_BOTTOM_RIGHT		: _target_y = _owner.y + GameState.stageHeight; break;
			}
			
			super.initialize(e);
		}
	}
}