package core.game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.HeroLazer;
	import core.game.weapon.HeroMachineGun;
	import core.game.weapon.HeroMissile;
	import core.game.weapon.HeroMissileHoming;
	import core.scene.Scene;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Hero extends Sprite
	{
		private var _fireMachineGunTimer	:Timer = new Timer(500);
		private var _fireLazerTimer			:Timer = new Timer(5000);
		private var _fireMissileTimer		:Timer = new Timer(5000);
		private var _fireMissileHomingTimer	:Timer = new Timer(500);
		
		private var _isFireMachineGun	:Boolean = true;
		private var _isFireLazer		:Boolean = true;
		private var _isFireMissile		:Boolean = true;
		private var _isFireMissileHoming:Boolean = true;
		
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
			
			/**
			 * Globals events
			 */
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
			
			_fireMachineGunTimer	.addEventListener(TimerEvent.TIMER, enableFireMachineGun);
			_fireLazerTimer			.addEventListener(TimerEvent.TIMER, enableFireLazer);
			_fireMissileTimer		.addEventListener(TimerEvent.TIMER, enableFireMissile);
			_fireMissileHomingTimer	.addEventListener(TimerEvent.TIMER, enableFireMissileHoming);
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
			switch (String.fromCharCode(e.charCode))
			{
				case 'a': fireMachineGun();			break;
				case 'z': fireLazer();				break;
				case 'e': fireMissile();			break;
				case 'r': fireMissileHoming();		break;
				case 's': launchIEM();				break;
				case 'd': launchBombardment();		break;
				case 'f': launchReinforcement();	break;
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
			
			_isFireMachineGun = true;
		}
		
		private function enableFireLazer(e:TimerEvent):void
		{
			_fireLazerTimer.stop();
			_fireLazerTimer.reset();
			
			_isFireLazer = true;
		}
		
		private function enableFireMissile(e:TimerEvent):void
		{
			_fireMissileTimer.stop();
			_fireMissileTimer.reset();
			
			_isFireMissile = true;
		}
		
		private function enableFireMissileHoming(e:TimerEvent):void
		{
			_fireMissileHomingTimer.stop();
			_fireMissileHomingTimer.reset();
			
			_isFireMissileHoming = true;
		}
		
		/**
		 * Fire actions
		 */
		private function fireMachineGun():void
		{
			if (!_isFireMachineGun) return;
			
			_isFireMachineGun = false;
			
			GameState.game.addChild(new HeroMachineGun());
			
			_fireMachineGunTimer.start();
		}
		
		private function fireLazer():void
		{
			if (!_isFireLazer) return;
			
			_isFireLazer = false;
			
			GameState.game.addChild(new HeroLazer());
			
			_fireLazerTimer.start();
		}
		
		private function fireMissile():void
		{
			if (!_isFireMissile) return;
			
			_isFireMissile = false;
			
			GameState.game.addChild(new HeroMissile());
			
			_fireMissileTimer.start();
		}
		
		private function fireMissileHoming():void
		{
			if (!_isFireMissileHoming) return;
			
			_isFireMissileHoming = false;
			
			GameState.game.addChild(new HeroMissileHoming());
			
			_fireMissileHomingTimer.start();
		}
		
		/**
		 * Specials actions
		 */
		private function launchIEM():void
		{
			trace('launchIEM !');
		}
		
		private function launchBombardment():void
		{
			trace('launchBombardment !');
		}
		
		private function launchReinforcement():void
		{
			trace('launchReinforcement !');
		}
		
		// Destroy
		public function destroy():void
		{
			stage.removeEventListener(Event.ENTER_FRAME,		update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
			
			_fireMachineGunTimer	.removeEventListener(TimerEvent.TIMER, enableFireMachineGun);
			_fireLazerTimer			.removeEventListener(TimerEvent.TIMER, enableFireLazer);
			_fireMissileTimer		.removeEventListener(TimerEvent.TIMER, enableFireMissile);
			_fireMissileHomingTimer	.removeEventListener(TimerEvent.TIMER, enableFireMissileHoming);
			
			GameState.game.removeChild(this);
		}
	}
}