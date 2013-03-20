package core.game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.greensock.TweenLite;
	
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
		private var _speedFireMachineGun	:int = .5;
		private var _speedFireLazer			:int = .5;
		private var _speedFireMissile		:int = .5;
		private var _speedFireMissileHoming	:int = .5;
		
		private var _speedFireMachineGunTimer	:Number = 0;
		private var _speedFireLazerTimer		:Number = 0;
		private var _speedFireMissileTimer		:Number = 0;
		private var _speedFireMissileHomingTimer:Number = 0;
		
		public function Hero() 
		{
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
			stage.addEventListener(Event.ENTER_FRAME,		update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
		}
		
		// Update
		private function update(e:Event):void
		{
			var dt:Number = GameState.game.dt;
			
			if (_speedFireMachineGunTimer > 0) _speedFireMachineGunTimer -= dt;
		}
		
		/**
		 * Events
		 */
		private function downKey(e:KeyboardEvent):void
		{
			switch (String.fromCharCode(e.charCode))
			{
				case 'a': fireGun();				break;
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
		
		/**
		 * Fire actions
		 */
		private function fireGun():void
		{
			if (_speedFireMachineGunTimer > 0) return;
			
			_speedFireMachineGunTimer = _speedFireMachineGun;
			
			GameState.game.addChild(new HeroMachineGun());
		}
		
		private function fireLazer():void
		{
			if (_speedFireLazerTimer > 0) return;
			
			_speedFireLazerTimer = _speedFireLazer;
			
			GameState.game.addChild(new HeroLazer());
		}
		
		private function fireMissile():void
		{
			if (_speedFireMissileTimer > 0) return;
			
			_speedFireMissileTimer = _speedFireMissile;
			
			GameState.game.addChild(new HeroMissile());
		}
		
		private function fireMissileHoming():void
		{
			if (_speedFireMissileHomingTimer > 0) return;
			
			_speedFireMissileHomingTimer = _speedFireMissileHoming;
			
			GameState.game.addChild(new HeroMissileHoming());
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
			
			GameState.game.removeChild(this);
		}
	}
}