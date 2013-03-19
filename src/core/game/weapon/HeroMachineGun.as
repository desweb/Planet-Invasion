package core.game.weapon 
{
	import core.game.Hero;
	import flash.display.Sprite;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMachineGun extends Sprite
	{
		public var isKilled:Boolean = false;
		
		private var _speed:int = 1;
		private var _tween:TweenLite;
		
		public function HeroMachineGun() 
		{
			var hero:Hero = GameState.game.hero;
			
			var startX:int = hero.x + hero.width;
			var startY:int = hero.y + (hero.height/2);
			
			graphics.beginFill(0xffff00);
			graphics.drawRoundRect(startX, startY, 10, 5, 2);
			graphics.endFill();
			
			_tween = new TweenLite(this, _speed-_speed*(startX/GameState.stageWidth), { x:GameState.stageWidth+100, onComplete:destroy });
		}
		
		public function destroy():void
		{
			_tween.pause();
			_tween.kill();
			
			GameState.game.removeChild(this);
		}
	}
}