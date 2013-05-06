package core.game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	
	/**
	 * Container of the game scene
	 * @author desweb
	 */
	public class Game extends Sprite
	{
		// Time
		private var _t:int;
		protected var _dt:Number;
		
		// Game state
		protected var _gameState:GameState;
		
		// Container
		public var bgContainer			:Sprite = new Sprite();
		public var weaponsContainer	:Sprite = new Sprite();
		public var heroContainer		:Sprite = new Sprite();
		public var itemsContainer		:Sprite = new Sprite();
		public var enemiesContainer	:Sprite = new Sprite();
		public var powersContainer		:Sprite = new Sprite();
		
		// Enemies
		public var enemies:Array = new Array();
		private var _speedEnemy			:int			= 5;
		private var _speedEnemyTimer	:Number	= 2;
		
		// Hero
		protected var _hero:Hero;
		
		public function Game() 
		{
			if (Common.IS_DEBUG) trace('create Game');
			
			GameState.game = this;
			
			_gameState = GameState.getInstance();
			
			Mouse.hide();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		public function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			_t = getTimer();
			
			// Containers
			addChild(bgContainer);
			addChild(weaponsContainer);
			addChild(heroContainer);
			addChild(itemsContainer);
			addChild(enemiesContainer);
			addChild(powersContainer);
			
			// Hero
			_hero = new Hero();
			_hero.x = 550;
			_hero.y = 100;
			heroContainer.addChild(_hero);
			
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
				
				for (var i:int = 0; i < 10; i++)
				{
					var new_e:Enemy = new Enemy();
					enemiesContainer.addChild(new_e);
					
					enemies[enemies.length] = new_e;
				}
			}
		}
		
		public function pause():void
		{
			
		}
		
		public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy Game');
			
			
		}
		
		protected function generateGameBg():void
		{
			var bg:GameBg = new GameBg();
			bgContainer.addChild(bg);
		}
		
		/**
		 * Getters
		 */
		
		public function get dt		():Number	{ return _dt; }
		public function get hero	():Hero		{ return _hero; }
		
		/**
		 * Setters
		 */
	}
}