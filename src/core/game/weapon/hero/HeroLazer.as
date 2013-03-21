package core.game.weapon.hero 
{
	import core.Common;
	import core.GameState;
	import core.game.weapon.Lazer;
	
	/**
	 * Basic class of weapons of the hero
	 * @author desweb
	 */
	public class HeroLazer extends Lazer
	{
		
		public function HeroLazer()
		{
			if (Common.IS_DEBUG) trace('create HeroLazer');
			
			owner = GameState.game.hero;
			
			super();
		}
	}
}