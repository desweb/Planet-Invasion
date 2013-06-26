package core.game.weapon.enemy 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.MissileHoming;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class EnemyMissileHoming extends MissileHoming
	{
		
		public function EnemyMissileHoming(type:uint, enemy:Enemy) 
		{
			_damage = 10;
			
			_fire_type		= type;
			_owner			= enemy;
			_owner_type	= Common.OWNER_ENEMY;
			
			isTraget	= true;
			target		= GameState.game.hero;
			
			_target_x = _owner.x + GameState.stageWidth;
			
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_MIDDLE_DEFAULT	: _target_y = _owner.y; break;
				case Common.FIRE_BOTTOM_DEFAULT	: _target_y = _owner.y + GameState.stageHeight; break;
			}
			
			super();
		}
	}
}