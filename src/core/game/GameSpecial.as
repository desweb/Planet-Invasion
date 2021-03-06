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
	public class GameSpecial extends Game implements IGame
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
		
		public function GameSpecial(level:int)
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
			
			super(Common.GAME_SPECIAL_KEY);
			
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
			_total_wave_init		= GameState.user.levels[_current_level]['total_wave'];
			_wave_timer_init	= GameState.user.levels[_current_level]['time_between_wave'];
			
			_nb_enemies[Common.ALIEN_ENEMY]					= GameState.user.levels[_current_level]['alien'];
			_nb_enemies[Common.ASTEROID_ENEMY]			= GameState.user.levels[_current_level]['asteroid'];
			_nb_enemies[Common.CRUISER_ENEMY]			= GameState.user.levels[_current_level]['cruiser'];
			_nb_enemies[Common.DESTROYER_ENEMY]		= GameState.user.levels[_current_level]['destroyer'];
			_nb_enemies[Common.HEAVY_FIGHTER_ENEMY]	= GameState.user.levels[_current_level]['heavy_fighter'];
			_nb_enemies[Common.KAMIKAZE_ENEMY]			= GameState.user.levels[_current_level]['kamikaze'];
			_nb_enemies[Common.LIGHT_FIGHTER_ENEMY]	= GameState.user.levels[_current_level]['light_fighter'];
			_nb_enemies[Common.MINE_ENEMY]					= GameState.user.levels[_current_level]['mine'];
			_nb_enemies[Common.TRANSPORTER_ENEMY]	= GameState.user.levels[_current_level]['transporter'];
			_nb_enemies[Common.TURRET_ENEMY]				= GameState.user.levels[_current_level]['turret'];
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
			_is_win = true;
			
			super.win();
		}
		
		/**
		 * Events
		 */
		
		private function completeTimer(e:TimerEvent):void
		{
			if (_is_win || _is_pause) return;
			
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