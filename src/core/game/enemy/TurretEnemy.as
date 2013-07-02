package core.game.enemy 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	import core.game.weapon.enemy.GunTurretEnemy;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class TurretEnemy extends Enemy
	{
		private var _shield_life:int;
		private var _shield_life_init:int = 100;
		private var _shield:ShieldEnemyFlash;
		
		public function TurretEnemy() 
		{
			_life						= 50;
			_collision_damage	= 5;
			_metal					= 1;
			_crystal					= 2;
			_money				= 2;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_graphic = new TurretFlash();
			addChild(_graphic);
			
			_target_x = Tools.random(width, GameState.stageWidth - width);
			
			super(false);
			
			launchFireTimer();
			
			completeFireTimer(null);
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void 
		{
			if (is_kill) return;
			
			rotation = Math.atan2(GameState.game.hero.y - y, GameState.game.hero.x - x) / (Math.PI / 180);
			
			if (_shield) _shield.rotation += 5;
			
			super.update(e);
		}
		
		override public function hitWeapon(damage:int):void 
		{
			if (!_shield_life)
			{
				super.hitWeapon(damage);
				return;
			}
			
			_shield_life -= damage;
			
			if (_shield_life <= 0)
			{
				_shield_life = 0;
				
				undisplayShield();
			}
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			new GunTurretEnemy(this);
		}
		
		/**
		 * Tweens
		 */
		
		override protected function completeTween():void 
		{
			displayShield();
			
			super.completeTween();
		}
		
		/**
		 * Shield
		 */
		
		private function displayShield():void
		{
			if (_shield) return;
			
			_shield_life = _shield_life_init;
			
			_shield = new ShieldEnemyFlash();
			_shield.scaleX =
			_shield.scaleY = 0;
			addChild(_shield);
			
			TweenLite.to(_shield, .5, { scaleX : 1, scaleY : 1 } );
		}
		
		private function undisplayShield():void
		{
			if (!_shield) return;
			
			_shield_life = 0;
			
			TweenLite.to(_shield, .5, { scaleX : 0, scaleY : 0, onComplete : destroyShield });
		}
		
		private function destroyShield():void
		{
			_shield_life = 0;
			
			if (_shield)
			{
				removeChild(_shield);
				_shield = null;
			}
		}
	}
}