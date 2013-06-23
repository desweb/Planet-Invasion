package core.game 
{
	import core.game.enemy.TransporterEnemy;
	import core.game.item.Item;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.Weapon;
	import core.game.enemy.Enemy;
	import core.popup.LoosePopup;
	import core.popup.VictoryPopup;
	import core.scene.SceneManager;
	
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
		private var _hero_container			:Sprite = new Sprite();
		private var _items_container			:Sprite = new Sprite();
		private var _enemies_container		:Sprite = new Sprite();
		private var _transporters_container	:Sprite = new Sprite();
		private var _weapons_container		:Sprite = new Sprite();
		private var _powers_container		:Sprite = new Sprite();
		private var _interface_container		:Sprite = new Sprite();
		
		// Interface
		private var _total_metal		:int;
		private var _total_crystal	:int;
		private var _total_money	:int;
		private var _metal_label		:TextField;
		private var _crystal_label	:TextField;
		private var _money_label	:TextField;
		
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
			addChild(_weapons_container);
			addChild(_hero_container);
			addChild(_items_container);
			addChild(_enemies_container);
			addChild(_transporters_container);
			addChild(_powers_container);
			addChild(_interface_container);
			
			// Interface
			var interface_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 10);
			
			_metal_label = new TextField();
			_metal_label.x							= 10;
			_metal_label.y							= 10;
			_metal_label.width						= 80;
			_metal_label.height					= 30;
			_metal_label.defaultTextFormat	= interface_format;
			_metal_label.selectable				= false;
			interface_container = _metal_label;
			
			_crystal_label = new TextField();
			_crystal_label.x							= 100;
			_crystal_label.y							= _metal_label.y;
			_crystal_label.width					= _metal_label.width;
			_crystal_label.height					= _metal_label.height;
			_crystal_label.defaultTextFormat	= interface_format;
			_crystal_label.selectable				= false;
			interface_container = _crystal_label;
			
			_money_label = new TextField();
			_money_label.x							= 200;
			_money_label.y							= _metal_label.y;
			_money_label.width					= _metal_label.width;
			_money_label.height					= _metal_label.height;
			_money_label.defaultTextFormat	= interface_format;
			_money_label.selectable				= false;
			interface_container = _money_label;
			
			metal	= 0;
			crystal	= 0;
			money	= 0;
			
			// Hero
			_hero = new Hero();
			hero_container = _hero;
			
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
		
		public function loose():void
		{
			Mouse.show();
			
			for each(var e:Enemy in enemies) e.pause();
			
			var loose_popup:LoosePopup = new LoosePopup();
			parent.addChild(loose_popup);
			loose_popup.display();
			
			GameState.user.metal	+= _total_metal;
			GameState.user.crystal	+= _total_crystal;
			GameState.user.money	+= _total_money;
			
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_METAL,		_total_metal);
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_CRYSTAL,	_total_crystal);
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_MONEY,		_total_money);
		}
		
		protected function win():void
		{
			Mouse.show();
			
			var victory_popup:VictoryPopup = new VictoryPopup();
			parent.addChild(victory_popup);
			victory_popup.display();
			
			GameState.user.metal	+= _total_metal;
			GameState.user.crystal	+= _total_crystal;
			GameState.user.money	+= _total_money;
			
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_METAL,		_total_metal);
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_CRYSTAL,	_total_crystal);
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_MONEY,		_total_money);
		}
		
		/**
		 * Destroy
		 */
		
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_hero.destroy();
			
			for each(var e:Enemy in enemies) e.destroy();
		}
		
		public function destroyElement(s:Sprite):void
		{
			s.parent.removeChild(s);
			s = null;
		}
		
		/**
		 * Functions
		 */
		
		protected function generateGameBg():void
		{
			var bg:GameBg = new GameBg();
			addChild(bg);
		}
		
		/**
		 * Getters
		 */
		
		public function get dt		():Number	{ return _dt; }
		public function get hero	():Hero		{ return _hero; }
		
		/**
		 * Setters
		 */
		
		public function set weapons_container		(value:Weapon)					:void { _weapons_container		.addChild(value); }
		public function set hero_container			(value:Hero)						:void { _hero_container				.addChild(value); }
		public function set items_container			(value:Item)						:void { _items_container			.addChild(value); }
		public function set enemies_container		(value:Enemy)					:void { _enemies_container		.addChild(value); }
		public function set transporters_container	(value:TransporterEnemy)	:void { _transporters_container	.addChild(value); }
		public function set powers_container		(value:Sprite)					:void { _powers_container			.addChild(value); }
		public function set interface_container		(value:DisplayObject)			:void { _interface_container		.addChild(value); }
		
		public function set metal(value:int):void
		{
			_total_metal += value;
			_metal_label.text = 'Metal : ' + _total_metal;
		}
		
		public function set crystal(value:int):void
		{
			_total_crystal += value;
			_crystal_label.text = 'Crystal : ' + _total_crystal;
		}
		
		public function set money(value:int):void
		{
			_total_money += value;
			_money_label.text = 'Money : ' + _total_money;
		}
	}
}