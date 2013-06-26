package core.scene 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import core.Common;
	import core.GameState;
	import core.game.Game;
	import core.game.GameAdventure;
	import core.game.GameDuo;
	import core.game.GameSurvival;
	import core.popup.PausePopup;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameScene extends Scene
	{
		// Const
		public static const KEY_PAUSE:String = 'p';
		
		private var _game:Game;
		
		private var _is_pause:Boolean = false;
		
		public function GameScene(type:uint, level:uint = 0) 
		{
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
			stage.addEventListener('resumeGameScene',	resume);
		}
		
		public function pause():void
		{
			if (_is_pause) return;
			
			_is_pause = true;
			
			_game.pause();
			
			var pause_popup:PausePopup = new PausePopup();
			addChild(pause_popup);
			pause_popup.display();
			
		}
		
		public function resume(e:Event):void
		{
			_is_pause = false;
			
			_game.resume();
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_game.destroy();
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function downKey(e:KeyboardEvent):void
		{
			if (String.fromCharCode(e.charCode) != KEY_PAUSE || GameState.game.hero.is_kill) return;
			
			if (!_is_pause)	pause();
			else					resume(null);
		}
	}
}