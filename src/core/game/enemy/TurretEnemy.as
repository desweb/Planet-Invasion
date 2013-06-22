package core.game.enemy 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.GameState;
	import core.game.Hero;
	import core.game.weapon.enemy.GunTurretEnemy;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class TurretEnemy extends Enemy
	{
		private var _fire_gun_timer:Timer = new Timer(1000);
		
		public function TurretEnemy() 
		{
			_life = 10;
			_collision_damage = 5;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_graphic = new TurretFlash();
			addChild(_graphic);
			
			_target_x = Tools.random(width, GameState.stageWidth - width);
			
			super();
			
			_fire_gun_timer.addEventListener(TimerEvent.TIMER, completeFireTimer);
			_fire_gun_timer.start();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void 
		{
			rotation = Math.atan2(GameState.game.hero.y - y, GameState.game.hero.x - x) / (Math.PI / 180) - 180;
			
			super.update(e);
		}
		
		override public function destroy():void
		{
			if (is_kill) return;
			
			_fire_gun_timer.stop();
			_fire_gun_timer.removeEventListener(TimerEvent.TIMER, completeFireTimer);
			_fire_gun_timer = null;
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function completeFireTimer(e:TimerEvent):void
		{
			GameState.game.weapons_container.addChild(new GunTurretEnemy(this));
		}
	}
}