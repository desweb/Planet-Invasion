package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMachineGun extends HeroWeapon
	{
		public function HeroMachineGun()
		{
			graphics.beginFill(0xffff00);
			graphics.drawRoundRect(0, 0, 10, 5, 2);
			graphics.endFill();
		}
		
		override public function initialize(e:Event):void
		{
			super.initialize(e);
			
			tween = new TweenLite(this, moveSpeed-moveSpeed*(x/GameState.stageWidth), { x:GameState.stageWidth+100, onComplete:destroy });
		}
	}
}