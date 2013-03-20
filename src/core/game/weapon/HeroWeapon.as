package core.game.weapon 
{
	import flash.events.Event;
	
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.Hero;
	
	/**
	 * Class of weapons of the hero
	 * @author desweb
	 */
	public class HeroWeapon extends Weapon
	{
		
		public function HeroWeapon() 
		{
			var hero:Hero = GameState.game.hero;
			
			// Default position
			x = hero.x + hero.width;
			y = hero.y + (hero.height/2);
		}
		
		override public function update(e:Event):void 
		{
			super.update(e);
			
			if (isKilled) return;
			
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.isKilled || !hitTestObject(e_hit)) continue;
				
				e_hit.isKilled = true;
				isKilled = true;
				
				e_hit.destroy();
				destroy();
			}
		}
	}
}