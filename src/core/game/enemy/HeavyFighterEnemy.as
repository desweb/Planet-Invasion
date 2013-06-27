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
	public class HeavyFighterEnemy extends Enemy
	{
		public function HeavyFighterEnemy() 
		{
			_life			= 10;
			_metal		= 15;
			_crystal		= 5;
			_money	= 10;
			
			_graphic = new FighterHeavyFlash();
			addChild(_graphic);
			
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
		}
	}
}