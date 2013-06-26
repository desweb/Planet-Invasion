package core.game 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.Common;
	import core.scene.SceneManager;
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
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameSurvival extends Game implements IGame
	{
		private var _timer:Timer = new Timer(1000);
		
		private var _nb_wave:int = 0;
		
		public function GameSurvival()
		{
			generateGameBg();
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, completeTimer);
			
			super(Common.GAME_SURVIVAL_KEY);
		}
		
		/**
		 * Override
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
		
		/**
		 * Events
		 */
		
		private function completeTimer(e:TimerEvent):void
		{
			if (_timer.currentCount % 30 == 0)
			{
				_nb_wave++;
				
				for (var i:int = 0; i < 3 * _nb_wave; i++) createEnemy();
				
				var timer1:Timer = new Timer(2000);
				var timer2:Timer = new Timer(4000);
				
				timer1.start();
				timer2.start();
				
				timer1.addEventListener(TimerEvent.TIMER, function completeTimer1(e:TimerEvent):void
				{
					timer1.removeEventListener(TimerEvent.TIMER, completeTimer1);
					timer1.stop();
					timer1 = null;
					
					for (var i:int = 0; i < 3 * _nb_wave; i++) createEnemy();
				});
				
				timer2.addEventListener(TimerEvent.TIMER, function completeTimer2(e:TimerEvent):void
				{
					timer2.removeEventListener(TimerEvent.TIMER, completeTimer2);
					timer2.stop();
					timer2 = null;
					
					for (var i:int = 0; i < 3 * _nb_wave; i++) createEnemy();
				});
				
			}
			else createEnemy();
			
			if (_timer.currentCount == 300) SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_SURVIVAL, 1);
		}
		
		/**
		 * Functions
		 */
		
		private function createEnemy():void
		{
			switch (Tools.random(0, 9))
			{
				case 0: addEnemy(new AlienEnemy());			break;
				case 1: addEnemy(new AsteroidEnemy());		break;
				case 2: addEnemy(new CruiserEnemy());		break;
				case 3: addEnemy(new DestroyerEnemy());	break;
				case 4: addEnemy(new HeavyFighterEnemy());break;
				case 5: addEnemy(new KamikazeEnemy());		break;
				case 6: addEnemy(new LightFighterEnemy());	break;
				case 7: addEnemy(new MineEnemy());			break;
				case 8: addEnemy(new TransporterEnemy());	break;
				case 9: addEnemy(new TurretEnemy());			break;
			}
		}
		
		private function addEnemy(e:Enemy):void
		{
			enemies_container = e;
			enemies[enemies.length] = e;
		}
	}
}