package core.scene 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import core.Common;
	import core.game.Game;
	import core.game.GameAdventure;
	import core.game.GameDuo;
	import core.game.GameSurvival;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameScene extends Scene
	{
		// Const
		private static const KEY_PAUSE:String = 'p';
		
		private var _game:Game;
		
		public function GameScene(type:uint, level:uint = 0) 
		{
			if (Common.IS_DEBUG) trace('create GameScene ' + type);
			
			switch (type)
			{
				case Common.SCENE_GAME_ADVENTURE	: _game = new GameAdventure(level);	break;
				case Common.SCENE_GAME_SURVIVAL		: _game = new GameSurvival();				break;
				case Common.SCENE_GAME_DUO				: _game = new GameDuo();					break;
				default														: _game = new GameAdventure(level);
			}
			
			addChild(_game);
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	downKey);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy GameScene');
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			
			_game.destroy();
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function downKey(e:KeyboardEvent):void
		{
			_game.pause();
		}
	}
}