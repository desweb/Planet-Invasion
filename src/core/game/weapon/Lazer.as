package core.game.weapon 
{
	import core.GameState;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Lazer extends Weapon
	{
		public function Lazer() 
		{
			graphics.beginFill(0xff0000);
			graphics.drawRoundRect(0, 0, GameState.stageWidth, 10, 2);
			graphics.endFill();
		}
		
		override public function update(e:Event):void 
		{
			super.update(e);
			
			x = owner.x + owner.width;
			y = owner.y + (owner.height / 2);
		}
	}
}