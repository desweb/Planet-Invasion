package core.game 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.game.enemy.Enemy;
	import core.game.enemy.TransporterEnemy;
	import core.game.item.AttackItem;
	import core.game.item.CrystalItem;
	import core.game.item.DefenseItem;
	import core.game.item.GoldItem;
	import core.game.item.Item;
	import core.game.item.MetalItem;
	import core.game.item.SpeedItem;
	import core.game.weapon.Weapon;
	import core.popup.LoosePopup;
	import core.popup.VictoryPopup;
	import core.scene.SceneManager;
	import core.utils.Tools;
	
	/**
	 * Container of the game scene
	 * @author desweb
	 */
	public class Game extends Sprite
	{
		// Init
		protected var _is_pause:Boolean = false;
		private var _current_game_key:String;
		protected var _current_level:int;
		protected var _is_finish:Boolean = false;
		
		// Time
		private		var _t	:int;
		protected	var _dt	:Number;
		private		var _timer:Timer = new Timer(1000);
		protected	var _total_time:Number = 0;
		
		// Containers
		private var _hero_container			:Sprite = new Sprite();
		private var _items_container			:Sprite = new Sprite();
		private var _enemies_container		:Sprite = new Sprite();
		private var _transporters_container	:Sprite = new Sprite();
		private var _weapons_container		:Sprite = new Sprite();
		private var _powers_container		:Sprite = new Sprite();
		private var _interface_container		:Sprite = new Sprite();
		
		// Interface
		protected var _total_metal			:int;
		protected var _total_crystal		:int;
		protected var _total_money		:int;
		private var _metal_label				:TextField;
		private var _crystal_label			:TextField;
		private var _money_label			:TextField;
		private var _life_bar					:LifeBarFlash;
		private var _life_bar_mask			:LifeBarFlash;
		private var _shield_bar				:ShieldBarFlash;
		private var _shield_bar_mask		:ShieldBarFlash;
		private var _attack_item_light		:ItemAttackLightFlash;
		private var _crystal_item_light	:ItemCrystalLightFlash;
		private var _defense_item_light	:ItemDefenseLightFlash;
		private var _gold_item_light		:ItemGoldLightFlash;
		private var _metal_item_light		:ItemMetalLightFlash;
		private var _speed_item_light		:ItemSpeedLightFlash;
		
		public var total_boost_pick			:int = 0;
		public var total_boost_attack		:int = 0;
		public var total_boost_speed		:int = 0;
		public var total_boost_resistance	:int = 0;
		
		// Entities
		/*public var enemies		:Vector.<Enemy>		= new Vector.<Enemy>();
		public var weapons	:Vector.<Weapon>	= new Vector.<Weapon>();
		public var items			:Vector.<Item>			= new Vector.<Item>();*/
		public var enemies		:Array = new Array();
		public var weapons	:Array = new Array();
		public var items			:Array = new Array();
		
		// Enemies
		private var _total_enemy_kill		:int			= 0;
		private var _speedEnemy			:int			= 5;
		private var _speedEnemyTimer	:Number	= 2;
		
		// Hero
		protected var _hero:Hero;
		
		// Combo
		private var _current_combo		:uint;
		private var _combo_timer			:uint;
		private var _combo_timer_init		:uint = 5;
		private var _combo_enemy		:uint;
		private var _combo_enemy_init	:uint = 10;
		private var _combo_label			:TextField;
		private var _combo_metal			:uint = 0;
		private var _combo_crystal			:uint = 0;
		private var _combo_money		:uint = 0;
		
		/**
		 * Constructor
		 */
		
		public function Game(game_key:String) 
		{
			_current_game_key = game_key;
			
			GameState.game = this;
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		public function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			Mouse.hide();
			
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
			interface_format.bold		= true;
			interface_format.align	= 'center';
			
			// Metal
			_metal_label = new TextField();
			_metal_label.x							= 110;
			_metal_label.y							= 10;
			_metal_label.width						= 80;
			_metal_label.height					= 30;
			_metal_label.defaultTextFormat	= interface_format;
			_metal_label.selectable				= false;
			interface_container = _metal_label;
			
			// Crytal
			_crystal_label = new TextField();
			_crystal_label.x							= 200;
			_crystal_label.y							= _metal_label.y;
			_crystal_label.width					= _metal_label.width;
			_crystal_label.height					= _metal_label.height;
			_crystal_label.defaultTextFormat	= interface_format;
			_crystal_label.selectable				= false;
			interface_container = _crystal_label;
			
			// Money
			_money_label = new TextField();
			_money_label.x							= 300;
			_money_label.y							= _metal_label.y;
			_money_label.width					= _metal_label.width;
			_money_label.height					= _metal_label.height;
			_money_label.defaultTextFormat	= interface_format;
			_money_label.selectable				= false;
			interface_container = _money_label;
			
			metal	= 0;
			crystal	= 0;
			money	= 0;
			
			// Combo
			var combo_format:TextFormat = Common.getPolicy('Arial', 0xFFFF00, 10);
			combo_format.bold	= true;
			combo_format.align	= 'center';
			
			_combo_label = new TextField();
			_combo_label.x							= 400;
			_combo_label.y							= _metal_label.y;
			_combo_label.width					= _metal_label.width;
			_combo_label.height					= _metal_label.height;
			_combo_label.defaultTextFormat	= combo_format;
			_combo_label.selectable				= false;
			interface_container = _combo_label;
			
			initCombo();
			
			// Life bars
			_life_bar_mask = new LifeBarFlash();
			_life_bar_mask.x = 10;
			_life_bar_mask.y = 10;
			interface_container = _life_bar_mask;
			
			_life_bar = new LifeBarFlash();
			_life_bar.x = _life_bar_mask.x;
			_life_bar.y = _life_bar_mask.y;
			_life_bar.mask = _life_bar_mask;
			interface_container = _life_bar;
			
			// Hero
			_hero = new Hero();
			
			if (GameState.game.hero.shield_life_init)
			{
				_shield_bar_mask = new ShieldBarFlash();
				_shield_bar_mask.x = 10;
				_shield_bar_mask.y = 30;
				interface_container = _shield_bar_mask;
				
				_shield_bar = new ShieldBarFlash();
				_shield_bar.x = _shield_bar_mask.x;
				_shield_bar.y = _shield_bar_mask.y;
				_shield_bar.mask = _shield_bar_mask;
				interface_container = _shield_bar;
			}
			
			// Item lighter
			_attack_item_light = new ItemAttackLightFlash();
			_attack_item_light.alpha = 0;
			_attack_item_light.x = 120;
			_attack_item_light.y = 30;
			interface_container = _attack_item_light;
			
			_crystal_item_light = new ItemCrystalLightFlash();
			_crystal_item_light.alpha = 0;
			_crystal_item_light.x = 140;
			_crystal_item_light.y = _attack_item_light.y;
			interface_container = _crystal_item_light;
			
			_defense_item_light = new ItemDefenseLightFlash();
			_defense_item_light.alpha = 0;
			_defense_item_light.x = 160;
			_defense_item_light.y = _attack_item_light.y;
			interface_container = _defense_item_light;
			
			_gold_item_light = new ItemGoldLightFlash();
			_gold_item_light.alpha = 0;
			_gold_item_light.x = 180;
			_gold_item_light.y = _attack_item_light.y;
			interface_container = _gold_item_light;
			
			_metal_item_light = new ItemMetalLightFlash();
			_metal_item_light.alpha = 0;
			_metal_item_light.x = 200;
			_metal_item_light.y = _attack_item_light.y;
			interface_container = _metal_item_light;
			
			_speed_item_light = new ItemSpeedLightFlash();
			_speed_item_light.alpha = 0;
			_speed_item_light.x = 220;
			_speed_item_light.y = _attack_item_light.y;
			interface_container = _speed_item_light;
			
			// Timer
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, completeTimer);
			
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
			if (_is_pause) return;
			
			_total_time += _dt;
		}
		
		/**
		 * Manage
		 */
		
		public function pause():void
		{
			if (_is_pause) return;
			
			_is_pause = true;
			
			Mouse.show();
			
			_hero.pause();
			
			if (_timer) _timer.stop();
			
			for each(var e:Enemy	in enemies)	e.pause();
			for each(var w:Weapon	in weapons)	w.pause();
			for each(var i:Item		in items)		i.pause();
		}
		
		public function resume():void
		{
			if (!_is_pause) return;
			
			_is_pause = false;
			
			Mouse.hide();
			
			_hero.resume();
			
			if (_timer) _timer.start();
			
			for each(var e:Enemy	in enemies)	e.resume();
			for each(var w:Weapon	in weapons)	w.resume();
			for each(var i:Item		in items)		i.resume();
		}
		
		public function loose():void
		{
			if (_is_finish) return;
			
			_is_finish = true;
			
			Mouse.show();
			
			var loose_popup:LoosePopup = new LoosePopup();
			loose_popup.current_game_key = _current_game_key;
			parent.addChild(loose_popup);
			loose_popup.display();
			
			// Natural death achievement
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_NATURAL_DEATH, 1);
			
			end();
		}
		
		protected function win(is_popup:Boolean = true):void
		{
			if (_is_finish) return;
			
			_is_finish = true;
			
			Mouse.show();
			
			if (is_popup)
			{
				var victory_popup:VictoryPopup = new VictoryPopup();
				parent.addChild(victory_popup);
				victory_popup.display();
			}
			
			end();
		}
		
		protected function end():void
		{
			GameState.user.metal	+= _total_metal;
			GameState.user.crystal	+= _total_crystal;
			GameState.user.money	+= _total_money;
			GameState.user.score	+= _total_metal + _total_crystal + _total_money;
			
			// Metal, crystal & money achievement
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_METAL,		_total_metal);
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_CRYSTAL,	_total_crystal);
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_MONEY,		_total_money);
			
			if (GameState.user.isLog) API.post_userStat(function(response:XML):void { } );
			
			var score:int = _total_metal + _total_crystal + _total_money;
			
			GameState.user.games[_current_game_key]['total_metal']					+= _total_metal;
			GameState.user.games[_current_game_key]['total_crystal']					+= _total_crystal;
			GameState.user.games[_current_game_key]['total_money']					+= _total_money;
			GameState.user.games[_current_game_key]['score']							+= score;
			GameState.user.games[_current_game_key]['total_time']						+= int(_total_time);
			GameState.user.games[_current_game_key]['total_boost_attack']			+= total_boost_attack;
			GameState.user.games[_current_game_key]['total_boost_speed']			+= total_boost_speed;
			GameState.user.games[_current_game_key]['total_boost_resistance']	+= total_boost_resistance;
			
			if (GameState.user.games[_current_game_key]['best_time'] > _total_time || 
				GameState.user.games[_current_game_key]['best_time'] == 0) GameState.user.games[_current_game_key]['best_time'] = int(_total_time);
			
			if (GameState.user.isLog && _current_game_key != Common.GAME_SPECIAL_KEY) API.post_gameKey(_current_game_key, function(response:XML):void { } );
			
			// Serial killer achievement
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_SERIAL_KILLER, _total_enemy_kill);
			
			// Mister booster achievement
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_MISTER_BOOSTER, total_boost_pick);
		}
		
		/**
		 * Destroy
		 */
		
		public function destroy():void
		{
			pause();
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_timer.removeEventListener(TimerEvent.TIMER, completeTimer);
			_timer.stop();
			_timer = null;
			
			_hero.destroy();
			
			for each(var e:Enemy	in enemies)	e.destroy();
			for each(var w:Weapon	in weapons)	w.destroy();
			for each(var i:Item		in items)		i.destroy();
			
			enemies	.splice(0);
			weapons	.splice(0);
			items		.splice(0);
			
			enemies	= null;
			weapons	= null;
			items		= null;
			
			initCombo();
		}
		
		public function destroyElement(s:Sprite):void
		{
			if			(s is Weapon	&& weapons)	weapons	.splice(weapons	.indexOf(s), 1);
			else if	(s is Enemy	&& enemies)	enemies	.splice(enemies	.indexOf(s), 1);
			else if	(s is Item		&& items)		items		.splice(items		.indexOf(s), 1);
			
			s.parent.removeChild(s);
			s = null;
		}
		
		/**
		 * Events
		 */
		
		private function completeTimer(e:TimerEvent):void
		{
			// Combo timer
			_combo_timer--;
			
			if (_combo_timer <= 0) initCombo();
			
			// Random item
			if (Tools.random(0, 10)) return;
			
			switch (Tools.random(0, 5))
			{
				case 0: items_container = new AttackItem		(); break;
				case 1: items_container = new CrystalItem		(); break;
				case 2: items_container = new DefenseItem	(); break;
				case 3: items_container = new GoldItem			(); break;
				case 4: items_container = new MetalItem		(); break;
				case 5: items_container = new SpeedItem		(); break;
			}
		}
		
		/**
		 * Combo
		 */
		
		public function incrementationComboEnemy():void
		{
			_combo_enemy++;
			
			if (_combo_enemy < _combo_enemy_init) return;
			
			_combo_enemy	= 0;
			_combo_timer	= _combo_timer_init;
			
			incrementationCombo();
		}
		
		private function incrementationCombo():void
		{
			_current_combo ++;
			_combo_label.text = 'Combo : x' + _current_combo;
			
			interfaceEffect(_combo_label);
		}
		
		private function initCombo():void
		{
			metal	= _combo_metal	* _current_combo;
			crystal	= _combo_crystal	* _current_combo;
			money	= _combo_money	* _current_combo;
			
			_current_combo	= 0;
			_combo_enemy	= 0;
			_combo_metal	= 0;
			_combo_crystal	= 0;
			_combo_money	= 0;
			_combo_timer	= _combo_timer_init;
			
			_combo_label.text = 'Combo : x' + _current_combo;
		}
		
		/**
		 * Functions
		 */
		
		protected function generateGameBg():void
		{
			var bg:GameBg = new GameBg();
			addChild(bg);
		}
		
		protected function interfaceEffect(label:TextField):void
		{
			TweenLite.to(label, .1, { scaleX : 1.2, scaleY : 1.2, onComplete:interfaceEffectEnd, onCompleteParams:[label] });
		}
		
		private function interfaceEffectEnd(label:TextField):void
		{
			TweenLite.to(label, .1, { scaleX : 1, scaleY : 1 });
		}
		
		public function incrementationEnemyKill():void
		{
			_total_enemy_kill++;
			
			if			(_total_enemy_kill == 1)		SoundManager.getInstance().play(SoundManager.FIRST_BLOOD);
			else if	(_total_enemy_kill == 100)	SoundManager.getInstance().play(SoundManager.UNSTOPPABLE);
			else if	(_total_enemy_kill == 300)	SoundManager.getInstance().play(SoundManager.LEGENDARY);
		}
		
		/**
		 * Getters
		 */
		
		public function get dt							():Number	{ return _dt; }
		public function get is_finish					():Boolean	{ return _is_finish; }
		public function get hero						():Hero		{ return _hero; }
		public function get current_level			():int			{ return _current_level; }
		public function get current_game_key	():String	{ return _current_game_key; }
		public function get metal						():int			{ return _total_metal; }
		public function get crystal					():int			{ return _total_crystal; }
		public function get money					():int			{ return _total_money; }
		public function get total_enemy_kill		():int			{ return _total_enemy_kill; }
		
		/**
		 * Setters
		 */
		
		public function set weapons_container		(value:Weapon)					:void { _weapons_container		.addChild(value); weapons.push(value); }
		public function set hero_container			(value:Hero)						:void { _hero_container				.addChild(value); }
		public function set items_container			(value:Item)						:void { _items_container			.addChild(value); items.push(value); }
		public function set enemies_container		(value:Enemy)					:void { _enemies_container		.addChild(value); enemies.push(value); }
		public function set transporters_container	(value:TransporterEnemy)	:void { _transporters_container	.addChild(value); enemies.push(value); }
		public function set powers_container		(value:Sprite)					:void { _powers_container			.addChild(value); }
		public function set interface_container		(value:DisplayObject)			:void { _interface_container		.addChild(value); }
		
		public function set attack_item	(value:Boolean):void { TweenLite.to(_attack_item_light,	.2, { alpha : value?1 : 0 }); }
		public function set crystal_item	(value:Boolean):void { TweenLite.to(_crystal_item_light,	.2, { alpha : value?1 : 0 }); }
		public function set defense_item	(value:Boolean):void { TweenLite.to(_defense_item_light,	.2, { alpha : value?1 : 0 }); }
		public function set gold_item		(value:Boolean):void { TweenLite.to(_gold_item_light,		.2, { alpha : value?1 : 0 }); }
		public function set metal_item		(value:Boolean):void { TweenLite.to(_metal_item_light,	.2, { alpha : value?1 : 0 }); }
		public function set speed_item		(value:Boolean):void { TweenLite.to(_speed_item_light,	.2, { alpha : value?1 : 0 }); }
		
		public function set metal(value:int):void
		{
			_total_metal += value;
			_metal_label.text = 'Metal : ' + _total_metal;
			
			_combo_metal += value;
			
			if (value > 0) interfaceEffect(_metal_label);
		}
		
		public function set crystal(value:int):void
		{
			_total_crystal += value;
			_crystal_label.text = 'Crystal : ' + _total_crystal;
			
			_combo_crystal += value;
			
			if (value > 0) interfaceEffect(_crystal_label);
		}
		
		public function set money(value:int):void
		{
			_total_money += value;
			_money_label.text = 'Money : ' + _total_money;
			
			_combo_money += value;
			
			if (value > 0) interfaceEffect(_money_label);
		}
		
		public function set life_bar(value:int):void
		{
			TweenLite.to(_life_bar_mask, .2, { scaleX : value / (GameState.game.hero.is_defense_item? GameState.game.hero.life_init * 2: GameState.game.hero.life_init) });
		}
		
		public function set shield_life_bar(value:int):void
		{
			TweenLite.to(_shield_bar_mask, .2, { scaleX : value / (GameState.game.hero.is_defense_item? GameState.game.hero.shield_life_init * 2: GameState.game.hero.shield_life_init) });
		}
	}
}