package core.scene 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import core.Common;
	import core.GameState;
	import core.game.Game;
	import core.game.GameAdventure;
	import core.game.GameDuo;
	import core.game.GameSpecial;
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
		private var _current_game_key:String;
		
		private var _is_pause:Boolean = false;
		
		public function GameScene(type:uint, level:uint = 0) 
		{
			// Timer to hack mouse hide bug
			var mouse_timer:Timer = new Timer(300);
			mouse_timer.start();
			mouse_timer.addEventListener(TimerEvent.TIMER, function completeMouseTimer(e:TimerEvent):void
			{
				mouse_timer.removeEventListener(TimerEvent.TIMER, completeMouseTimer);
				mouse_timer.stop();
				mouse_timer = null;
				
				Mouse.hide();
			});
			
			
			switch (type)
			{
				case Common.SCENE_GAME_ADVENTURE	: _game = new GameAdventure(level);	_current_game_key = Common.GAME_ADVENTURE_KEY;	break;
				case Common.SCENE_GAME_SURVIVAL		: _game = new GameSurvival();				_current_game_key = Common.GAME_SURVIVAL_KEY;	break;
				case Common.SCENE_GAME_DUO				: _game = new GameDuo();					_current_game_key = Common.GAME_DUO_KEY;			break;
				case Common.SCENE_GAME_SPECIAL		: _game = new GameSpecial(level);		_current_game_key = Common.GAME_SPECIAL_KEY;		break;
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
		
		public function pause(is_popup:Boolean = true):void
		{
			if (_is_pause) return;
			
			_is_pause = true;
			
			_game.pause();
			
			Mouse.show();
			
			if (!is_popup) return;
			
			var pause_popup:PausePopup = new PausePopup();
			pause_popup.current_game_key = _current_game_key;
			addChild(pause_popup);
			pause_popup.display();
		}
		
		public function resume(e:Event):void
		{
			_is_pause = false;
			
			Mouse.hide();
			
			_game.resume();
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			Mouse.show();
			
			_game.destroy();
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.removeEventListener('resumeGameScene',	resume);
			
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