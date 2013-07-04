package core.game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.GameState;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameBg extends Sprite
	{
		public function GameBg() 
		{
			addChild(new GameBgFlash());
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update (e:Event):void
		{
			if (Tools.random(0, 4)) return;
			
			var star:Sprite = new Sprite();
			star.x = GameState.stageWidth + 1;
			star.y = Tools.random(0, GameState.stageHeight);
			star.graphics.beginFill(0xFFFFFF);
			
			star.graphics.drawCircle(0, 0, Tools.random(1, 2));
			star.graphics.endFill();
			addChild(star);
			
			TweenLite.to(star, Tools.random(1, 3), { x: -10, ease:Linear.easeNone, onComplete:removeStar, onCompleteParams:[star] } );
		}
		
		private function removeStar(s:Sprite):void
		{
			removeChild(s);
			s = null;
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
		}
	}
}