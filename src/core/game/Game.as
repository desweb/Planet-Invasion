package core.game 
{
	import core.game.weapon.HeroMachineGun;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	
	/**
	 * Container of the game scene
	 * @author desweb
	 */
	public class Game extends Sprite
	{
		private var _t:int;
		private var _dt:Number;
		
		private var _gameState:GameState;
		
		public var enemies:Array = new Array();
		private var _speedEnemy:int			= 5;
		private var _speedEnemyTimer:Number	= 5;
		
		private var _hero:Hero;
		
		public function Game(type:uint) 
		{
			if (Common.IS_DEBUG) trace('create Game' + type);
			
			GameState.game = this;
			
			_gameState = GameState.getInstance();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			_t = getTimer();
			
			var bg:GameBg = new GameBg();
			addChild(bg);
			
			_hero = new Hero();
			addChild(_hero);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		// Update
		private function onEnterFrame(e:Event):void
		{
			var t:int = getTimer();
			_dt = (t - _t) * 0.001;
			_t = t;
			
			update();
		}
		
		private function update():void
		{
			if (_speedEnemyTimer > 0) _speedEnemyTimer -= _dt;
			
			if (_speedEnemyTimer <= 0)
			{
				_speedEnemyTimer = _speedEnemy;
				
				var new_e:Enemy = new Enemy();
				addChild(new_e);
				
				enemies[enemies.length] = new_e;
			}
		}
		
		/**
		 * Getters
		 */
		public function get dt():Number
		{
			return _dt;
		}
		
		public function get hero():Hero
		{
			return _hero;
		}
		
		/**
		 * Setters
		 */
	}
}