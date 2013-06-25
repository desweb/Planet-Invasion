package core.game 
{
	import flash.events.Event;
	
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameDuo extends Game implements IGame
	{
		
		public function GameDuo()
		{
			if (Common.IS_DEBUG) trace('create GameDuo');
			
			super(Common.GAME_DUO_KEY);
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
			if (Common.IS_DEBUG) trace('destroy GameDuo');
			
			super.destroy();
		}
	}
}