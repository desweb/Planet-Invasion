package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class MachineGun extends Weapon
	{
		public var targetX:int;
		
		public function MachineGun()
		{
			graphics.beginFill(0xffff00);
			graphics.drawRoundRect(0, 0, 10, 5, 2);
			graphics.endFill();
		}
		
		override public function initialize(e:Event):void
		{
			super.initialize(e);
			
			tween = new TweenLite(this, moveSpeed-moveSpeed*(x/targetX), { x:targetX, ease:Linear.easeNone, onComplete:destroy });
		}
	}
}