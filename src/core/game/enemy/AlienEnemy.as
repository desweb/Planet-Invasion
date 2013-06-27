package core.game.enemy 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.GameState;
	import core.game.Hero;
	import core.game.weapon.enemy.GunAlienEnemy;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AlienEnemy extends Enemy
	{
		private var _fire_timer:Timer = new Timer(1000);
		
		public function AlienEnemy() 
		{
			_life						= 5;
			_collision_damage	= 5;
			_metal					= 10;
			_crystal					= 5;
			_money				= 10;
			
			_graphic = new AlienFlash();
			addChild(_graphic);
			
			launchFireTimer();
			
			super();
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			GameState.game.weapons_container = new GunAlienEnemy(this);
		}
	}
}