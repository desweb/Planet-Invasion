package core.game.enemy 
{
	import core.game.weapon.enemy.EnemyLaser;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.enemy.EnemyGun;
	import core.game.weapon.enemy.EnemyMissile;
	import core.game.weapon.enemy.EnemyMissileHoming;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class DestroyerEnemy extends Enemy
	{
		private var _fire_timer								:Timer = new Timer(1000);
		private var _fire_laser_timer						:uint;
		private var _fire_missile_timer					:uint;
		private var _fire_missile_homing_timer		:uint;
		private var _fire_laser_timer_init					:uint = 15;
		private var _fire_missile_timer_init				:uint = 2;
		private var _fire_missile_homing_timer_init	:uint = 5;
		
		public function DestroyerEnemy() 
		{
			_life = 30;
			_collision_damage = 20;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_graphic = new DestroyerFlash();
			addChild(_graphic);
			
			_fire_laser_timer					= _fire_laser_timer_init;
			_fire_missile_timer					= _fire_missile_timer_init;
			_fire_missile_homing_timer	= _fire_missile_homing_timer_init;
			
			_target_x = Tools.random(width + GameState.stageWidth * .5, GameState.stageWidth);
			
			super();
			
			_fire_timer.addEventListener(TimerEvent.TIMER, completeFireTimer);
			_fire_timer.start();
		}
		
		/**
		 * Overrides
		 */
		
		override public function destroy():void 
		{
			_fire_timer.addEventListener(TimerEvent.TIMER, completeFireTimer);
			_fire_timer.stop();
			_fire_timer = null;
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function completeFireTimer(e:TimerEvent):void
		{
			GameState.game.weapons_container.addChild(new EnemyGun(Common.FIRE_MIDDLE_LEFT,		this));
			GameState.game.weapons_container.addChild(new EnemyGun(Common.FIRE_MIDDLE_RIGHT,	this));
			
			_fire_laser_timer--;
			_fire_missile_timer--;
			_fire_missile_homing_timer--;
			
			if (_fire_laser_timer < 1)
			{
				GameState.game.weapons_container.addChild(new EnemyLaser(Common.FIRE_MIDDLE_DEFAULT, this));
				
				_fire_laser_timer = _fire_laser_timer_init;
			}
			
			if (_fire_missile_timer < 1)
			{
				GameState.game.weapons_container.addChild(new EnemyMissile(Common.FIRE_TOP_DEFAULT,			this));
				GameState.game.weapons_container.addChild(new EnemyMissile(Common.FIRE_BOTTOM_DEFAULT,	this));
				
				_fire_missile_timer = _fire_missile_timer_init;
			}
			
			if (_fire_missile_homing_timer < 1)
			{
				GameState.game.weapons_container.addChild(new EnemyMissileHoming(Common.FIRE_TOP_DEFAULT,			this));
				GameState.game.weapons_container.addChild(new EnemyMissileHoming(Common.FIRE_BOTTOM_DEFAULT,	this));
				
				_fire_missile_homing_timer = _fire_missile_homing_timer_init;
			}
		}
	}
}