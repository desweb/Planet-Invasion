package core.game 
{
	import core.game.weapon.hero.Bombardment;
	import core.game.weapon.hero.IEM;
	import core.game.weapon.hero.Reinforcement;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.hero.HeroLazer;
	import core.game.weapon.hero.HeroMachineGun;
	import core.game.weapon.hero.HeroMissile;
	import core.game.weapon.hero.HeroMissileHoming;
	import core.scene.Scene;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Hero extends Sprite
	{
		private var _keys:Array = new Array();
		
		private static const KEY_MACHINE_GUN	:String = 'a';
		private static const KEY_LAZER			:String = 'z';
		private static const KEY_MISSILE		:String = 'e';
		private static const KEY_MISSILE_HOMING	:String = 'r';
		private static const KEY_IEM			:String = 's';
		private static const KEY_BOMBARDMENT	:String = 'd';
		private static const KEY_REINFORCEMENT	:String = 'f';
		
		private var _fireMachineGunTimer	:Timer = new Timer(100);
		private var _fireLazerTimer			:Timer = new Timer(1000);
		private var _fireMissileTimer		:Timer = new Timer(1000);
		private var _fireMissileHomingTimer	:Timer = new Timer(1000);
		private var _fireIEMTimer			:Timer = new Timer(5000);
		private var _fireBombardmentTimer	:Timer = new Timer(5000);
		private var _fireReinforcementTimer	:Timer = new Timer(5000);
		
		public function Hero() 
		{
			if (Common.IS_DEBUG) trace('create Hero');
			
			graphics.lineStyle(2, 0x00ffff);
			graphics.beginFill(0xededed);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			_keys[KEY_MACHINE_GUN]		= new Array();
			_keys[KEY_LAZER]			= new Array();
			_keys[KEY_MISSILE]			= new Array();
			_keys[KEY_MISSILE_HOMING]	= new Array();
			_keys[KEY_IEM]				= new Array();
			_keys[KEY_BOMBARDMENT]		= new Array();
			_keys[KEY_REINFORCEMENT]	= new Array();
			
			for (var i:String in _keys)
			{
				_keys[i]['is_down']		= false;
				_keys[i]['is_timer']	= false;
			}
			
			/**
			 * Globals events
			 */
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.addEventListener(KeyboardEvent.KEY_UP,	upKey);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
			
			_fireMachineGunTimer	.addEventListener(TimerEvent.TIMER, enableFireMachineGun);
			_fireLazerTimer			.addEventListener(TimerEvent.TIMER, enableFireLazer);
			_fireMissileTimer		.addEventListener(TimerEvent.TIMER, enableFireMissile);
			_fireMissileHomingTimer	.addEventListener(TimerEvent.TIMER, enableFireMissileHoming);
			_fireIEMTimer			.addEventListener(TimerEvent.TIMER, enableFireIEM);
			_fireBombardmentTimer	.addEventListener(TimerEvent.TIMER, enableFireBombardment);
			_fireReinforcementTimer	.addEventListener(TimerEvent.TIMER, enableFireReinforcement);
		}
		
		// Update
		private function update(e:Event):void
		{
			var dt:Number = GameState.game.dt;
		}
		
		/**
		 * Events
		 */
		private function downKey(e:KeyboardEvent):void
		{
			var keyCode:String = String.fromCharCode(e.charCode);
			
			for (var i:String in _keys)
			{
				if (keyCode == i && !_keys[keyCode]['is_down'] && !_keys[keyCode]['is_timer'])
				{
					_keys[keyCode]['is_down']	= true;
					_keys[keyCode]['is_timer']	= true;
					
					switch (keyCode)
					{
						case KEY_MACHINE_GUN	: fireMachineGun();		break;
						case KEY_LAZER			: fireLazer();			break;
						case KEY_MISSILE		: fireMissile();		break;
						case KEY_MISSILE_HOMING	: fireMissileHoming();	break;
						case KEY_IEM			: fireIEM();			break;
						case KEY_BOMBARDMENT	: fireBombardment();	break;
						case KEY_REINFORCEMENT	: fireReinforcement();	break;
						default: return;
					}
					
					return;
				}
			}
		}
		
		private function upKey(e:KeyboardEvent):void
		{
			switch (String.fromCharCode(e.charCode))
			{
				case KEY_MACHINE_GUN	: _keys[KEY_MACHINE_GUN]['is_down']		= false; break;
				case KEY_LAZER			: _keys[KEY_LAZER]['is_down']			= false; break;
				case KEY_MISSILE		: _keys[KEY_MISSILE]['is_down']			= false; break;
				case KEY_MISSILE_HOMING	: _keys[KEY_MISSILE_HOMING]['is_down']	= false; break;
				case KEY_IEM			: _keys[KEY_IEM]['is_down']				= false; break;
				case KEY_BOMBARDMENT	: _keys[KEY_BOMBARDMENT]['is_down']		= false; break;
				case KEY_REINFORCEMENT	: _keys[KEY_REINFORCEMENT]['is_down']	= false; break;
				default	: return;
			}
		}
		
		private function mouseMove(e:MouseEvent):void
		{
			TweenLite.to(this, 0.1, { x:GameState.main.mouseX - (width/2), y:GameState.main.mouseY - (height/2) });
		}
		
		private function enableFireMachineGun(e:TimerEvent):void
		{
			_fireMachineGunTimer.stop();
			_fireMachineGunTimer.reset();
			_keys[KEY_MACHINE_GUN]['is_timer'] = false;
			
			if (_keys[KEY_MACHINE_GUN]['is_down']) fireMachineGun();
		}
		
		private function enableFireLazer(e:TimerEvent):void
		{
			_fireLazerTimer.stop();
			_fireLazerTimer.reset();
			_keys[KEY_LAZER]['is_timer'] = false;
			
			if (_keys[KEY_LAZER]['is_down']) fireMachineGun();
		}
		
		private function enableFireMissile(e:TimerEvent):void
		{
			_fireMissileTimer.stop();
			_fireMissileTimer.reset();
			_keys[KEY_MISSILE]['is_timer'] = false;
			
			if (_keys[KEY_MISSILE]['is_down']) fireMissile();
		}
		
		private function enableFireMissileHoming(e:TimerEvent):void
		{
			_fireMissileHomingTimer.stop();
			_fireMissileHomingTimer.reset();
			_keys[KEY_MISSILE_HOMING]['is_timer'] = false;
			
			if (_keys[KEY_MISSILE_HOMING]['is_down']) fireMissileHoming();
		}
		
		private function enableFireIEM(e:TimerEvent):void
		{
			_fireIEMTimer.stop();
			_fireIEMTimer.reset();
			_keys[KEY_IEM]['is_timer'] = false;
			
			if (_keys[KEY_IEM]['is_down']) fireIEM();
		}
		
		private function enableFireBombardment(e:TimerEvent):void
		{
			_fireBombardmentTimer.stop();
			_fireBombardmentTimer.reset();
			_keys[KEY_BOMBARDMENT]['is_timer'] = false;
			
			if (_keys[KEY_BOMBARDMENT]['is_down']) fireBombardment();
		}
		
		private function enableFireReinforcement(e:TimerEvent):void
		{
			_fireReinforcementTimer.stop();
			_fireReinforcementTimer.reset();
			_keys[KEY_REINFORCEMENT]['is_timer'] = false;
			
			if (_keys[KEY_REINFORCEMENT]['is_down']) fireReinforcement();
		}
		
		/**
		 * Fire actions
		 */
		private function fireMachineGun():void
		{
			GameState.game.addChild(new HeroMachineGun());
			
			_keys[KEY_MACHINE_GUN]['is_timer'] = true;
			_fireMachineGunTimer.start();
		}
		
		private function fireLazer():void
		{
			GameState.game.addChild(new HeroLazer());
			
			_keys[KEY_LAZER]['is_timer'] = true;
			_fireLazerTimer.start();
		}
		
		private function fireMissile():void
		{
			GameState.game.addChild(new HeroMissile());
			
			_keys[KEY_MISSILE]['is_timer'] = true;
			_fireMissileTimer.start();
		}
		
		private function fireMissileHoming():void
		{
			GameState.game.addChild(new HeroMissileHoming());
			
			_keys[KEY_MISSILE_HOMING]['is_timer'] = true;
			_fireMissileHomingTimer.start();
		}
		
		/**
		 * Specials actions
		 */
		private function fireIEM():void
		{
			GameState.game.addChild(new IEM());
			
			_keys[KEY_IEM]['is_timer'] = true;
			_fireIEMTimer.start();
		}
		
		private function fireBombardment():void
		{
			GameState.game.addChild(new Bombardment());
			
			_keys[KEY_BOMBARDMENT]['is_timer'] = true;
			_fireBombardmentTimer.start();
		}
		
		private function fireReinforcement():void
		{
			GameState.game.addChild(new Reinforcement());
			
			_keys[KEY_REINFORCEMENT]['is_timer'] = true;
			_fireReinforcementTimer.start();
		}
		
		// Destroy
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.removeEventListener(KeyboardEvent.KEY_UP,		upKey);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
			
			_fireMachineGunTimer	.removeEventListener(TimerEvent.TIMER, enableFireMachineGun);
			_fireLazerTimer			.removeEventListener(TimerEvent.TIMER, enableFireLazer);
			_fireMissileTimer		.removeEventListener(TimerEvent.TIMER, enableFireMissile);
			_fireMissileHomingTimer	.removeEventListener(TimerEvent.TIMER, enableFireMissileHoming);
			_fireIEMTimer			.removeEventListener(TimerEvent.TIMER, enableFireIEM);
			_fireBombardmentTimer	.removeEventListener(TimerEvent.TIMER, enableFireBombardment);
			_fireReinforcementTimer	.removeEventListener(TimerEvent.TIMER, enableFireReinforcement);
			
			GameState.game.removeChild(this);
		}
	}
}