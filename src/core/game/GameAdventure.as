package core.game 
{
	import core.game.enemy.HeavyFighterEnemy;
	import core.game.enemy.KamikazeEnemy;
	import core.game.enemy.TurretEnemy;
	import flash.events.Event;
	
	import core.Common;
	import core.utils.Tools;
	import core.game.enemy.LightFighterEnemy;
	import core.game.enemy.MineEnemy;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameAdventure extends Game implements IGame
	{
		
		public function GameAdventure(level:int)
		{
			if (Common.IS_DEBUG) trace('create GameAdventure ' + level);
			
			generateGameBg();
		}
		
		/**
		 * Overrides
		 */
		
		override public function initialize(e:Event):void
		{
			super.initialize(e);
		}
		
		override protected function update():void
		{
			if (!Tools.random(0, 10))
			{
				var new_e:TurretEnemy = new TurretEnemy();
				enemies_container.addChild(new_e);
				
				enemies[enemies.length] = new_e;
			}
		}
		
		override public function pause():void
		{
			super.pause();
		}
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy GameAdventure');
			
			super.destroy();
		}
	}
}