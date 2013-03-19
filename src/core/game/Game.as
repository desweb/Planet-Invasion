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
	
	/**
	 * Container of the game scene
	 * @author desweb
	 */
	public class Game extends Sprite
	{
		private var _t:int;
		private var _dt:Number;
		
		private var _gameState:GameState;
		
		private var _enemies:Array = new Array();
		private var _speedEnemy:int			= 5;
		private var _speedEnemyTimer:Number	= 5;
		
		private var _hero:Hero;
		private var _heroMachineGuns:Array = new Array();
		
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
				
				_enemies[_enemies.length] = new_e;
			}
			
			for each(var e_hit:Enemy in _enemies)
			{
				for each(var hmg_hit:HeroMachineGun in _heroMachineGuns)
				{
					if (!e_hit.isKilled && !hmg_hit.isKilled && e_hit.hitTestObject(hmg_hit))
					{
						e_hit	.isKilled = true;
						hmg_hit	.isKilled = true;
						
						hmg_hit	.destroy();
						e_hit	.destroy();
					}
				}
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
		
		public function get heroMachineGuns():Array
		{
			return _heroMachineGuns;
		}
		
		/**
		 * Setters
		 */
	}
}