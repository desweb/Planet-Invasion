package core.game.enemy 
{
	import flash.events.TimerEvent;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.enemy.EnemyGun;
	import core.game.weapon.enemy.EnemyMissile;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class CruiserEnemy extends Enemy
	{
		private var _fire_missile_timer		:uint;
		private var _fire_missile_timer_init	:uint = 2;
		
		public function CruiserEnemy()
		{
			_life						= 150;
			_collision_damage	= 20;
			_metal					= 3;
			_crystal					= 2;
			_money				= 2;
			
			_graphic = new CruiserFlash();
			addChild(_graphic);
			
			_fire_missile_timer = _fire_missile_timer_init;
			
			super();
			
			_propellant.x -= 1;
			_propellant_scale = .75;
			
			launchFireTimer();
			
			rotation = 180;
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			new EnemyGun(Common.FIRE_MIDDLE_LEFT,	this);
			new EnemyGun(Common.FIRE_MIDDLE_RIGHT,	this);
			
			_fire_missile_timer--;
			
			if (_fire_missile_timer > 0) return;
			
			new EnemyMissile(Common.FIRE_TOP_DEFAULT,		this);
			new EnemyMissile(Common.FIRE_BOTTOM_DEFAULT,	this);
			
			_fire_missile_timer = _fire_missile_timer_init;
		}
	}
}