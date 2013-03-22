package core.game.enemy 
{
	import flash.display.Sprite;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.GameState;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Enemy extends Sprite
	{
		public var isKilled:Boolean = false;
		
		private var _tween:TweenLite;
		
		public function Enemy() 
		{
			x = GameState.stageWidth+100;
			y = Tools.random(0, GameState.stageHeight-100)
			
			graphics.lineStyle(2, 0xff0000);
			graphics.beginFill(0xededed);
			graphics.drawRect(0, 0, 50, 50);
			graphics.endFill();
			
			_tween = new TweenLite(this, 10, { x:-100, ease:Linear.easeNone, onComplete:destroy });
		}
		
		public function destroy():void
		{
			if (isKilled) return;
			
			isKilled = true;
			
			if (_tween)
			{
				_tween.pause();
				_tween.kill();
			}
			
			GameState.game.removeChild(this);
		}
	}
}