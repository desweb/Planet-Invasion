package core.game.enemy 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.enemy.EnemyGun;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class LightFighterEnemy extends Enemy
	{
		private var _fire_gun_timer:Timer = new Timer(1000);
		
		public function LightFighterEnemy() 
		{
			_life = 10;
			
			_graphic = new FighterLightFlash();
			addChild(_graphic);
			
			_fire_gun_timer.addEventListener(TimerEvent.TIMER, completeFireTimer);
			_fire_gun_timer.start();
		}
		
		/**
		 * Overrides
		 */
		
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
			GameState.game.weapons_container.addChild(new EnemyGun(Common.FIRE_MIDDLE_DEFAULT, this));
		}
	}
}