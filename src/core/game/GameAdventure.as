package core.game 
{
	import flash.events.Event;
	
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameAdventure extends Game implements IGame
	{
		
		public function GameAdventure(level:int)
		{
			if (Common.IS_DEBUG) trace('create GameAdventure ' + level);
			
			generateGameBg();
		}
		
		/**
		 * Override
		 */
		
		override public function initialize(e:Event):void
		{
			super.initialize(e);
		}
		
		override public function pause():void
		{
			super.pause();
		}
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy GameAdventure');
			
			super.destroy();
		}
	}
}