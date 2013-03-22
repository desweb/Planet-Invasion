package core.game.weapon.hero 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class IEM extends Sprite
	{
		
		public function IEM()
		{
			if (Common.IS_DEBUG) trace('create IEM');
			
			x = -25;
			y = GameState.stageHeight / 2;
			
			graphics.lineStyle(1, 0xffffff);
			graphics.beginFill(0x00ffff);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			TweenLite.to(this, 1, { x:GameState.stageWidth/2, onComplete:explosion });
		}
		
		private function explosion():void
		{
			TweenLite.to(this, 1, { width:GameState.stageWidth, height:GameState.stageWidth, onComplete:destroy });
		}
		
		private function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy IEM');
			
			GameState.game.removeChild(this);
		}
	}
}