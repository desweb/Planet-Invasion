package core 
{
	/**
	 * ...
	 * @author desweb
	 */
	public class Achievement 
	{
		
		public var name			:String;
		public var description	:String;
		
		public function Achievement(key:String) 
		{
			switch (key)
			{
				case Common.ACHIEVEMENT_METAL:
					name			= 'Metal mine';
					description	= 'Get 1000 metal.';
					break;
				case Common.ACHIEVEMENT_CRYSTAL:
					name			= 'Crystal mine';
					description	= 'Get 1000 crystal.';
					break;
				case Common.ACHIEVEMENT_MONEY:
					name			= 'Gold mine';
					description	= 'Get 5000 money.';
					break;
				case Common.ACHIEVEMENT_SERIAL_KILLER:
					name			= 'Serial killer';
					description	= 'Kill 5000 enemies.';
					break;
				case Common.ACHIEVEMENT_NATURAL_DEATH:
					name			= 'Dying is natural';
					description	= 'Die 10 times.';
					break;
				case Common.ACHIEVEMENT_ROADHOG:
					name			= 'Roadhog';
					description	= 'Rush in 10 ennemies.';
					break;
				case Common.ACHIEVEMENT_CONQUEROR:
					name			= 'Conqueror';
					description	= 'Finish the adventure mode.';
					break;
				case Common.ACHIEVEMENT_COOPERATION:
					name			= 'Cooperation';
					description	= 'Finish the duo mode.';
					break;
				case Common.ACHIEVEMENT_SURVIVAL:
					name			= 'Survival';
					description	= 'Stay alive for 5 minutes in the survival mode.';
					break;
				case Common.ACHIEVEMENT_MISTER_BOOSTER:
					name			= 'Mister Booster';
					description	= 'Get 100 boosts.';
					break;
				case Common.ACHIEVEMENT_CURIOSITY:
					name			= 'Curiosity';
					description	= 'Go credits page.';
					break;
				case Common.ACHIEVEMENT_ALIEN_BLAST:
					name			= 'Blasting aliens';
					description	= 'Detonate 5 aliens of the menu.';
					break;
			}
		}
	}
}
