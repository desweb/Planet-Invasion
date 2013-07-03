package core.popup 
{
	import core.scene.GameScene;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.scene.SceneManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class PausePopup extends Popup implements IPopup 
	{
		private var _is_kill:Boolean = false;
		
		private	var _restart_btn				:BtnFlash;
		private	var _back_menu_btn		:BtnFlash;
		public	var current_game_key	:String;
		
		public function PausePopup()
		{
			generateBackground();
			generateContent();
			
			setTitleText('Pause');
			setPopupHeight(GameState.stageHeight * .3);
			
			generatePopup();
			
			_restart_btn		= generateBtn('Restart');
			_restart_btn.y	= GameState.stageHeight * .45;
			
			_back_menu_btn	= generateBtn('Back to menu');
			_back_menu_btn.y	= GameState.stageHeight * .55;
			
			// Events
			_restart_btn			.addEventListener(MouseEvent.CLICK, clickRestartBtn);
			_back_menu_btn	.addEventListener(MouseEvent.CLICK, clickBackMenuBtn);
			
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
			if (_is_kill) return;
			
			_is_kill = true;
			
			_restart_btn			.removeEventListener(MouseEvent.CLICK,				clickRestartBtn);
			_back_menu_btn	.removeEventListener(MouseEvent.CLICK,				clickBackMenuBtn);
			if (stage) stage		.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			
			stage.dispatchEvent(new Event('resumeGameScene'));
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickRestartBtn(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			destroy();
			
			if			(current_game_key == Common.GAME_ADVENTURE_KEY)	SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_ADVENTURE, GameState.game.current_level);
			else if	(current_game_key == Common.GAME_SURVIVAL_KEY)		SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_SURVIVAL);
			else if	(current_game_key == Common.GAME_DUO_KEY)				SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_DUO);
			else if	(current_game_key == Common.GAME_SPECIAL_KEY)		SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_SPECIAL);
		}
		
		private function clickBackMenuBtn(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			destroy();
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
		
		private function downKey(e:KeyboardEvent):void
		{
			if (String.fromCharCode(e.charCode) != 'p') return;
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON_CLOSE);
			
			var scene:GameScene = SceneManager.getInstance().scene as GameScene;
			scene.resume(null);
			
			destroy();
		}
	}
}