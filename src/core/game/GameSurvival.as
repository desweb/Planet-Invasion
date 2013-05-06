package core.game 
{
	import flash.events.Event;
	
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameSurvival extends Game implements IGame
	{
		
		public function GameSurvival()
		{
			if (Common.IS_DEBUG) trace('create GameSurvival');
			
			
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
			if (Common.IS_DEBUG) trace('destroy GameSurvival');
			
			super.destroy();
		}
	}
}