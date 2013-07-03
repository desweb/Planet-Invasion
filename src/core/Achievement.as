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
		public var score			:int;
		
		public function Achievement(key:String) 
		{
			switch (key)
			{
				case Common.ACHIEVEMENT_METAL:
					name			= 'Metal mine';
					description	= 'Get 1000 metal.';
					score			= 1000;
					break;
				case Common.ACHIEVEMENT_CRYSTAL:
					name			= 'Crystal mine';
					description	= 'Get 1000 crystal.';
					score			= 1000;
					break;
				case Common.ACHIEVEMENT_MONEY:
					name			= 'Gold mine';
					description	= 'Get 5000 money.';
					score			= 5000;
					break;
				case Common.ACHIEVEMENT_SERIAL_KILLER:
					name			= 'Serial killer';
					description	= 'Kill 5000 enemies.';
					score			= 5000;
					break;
				case Common.ACHIEVEMENT_NATURAL_DEATH:
					name			= 'Dying is natural';
					description	= 'Die 10 times.';
					score			= 10;
					break;
				case Common.ACHIEVEMENT_ROADHOG:
					name			= 'Roadhog';
					description	= 'Rush in 10 ennemies.';
					score			= 10;
					break;
				case Common.ACHIEVEMENT_CONQUEROR:
					name			= 'Conqueror';
					description	= 'Finish the adventure mode.';
					score			= 1;
					break;
				case Common.ACHIEVEMENT_COOPERATION:
					name			= 'Cooperation';
					description	= 'Finish the duo mode.';
					score			= 1;
					break;
				case Common.ACHIEVEMENT_SURVIVAL:
					name			= 'Survival';
					description	= 'Stay alive for 10 minutes in the survival mode.';
					score			= 1;
					break;
				case Common.ACHIEVEMENT_MISTER_BOOSTER:
					name			= 'Mister Booster';
					description	= 'Get 100 boosts.';
					score			= 100;
					break;
				case Common.ACHIEVEMENT_CURIOSITY:
					name			= 'Curiosity';
					description	= 'Go credits page.';
					score			= 1;
					break;
				case Common.ACHIEVEMENT_ALIEN_BLAST:
					name			= 'Blasting aliens';
					description	= 'Detonate 5 aliens of the menu.';
					score			= 5;
					break;
			}
		}
	}
}
