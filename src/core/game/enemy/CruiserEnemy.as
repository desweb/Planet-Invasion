package core.game.enemy 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.enemy.EnemyGun;
	import core.game.weapon.enemy.EnemyMissile;
	import core.utils.Tools;
	
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
			_life = 30;
			_collision_damage = 20;
			
			_graphic = new CruiserFlash();
			addChild(_graphic);
			
			_fire_missile_timer = _fire_missile_timer_init;
			
			super();
			
			launchFireTimer();
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			GameState.game.weapons_container = new EnemyGun(Common.FIRE_MIDDLE_LEFT,	this);
			GameState.game.weapons_container = new EnemyGun(Common.FIRE_MIDDLE_RIGHT,	this);
			
			_fire_missile_timer--;
			
			if (_fire_missile_timer < 1)
			{
				GameState.game.weapons_container = new EnemyMissile(Common.FIRE_TOP_DEFAULT,		this);
				GameState.game.weapons_container = new EnemyMissile(Common.FIRE_BOTTOM_DEFAULT,	this);
				
				_fire_missile_timer = _fire_missile_timer_init;
			}
		}
	}
}