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
		
		// Containers
		public var bg_container					:Sprite = new Sprite();
		public var hero_container				:Sprite = new Sprite();
		public var items_container				:Sprite = new Sprite();
		public var enemies_container			:Sprite = new Sprite();
		public var transporters_container	:Sprite = new Sprite();
		public var weapons_container			:Sprite = new Sprite();
		public var powers_container			:Sprite = new Sprite();
		
		// Enemies
		public var enemies:Array = new Array();
		private var _speedEnemy			:int			= 5;
		private var _speedEnemyTimer	:Number	= 2;
		
		// Hero
		protected var _hero:Hero;
		
		private var _isPaused:Boolean = false;
		
		/**
		 * Constructor
		 */
		
		public function Game() 
		{
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
			addChild(bg_container);
			addChild(weapons_container);
			addChild(hero_container);
			addChild(items_container);
			addChild(enemies_container);
			addChild(transporters_container);
			addChild(powers_container);
			
			// Hero
			_hero = new Hero();
			hero_container.addChild(_hero);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Update
		 */
		
		private function onEnterFrame(e:Event):void
		{
			var t:int = getTimer();
			_dt = (t - _t) * 0.001;
			_t = t;
			
			update();
		}
		
		protected function update():void
		{
			if (_isPaused) return;
			
		}
		
		/**
		 * Manage
		 */
		
		public function pause():void
		{
			_isPaused = true;
			
			Mouse.show();
			
			_hero.pause();
			
			for each(var e:Enemy in enemies) e.pause();
		}
		
		public function resume():void
		{
			_isPaused = false;
			
			Mouse.hide();
			
			_hero.resume();
			
			for each(var e:Enemy in enemies) e.resume();
		}
		
		/**
		 * Destroy
		 */
		
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function destroyElement(sprite:Sprite):void
		{
			sprite.parent.removeChild(sprite);
			sprite = null;
		}
		
		protected function generateGameBg():void
		{
			var bg:GameBg = new GameBg();
			bg_container.addChild(bg);
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