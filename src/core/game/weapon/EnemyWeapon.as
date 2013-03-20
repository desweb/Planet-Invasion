package core.game.weapon 
{
	import core.game.enemy.Enemy;
	import flash.events.Event;
	
	/**
	 * Class of weapons of enemies
	 * @author desweb
	 */
	public class EnemyWeapon extends Weapon
	{
		
		public function EnemyWeapon(e:Enemy) 
		{
			// Default position
			startX = e.x + e.width;
			startY = e.y + (e.height/2);
		}
		
		override public function update(e:Event):void 
		{
			super.update(e);
			
			if (isKilled) return;
			
			// Hero hit
			if (hitTestObject(GameState.game.hero))
			{
				isKilled = true;
				
				GameState.game.hero.destroy();
				destroy();
			}
		}
	}
}