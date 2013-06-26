package core.game 
{
	import core.game.enemy.AlienEnemy;
	import core.game.enemy.AsteroidEnemy;
	import core.game.enemy.CruiserEnemy;
	import core.game.enemy.DestroyerEnemy;
	import core.game.enemy.Enemy;
	import core.game.enemy.HeavyFighterEnemy;
	import core.game.enemy.KamikazeEnemy;
	import core.game.enemy.TransporterEnemy;
	import core.game.enemy.TurretEnemy;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.game.enemy.LightFighterEnemy;
	import core.game.enemy.MineEnemy;
	import core.scene.SceneManager;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameAdventure extends Game implements IGame
	{
		private var _is_win:Boolean = false;
		private var _timer:Timer = new Timer(1000);
		
		// Waves
		private var _total_wave				:uint = 0;
		private var _total_wave_init		:uint;
		private var _wave_timer				:uint;
		private var _wave_timer_init		:uint;
		private var _wave_launch_timer	:uint;
		private var _is_last_wave			:Boolean = false;
		
		// Enemies
		private var _nb_enemies:Array = new Array();
		
		public function GameAdventure(level:int)
		{
			_current_level = level;
			
			generateGameBg();
			
			initializeLevel();
			
			_wave_timer = _wave_timer_init;
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, completeTimer);
			
			super(Common.GAME_ADVENTURE_KEY);
		}
		
		/**
		 * Initialize level
		 */
		
		private function initializeLevel():void
		{
			switch(_current_level)
			{
				case 1:
					_total_wave_init			= 3;
					_wave_timer_init		= 30;
					_wave_launch_timer	= 3;
					
					_nb_enemies[Common.ALIEN_ENEMY]			= 2;
					_nb_enemies[Common.ASTEROID_ENEMY]	= 5;
					break;
				case 2:
					_total_wave_init			= 4;
					_wave_timer_init		= 30;
					_wave_launch_timer	= 4;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 5;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					break;
				case 3:
					_total_wave_init			= 6;
					_wave_timer_init		= 25;
					_wave_launch_timer	= 5;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 5;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.KAMIKAZE_ENEMY]			= 5;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.MINE_ENEMY]					= 5;
					break;
				case 4:
					_total_wave_init			= 8;
					_wave_timer_init		= 25;
					_wave_launch_timer	= 6;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 5;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.KAMIKAZE_ENEMY]			= 5;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.MINE_ENEMY]					= 5;
					_nb_enemies[Common.TRANSPORTER_ENEMY]	= 2;
					_nb_enemies[Common.TURRET_ENEMY]				= 3;
					break;
				case 5:
					_total_wave_init			= 10;
					_wave_timer_init		= 20;
					_wave_launch_timer	= 8;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 5;
					_nb_enemies[Common.DESTROYER_ENEMY]		= 2;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.KAMIKAZE_ENEMY]			= 5;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.MINE_ENEMY]					= 5;
					_nb_enemies[Common.TRANSPORTER_ENEMY]	= 2;
					_nb_enemies[Common.TURRET_ENEMY]				= 3;
					break;
			}
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
			super.update();
		}
		
		override public function pause():void
		{
			super.pause();
			
			_timer.stop();
		}
		
		override public function resume():void
		{
			super.resume();
			
			_timer.start();
		}
		
		override public function destroy():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, completeTimer);
			_timer.stop();
			_timer = null;
			
			super.destroy();
		}
		
		override protected function win():void
		{
			_is_win = true;
			
			// Conqueror achievement
			if (GameState.user.level_adventure == 4 && _current_level == 5) SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_CONQUEROR, 1);
			
			if (GameState.user.level_adventure < _current_level) GameState.user.level_adventure = _current_level;
			
			super.win();
		}
		
		/**
		 * Events
		 */
		
		private function completeTimer(e:TimerEvent):void
		{
			if (_is_win) return;
			
			if (_is_last_wave)
			{
				for each(var enemy:Enemy in GameState.game.enemies)
				{
					if (!enemy.is_kill) return;
				}
				
				win();
				return;
			}
			
			if (Tools.random(0, 1)) launchEnemy(Common.ALIEN_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.ASTEROID_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.CRUISER_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.DESTROYER_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.HEAVY_FIGHTER_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.KAMIKAZE_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.LIGHT_FIGHTER_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.MINE_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.TRANSPORTER_ENEMY);
			if (Tools.random(0, 1)) launchEnemy(Common.TURRET_ENEMY);
			
			_wave_timer--;
			
			if (_wave_timer) return;
			
			launchWave();
			
			_wave_timer = _wave_timer_init;
		}
		
		/**
		 * Functions
		 */
		
		private function launchWave():void
		{
			_total_wave++;
			
			launchEnemy(Common.ALIEN_ENEMY);
			launchEnemy(Common.ASTEROID_ENEMY);
			launchEnemy(Common.CRUISER_ENEMY);
			launchEnemy(Common.DESTROYER_ENEMY);
			launchEnemy(Common.HEAVY_FIGHTER_ENEMY);
			launchEnemy(Common.KAMIKAZE_ENEMY);
			launchEnemy(Common.LIGHT_FIGHTER_ENEMY);
			launchEnemy(Common.MINE_ENEMY);
			launchEnemy(Common.TRANSPORTER_ENEMY);
			launchEnemy(Common.TURRET_ENEMY);
			
			if (_total_wave == _total_wave_init) _is_last_wave = true;
		}
		
		private function launchEnemy(type:uint, is_wave:Boolean = false):void
		{
			if (!_nb_enemies[type]) return;
			
			if (is_wave)
			{
				var total:int = Tools.random(1, _nb_enemies[type] * _total_wave);
				
				for (var i:int = 0; i <= total; i++) newEnemy(type);
			}
			else if (Tools.random(0, 1)) newEnemy(type);
		}
		
		private function newEnemy(type:uint):void
		{
			switch (type)
			{
				case Common.ALIEN_ENEMY					: addEnemy(new AlienEnemy());				break;
				case Common.ASTEROID_ENEMY			: addEnemy(new AsteroidEnemy());		break;
				case Common.CRUISER_ENEMY				: addEnemy(new CruiserEnemy());			break;
				case Common.DESTROYER_ENEMY			: addEnemy(new DestroyerEnemy());		break;
				case Common.HEAVY_FIGHTER_ENEMY	: addEnemy(new HeavyFighterEnemy());	break;
				case Common.KAMIKAZE_ENEMY			: addEnemy(new KamikazeEnemy());		break;
				case Common.LIGHT_FIGHTER_ENEMY	: addEnemy(new LightFighterEnemy());	break;
				case Common.MINE_ENEMY					: addEnemy(new MineEnemy());				break;
				case Common.TRANSPORTER_ENEMY		: addEnemy(new TransporterEnemy());	break;
				case Common.TURRET_ENEMY				: addEnemy(new TurretEnemy());			break;
			}
		}
		
		private function addEnemy(e:Enemy):void
		{
			enemies_container = e;
			enemies[enemies.length] = e;
		}
	}
}