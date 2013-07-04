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
	import core.scene.SceneManager;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameSurvival extends Game implements IGame
	{
		private var _timer:Timer = new Timer(1000);
		private var _wave_timer1:Timer;
		private var _wave_timer2:Timer;
		
		private var _nb_wave:int = 0;
		
		private var _total_time_adventure:uint = 0;
		private var _time_label:TextField;
		
		public function GameSurvival()
		{
			generateGameBg();
			
			// Interface
			var interface_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 12);
			interface_format.bold		= true;
			interface_format.align	= 'center';
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, completeTimer);
			
			super(Common.GAME_SURVIVAL_KEY);
			
			_time_label = new TextField();
			_time_label.x								= GameState.stageWidth	* .4;
			_time_label.y								= GameState.stageHeight	* .95;
			_time_label.width						= GameState.stageWidth	* .2;
			_time_label.defaultTextFormat	= interface_format;
			_time_label.selectable				= false;
			interface_container = _time_label;
			
			updateTimeLabel();
		}
		
		/**
		 * Override
		 */
		
		override public function pause():void
		{
			super.pause();
			
			if (_timer)				_timer.stop();
			if (_wave_timer1)	_wave_timer1.stop();
			if (_wave_timer2)	_wave_timer2.stop();
		}
		
		override public function resume():void
		{
			super.resume();
			
			if (_timer)				_timer.start();
			if (_wave_timer1)	_wave_timer1.start();
			if (_wave_timer2)	_wave_timer2.start();
		}
		
		override public function destroy():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, completeTimer);
			_timer.stop();
			_timer = null;
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function completeTimer(e:TimerEvent):void
		{
			if (_is_pause) return;
			
			_total_time_adventure++;
			updateTimeLabel();
			
			if (_timer.currentCount % 30 == 0)
			{
				_nb_wave++;
				
				for (var i:int = 0; i < 3 * _nb_wave; i++) createEnemy();
				
				_wave_timer1 = new Timer(2000);
				_wave_timer2 = new Timer(4000);
				
				_wave_timer1.start();
				_wave_timer2.start();
				
				_wave_timer1.addEventListener(TimerEvent.TIMER, function completeTimer1(e:TimerEvent):void
				{
					_wave_timer1.removeEventListener(TimerEvent.TIMER, completeTimer1);
					_wave_timer1.stop();
					_wave_timer1 = null;
					
					for (var i:int = 0; i < 3 * _nb_wave; i++) createEnemy();
				});
				
				_wave_timer2.addEventListener(TimerEvent.TIMER, function completeTimer2(e:TimerEvent):void
				{
					_wave_timer2.removeEventListener(TimerEvent.TIMER, completeTimer2);
					_wave_timer2.stop();
					_wave_timer2 = null;
					
					for (var i:int = 0; i < 3 * _nb_wave; i++) createEnemy();
				});
				
			}
			else createEnemy();
			
			if (_timer.currentCount == 600) SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_SURVIVAL, 1);
		}
		
		/**
		 * Functions
		 */
		
		private function createEnemy():void
		{
			switch (Tools.random(0, 9))
			{
				case 0: new AlienEnemy();				break;
				case 1: new AsteroidEnemy();		break;
				case 2: new CruiserEnemy();			break;
				case 3: new DestroyerEnemy();		break;
				case 4: new HeavyFighterEnemy();	break;
				case 5: new KamikazeEnemy();		break;
				case 6: new LightFighterEnemy();	break;
				case 7: new MineEnemy();				break;
				case 8: new TransporterEnemy();	break;
				case 9: new TurretEnemy();			break;
			}
		}
		
		public function updateTimeLabel():void
		{
			_time_label.text = 'Time : ' + Tools.convertTimeToLabel(_total_time_adventure);
		}
	}
}