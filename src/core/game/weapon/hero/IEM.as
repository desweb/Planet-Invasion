package core.game.weapon.hero 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.AsteroidEnemy;
	import core.game.enemy.Enemy;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class IEM extends IemFlash
	{
		
		public function IEM()
		{
			x = -25;
			y = GameState.stageHeight / 2;
			
			scaleX =
			scaleY = .1;
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			TweenLite.to(this, 1, { x:GameState.stageWidth/2, rotation:-360, onComplete:explosion });
		}
		
		private function explosion():void
		{
			TweenLite.to(this, 1, { scaleX:1, scaleY:1, onComplete:stopEnemies });
		}
		
		private function stopEnemies():void
		{
			visible = false;
			
			for each (var e:Enemy in GameState.game.enemies)
			{
				if (e is AsteroidEnemy) continue;
				
				e.pause();
			}
			
			TweenLite.to(this, 3, { onComplete:relaunchEnemies });
		}
		
		private function relaunchEnemies():void
		{
			for each (var e:Enemy in GameState.game.enemies) e.resume();
			
			destroy();
		}
		
		private function destroy():void
		{
			parent.removeChild(this);
		}
	}
}