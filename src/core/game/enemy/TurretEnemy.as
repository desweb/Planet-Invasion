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
		public function TurretEnemy() 
		{
			_life						= 10;
			_collision_damage	= 5;
			_metal					= 5;
			_crystal					= 10;
			_money				= 10;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_graphic = new TurretFlash();
			addChild(_graphic);
			
			_target_x = Tools.random(width, GameState.stageWidth - width);
			
			super();
			
			launchFireTimer();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void 
		{
			rotation = Math.atan2(GameState.game.hero.y - y, GameState.game.hero.x - x) / (Math.PI / 180) - 180;
			
			super.update(e);
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			GameState.game.weapons_container = new GunTurretEnemy(this);
		}
	}
}