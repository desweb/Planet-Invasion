package core.game.enemy 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.game.weapon.enemy.GunAlienEnemy;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AlienEnemy extends Enemy
	{
		private var _fire_timer:Timer = new Timer(1000);
		
		public function AlienEnemy() 
		{
			_life						= 50;
			_collision_damage	= 10;
			_metal					= 2;
			_crystal					= 1;
			_money				= 2;
			
			_graphic = new AlienFlash();
			addChild(_graphic);
			
			launchFireTimer();
			
			super(false);
			
			completeFireTimer(null);
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			new GunAlienEnemy(this);
		}
	}
}