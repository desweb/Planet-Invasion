package core.game.weapon 
{
	import core.game.Hero;
	import core.game.enemy.Enemy;
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
		
		public var moveSpeed:Number = 2;
		
		public var tween:TweenLite;
		
		public var owner:Sprite;
		
		public function Weapon()
		{
			// Default position
			if (owner)
			{
				if		(owner is Hero)		x = owner.x + owner.width;
				else if	(owner is Enemy)	x = owner.x - 25;
				
				y = owner.y + (owner.height / 2);
			}
			
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
			
			if (owner)
			{
				if		(owner is Hero)		heroUpdate();
				else if	(owner is Enemy)	enemyUpdate();
			}
		}
		
		private function heroUpdate():void
		{
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.isKilled || !hitTestObject(e_hit)) continue;
				
				e_hit.destroy();
				destroy();
			}
		}
		
		private function enemyUpdate():void
		{
			// Hero hit
			if (hitTestObject(GameState.game.hero))
			{
				GameState.game.hero.destroy();
				destroy();
			}
		}
		
		// Destroy
		public function destroy():void
		{
			if (_isKilled) return;
			
			_isKilled = true;
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			if (tween)
			{
				tween.pause();
				tween.kill();
			}
			
			GameState.game.weaponsContainer.removeChild(this);
		}
	}
}