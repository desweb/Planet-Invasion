package core.game.weapon 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	
	/**
	 * Class of weapons
	 * @author desweb
	 */
	public class Weapon extends Sprite
	{
		private var _isKilled:Boolean = false;
		
		public var dt:Number = 0;
		
		public var damage:int = 1;
		
		public var moveSpeed:int = 2;
		
		public var tween:TweenLite;
		
		public function Weapon() 
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		public function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		// Update
		public function update(e:Event):void
		{
			dt = GameState.game.dt;
		}
		
		// Destroy
		public function destroy():void
		{
			if (_isKilled) return;
			
			_isKilled = true;
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			tween.pause();
			tween.kill();
			
			GameState.game.removeChild(this);
		}
	}
}