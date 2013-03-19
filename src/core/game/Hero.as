package core.game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	import core.game.weapon.HeroMachineGun;
	import core.scene.Scene;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Hero extends Sprite
	{
		private var _speedFire:int			= .5;
		private var _speedFireTimer:Number	= 0;
		
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
			
			if (_speedFireTimer > 0) _speedFireTimer -= dt;
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
			if (_speedFireTimer > 0) return;
			
			_speedFireTimer = _speedFire;
			
			var machineGun:HeroMachineGun = new HeroMachineGun();
			GameState.game.addChild(machineGun);
			
			GameState.game.heroMachineGuns[GameState.game.heroMachineGuns.length] = machineGun;
		}
		
		private function fireLazer():void
		{
			trace('fireLazer !');
		}
		
		private function fireMissile():void
		{
			trace('fireMissile !');
		}
		
		private function fireMissileHoming():void
		{
			trace('fireMissileHoming !');
		}
		
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
	}
}