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
			_life						= 10;
			_collision_damage	= 5;
			_metal					= 10;
			_crystal					= 5;
			_money				= 10;
			
			_graphic = new AlienFlash();
			addChild(_graphic);
			
			launchFireTimer();
			
			super(false);
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