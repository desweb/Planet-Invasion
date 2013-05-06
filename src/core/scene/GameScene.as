package core.scene 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import core.Common;
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
		private static const KEY_PAUSE:String = 'p';
		
		private var _game:Game;
		
		private var _isPaused:Boolean = false;
		
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
			stage.addEventListener('resumeGameScene',	resume);
		}
		
		public function pause():void
		{
			if (_isPaused) return;
			
			_isPaused = true;
			
			_game.pause();
			
			var pausePopup:PausePopup = new PausePopup();
			addChild(pausePopup);
			pausePopup.display();
		}
		
		public function resume(e:Event):void
		{
			_isPaused = false;
			
			_game.resume();
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy GameScene');
			
			_game.destroy();
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function downKey(e:KeyboardEvent):void
		{
			if (String.fromCharCode(e.charCode) != KEY_PAUSE) return;
			
			pause();
		}
	}
}