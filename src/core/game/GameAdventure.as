package core.game 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.AlienEnemy;
	import core.game.enemy.AsteroidEnemy;
	import core.game.enemy.CruiserEnemy;
	import core.game.enemy.DestroyerEnemy;
	import core.game.enemy.Enemy;
	import core.game.enemy.HeavyFighterEnemy;
	import core.game.enemy.KamikazeEnemy;
	import core.game.enemy.LightFighterEnemy;
	import core.game.enemy.MineEnemy;
	import core.game.enemy.TransporterEnemy;
	import core.game.enemy.TurretEnemy;
	import core.game.item.SpecialItem;
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
		private var _remaining_waves	:uint;
		private var _wave_timer				:uint;
		private var _wave_timer_init		:uint;
		private var _is_last_wave			:Boolean = false;
		private var _wave_label				:TextField;
		
		// Enemies
		private var _nb_enemies:Array = new Array();
		
		// Boss
		private var _is_boss:Boolean = false;
		
		public function GameAdventure(level:int)
		{
			_current_level = level;
			
			generateGameBg();
			
			// Interface
			var interface_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 12);
			interface_format.bold		= true;
			interface_format.align	= 'center';
			
			initializeLevel();
			
			_wave_timer = _wave_timer_init;
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, completeTimer);
			
			if (_current_level == Common.TOTAL_LEVEL) _is_boss = true;
			
			super(Common.GAME_ADVENTURE_KEY);
			
			_wave_label = new TextField();
			_wave_label.x							= GameState.stageWidth * .4;
			_wave_label.y							= GameState.stageHeight * .95;
			_wave_label.width						= GameState.stageWidth * .2;
			_wave_label.defaultTextFormat	= interface_format;
			_wave_label.selectable				= false;
			interface_container = _wave_label;
			
			updateWaveLabel();
		}
		
		/**
		 * Initialize level
		 */
		
		private function initializeLevel():void
		{
			switch(_current_level)
			{
				case 1:
					_total_wave_init		= 3;
					_wave_timer_init	= 30;
					
					_nb_enemies[Common.ASTEROID_ENEMY]			= 5;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 1;
					break;
				case 2:
					_total_wave_init		= 4;
					_wave_timer_init	= 30;
					
					_nb_enemies[Common.ALIEN_ENEMY]					= 2;
					_nb_enemies[Common.CRUISER_ENEMY]			= 1;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 3;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					break;
				case 3:
					_total_wave_init		= 6;
					_wave_timer_init	= 25;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 2;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 3;
					_nb_enemies[Common.KAMIKAZE_ENEMY]			= 1;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.MINE_ENEMY]					= 2;
					break;
				case 4:
					_total_wave_init		= 8;
					_wave_timer_init	= 25;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 2;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.KAMIKAZE_ENEMY]			= 3;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.MINE_ENEMY]					= 2;
					_nb_enemies[Common.TRANSPORTER_ENEMY]	= 1;
					_nb_enemies[Common.TURRET_ENEMY]				= 2;
					break;
				case 5:
					_total_wave_init		= 10;
					_wave_timer_init	= 20;
					
					_nb_enemies[Common.CRUISER_ENEMY]			= 3;
					_nb_enemies[Common.DESTROYER_ENEMY]		= 1;
					_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= 4;
					_nb_enemies[Common.KAMIKAZE_ENEMY]			= 3;
					_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= 5;
					_nb_enemies[Common.MINE_ENEMY]					= 3;
					_nb_enemies[Common.TRANSPORTER_ENEMY]	= 1;
					_nb_enemies[Common.TURRET_ENEMY]				= 2;
					break;
			}
		}
		
		/**
		 * Overrides
		 */
		
		override public function pause():void
		{
			super.pause();
			
			if (_timer) _timer.stop();
		}
		
		override public function resume():void
		{
			super.resume();
			
			if (_timer) _timer.start();
		}
		
		override public function destroy():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, completeTimer);
			_timer.stop();
			_timer = null;
			
			super.destroy();
		}
		
		override protected function win(is_popup:Boolean = true):void
		{
			if (_is_boss)
			{
				launchBossEnemy();
				
				_is_boss = false;
				return;
			}
			
			_is_win = true;
			
			if (GameState.user.level_adventure == Common.TOTAL_LEVEL-1 && _current_level == Common.TOTAL_LEVEL)
			{
				super.win(false);
				SceneManager.getInstance().setCurrentScene(Common.SCENE_FINAL);
			}
			else super.win();
			
			if (GameState.user.level_adventure < _current_level) GameState.user.level_adventure = _current_level;
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
			
			if (_current_level == Common.TOTAL_LEVEL && _timer.currentCount == _total_wave_init * _wave_timer_init - 55) new SpecialItem();
			
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
			
			updateWaveLabel();
			
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
		
		private function launchBossEnemy():void
		{
			for (var i:int = 0; i < 20; i++) new DestroyerEnemy();
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
				case Common.ALIEN_ENEMY					: new AlienEnemy();				break;
				case Common.ASTEROID_ENEMY			: new AsteroidEnemy();			break;
				case Common.CRUISER_ENEMY				: new CruiserEnemy();			break;
				case Common.DESTROYER_ENEMY			: new DestroyerEnemy();		break;
				case Common.HEAVY_FIGHTER_ENEMY	: new HeavyFighterEnemy();	break;
				case Common.KAMIKAZE_ENEMY			: new KamikazeEnemy();		break;
				case Common.LIGHT_FIGHTER_ENEMY	: new LightFighterEnemy();		break;
				case Common.MINE_ENEMY					: new MineEnemy();				break;
				case Common.TRANSPORTER_ENEMY		: new TransporterEnemy();		break;
				case Common.TURRET_ENEMY				: new TurretEnemy();				break;
			}
		}
		
		public function updateWaveLabel():void
		{
			_wave_label.text = 'Remaining waves : ' + (_total_wave_init - _total_wave);
			
			interfaceEffect(_wave_label);
		}
	}
}