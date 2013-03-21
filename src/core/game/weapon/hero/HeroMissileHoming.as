package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.MissileHoming;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissileHoming extends MissileHoming
	{
		public function HeroMissileHoming()
		{
			if (Common.IS_DEBUG) trace('create HeroMissileHoming');
			
			owner = GameState.game.hero;
			
			super();
		}
		
		override public function initialize(e:Event):void
		{
			// Research target enemy
			for each(var eTarget:Enemy in GameState.game.enemies)
			{
				if (eTarget && eTarget.isKilled) continue;
				
				if (!target || (eTarget.x < target.x && eTarget.x > GameState.game.hero.x + GameState.game.hero.width))
				{
					isTraget = true;
					target = eTarget;
				}
			}
			
			super.initialize(e);
		}
	}
}