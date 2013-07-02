package core.game.enemy 
{
	import flash.events.TimerEvent;
	
	import core.Common;
	import core.game.weapon.enemy.EnemyGun;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeavyFighterEnemy extends Enemy
	{
		public function HeavyFighterEnemy() 
		{
			_life			= 100;
			_metal		= 3;
			_crystal		= 1;
			_money	= 2;
			
			_graphic = new FighterHeavyFlash();
			addChild(_graphic);
			
			super();
			
			_propellant.x += 5;
			_propellant_scale = .5;
			
			rotation = 180;
			
			launchFireTimer();
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			new EnemyGun(Common.FIRE_MIDDLE_LEFT,	this);
			new EnemyGun(Common.FIRE_MIDDLE_RIGHT,	this);
		}
	}
}