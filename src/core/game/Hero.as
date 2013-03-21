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
		private var _downKeys:Array = new Array();
		
		private static const KEY_MACHINE_GUN	:String = 'a';
		private static const KEY_LAZER			:String = 'z';
		private static const KEY_MISSILE		:String = 'e';
		private static const KEY_MISSILE_HOMING	:String = 'r';
		private static const KEY_IEM			:String = 's';
		private static const KEY_BOMBARDMENT	:String = 'd';
		private static const KEY_REINFORCEMENT	:String = 'f';
		
		private var _fireMachineGunTimer	:Timer = new Timer(100);
		private var _fireLazerTimer			:Timer = new Timer(5000);
		private var _fireMissileTimer		:Timer = new Timer(5000);
		private var _fireMissileHomingTimer	:Timer = new Timer(500);
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
			
			_downKeys[KEY_MACHINE_GUN]		= false;
			_downKeys[KEY_LAZER]			= false;
			_downKeys[KEY_MISSILE]			= false;
			_downKeys[KEY_MISSILE_HOMING]	= false;
			_downKeys[KEY_IEM]				= false;
			_downKeys[KEY_BOMBARDMENT]		= false;
			_downKeys[KEY_REINFORCEMENT]	= false;
			
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
			
			if (keyCode == KEY_MACHINE_GUN && !_downKeys[KEY_MACHINE_GUN])
			{
				_downKeys[KEY_MACHINE_GUN] = true;
				fireMachineGun();
			}
			else if (keyCode == KEY_LAZER && !_downKeys[KEY_LAZER])
			{
				_downKeys[KEY_LAZER] = true;
				fireLazer();
			}
			else if (keyCode == KEY_MISSILE && !_downKeys[KEY_MISSILE])
			{
				_downKeys[KEY_MISSILE] = true;
				fireMissile();
			}
			else if (keyCode == KEY_MISSILE_HOMING && !_downKeys[KEY_MISSILE_HOMING])
			{
				_downKeys[KEY_MISSILE_HOMING] = true;
				fireMissileHoming();
			}
			else if (keyCode == KEY_IEM && !_downKeys[KEY_IEM])
			{
				trace(_downKeys[KEY_IEM]);
				_downKeys[KEY_IEM] = true;
				fireIEM();
			}
			else if (keyCode == KEY_BOMBARDMENT && !_downKeys[KEY_BOMBARDMENT])
			{
				_downKeys[KEY_BOMBARDMENT] = true;
				fireBombardment();
			}
			else if (keyCode == KEY_REINFORCEMENT && !_downKeys[KEY_REINFORCEMENT])
			{
				_downKeys[KEY_REINFORCEMENT] = true;
				fireReinforcement();
			}
		}
		
		private function upKey(e:KeyboardEvent):void
		{
			switch (String.fromCharCode(e.charCode))
			{
				case KEY_MACHINE_GUN	: _downKeys[KEY_MACHINE_GUN]	= false; break;
				case KEY_LAZER			: _downKeys[KEY_LAZER]			= false; break;
				case KEY_MISSILE		: _downKeys[KEY_MISSILE]		= false; break;
				case KEY_MISSILE_HOMING	: _downKeys[KEY_MISSILE_HOMING]	= false; break;
				case KEY_IEM			: _downKeys[KEY_IEM]			= false; break;
				case KEY_BOMBARDMENT	: _downKeys[KEY_BOMBARDMENT]	= false; break;
				case KEY_REINFORCEMENT	: _downKeys[KEY_REINFORCEMENT]	= false; break;
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
			
			if (_downKeys[KEY_MACHINE_GUN]) fireMachineGun();
		}
		
		private function enableFireLazer(e:TimerEvent):void
		{
			_fireLazerTimer.stop();
			_fireLazerTimer.reset();
			
			if (_downKeys[KEY_MACHINE_GUN]) fireMachineGun();
		}
		
		private function enableFireMissile(e:TimerEvent):void
		{
			_fireMissileTimer.stop();
			_fireMissileTimer.reset();
			
			if (_downKeys[KEY_MACHINE_GUN]) fireMissile();
		}
		
		private function enableFireMissileHoming(e:TimerEvent):void
		{
			_fireMissileHomingTimer.stop();
			_fireMissileHomingTimer.reset();
			
			if (_downKeys[KEY_MACHINE_GUN]) fireMissileHoming();
		}
		
		private function enableFireIEM(e:TimerEvent):void
		{
			_fireIEMTimer.stop();
			_fireIEMTimer.reset();
			
			if (_downKeys[KEY_IEM]) fireIEM();
		}
		
		private function enableFireBombardment(e:TimerEvent):void
		{
			_fireBombardmentTimer.stop();
			_fireBombardmentTimer.reset();
			
			if (_downKeys[KEY_BOMBARDMENT]) fireBombardment();
		}
		
		private function enableFireReinforcement(e:TimerEvent):void
		{
			_fireReinforcementTimer.stop();
			_fireReinforcementTimer.reset();
			
			if (_downKeys[KEY_REINFORCEMENT]) fireReinforcement();
		}
		
		/**
		 * Fire actions
		 */
		private function fireMachineGun():void
		{
			GameState.game.addChild(new HeroMachineGun());
			
			_fireMachineGunTimer.start();
		}
		
		private function fireLazer():void
		{
			GameState.game.addChild(new HeroLazer());
			
			_fireLazerTimer.start();
		}
		
		private function fireMissile():void
		{
			GameState.game.addChild(new HeroMissile());
			
			_fireMissileTimer.start();
		}
		
		private function fireMissileHoming():void
		{
			GameState.game.addChild(new HeroMissileHoming());
			
			_fireMissileHomingTimer.start();
		}
		
		/**
		 * Specials actions
		 */
		private function fireIEM():void
		{
			GameState.game.addChild(new IEM());
			
			_fireIEMTimer.start();
		}
		
		private function fireBombardment():void
		{
			GameState.game.addChild(new Bombardment());
			
			_fireBombardmentTimer.start();
		}
		
		private function fireReinforcement():void
		{
			GameState.game.addChild(new Reinforcement());
			
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