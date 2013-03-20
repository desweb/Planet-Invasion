package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissile extends HeroWeapon
	{
		
		public function HeroMissile()
		{
			var trianglePoints:Vector.<Number> = new Vector.<Number>(6, true);
			trianglePoints[0] = 0;
			trianglePoints[1] = 0;
			trianglePoints[2] = 15;
			trianglePoints[3] = 5;
			trianglePoints[4] = 0;
			trianglePoints[5] = 10;
			
			graphics.beginFill(0xededed);
			graphics.drawTriangles(trianglePoints);
			graphics.endFill();
		}
		
		override public function initialize(e:Event):void
		{
			super.initialize(e);
			
			tween = new TweenLite(this, moveSpeed-moveSpeed*(x/GameState.stageWidth), { x:GameState.stageWidth+100, onComplete:destroy });
		}
	}
}