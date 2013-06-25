package core.scene 
{
	import core.popup.ErrorPopup;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * Select game mode or improvement
	 * @author desweb
	 */
	public class GameModeScene extends Scene
	{
		private var _is_survival_restricted	:Boolean = false;
		private var _is_duo_restricted			:Boolean = false;
		
		private var _improvements_btn	:BtnFlash;
		private var _adventure_btn			:BtnFlash;
		private var _survival_btn			:BtnFlash;
		private var _duo_btn					:BtnFlash;
		
		/**
		 * Constructor
		 */
		
		public function GameModeScene() 
		{
			/**
			 * Initialization
			 */
			
			is_alien_menu = true;
			
			generateBg();
			generateBtnReturn();
			generateBtnSound();
			generateLogin();
			
			sceneReturn = Common.SCENE_MENU;
			
			/**
			 * Menu
			 */
			
			// Improvements button
			_improvements_btn = generateBtn('Improvements');
			_improvements_btn.y = GameState.stageHeight * 0.3;
			
			// Adventure button
			_adventure_btn = generateBtn('Adventure');
			_adventure_btn.y = GameState.stageHeight * 0.4;
			
			// Survival button
			_survival_btn = generateBtn('Survival', Common.FRAME_BTN_LOCK);
			_survival_btn.y = GameState.stageHeight * 0.5;
			
			// Duo button
			_duo_btn = generateBtn('Duo', Common.FRAME_BTN_LOCK);
			_duo_btn.y = GameState.stageHeight * 0.6;
			
			// Events
			_improvements_btn	.addEventListener(MouseEvent.CLICK, clickImprovements);
			_adventure_btn			.addEventListener(MouseEvent.CLICK, clickAdventure);
			_survival_btn				.addEventListener(MouseEvent.CLICK, clickSurvival);
			_duo_btn					.addEventListener(MouseEvent.CLICK, clickDuo);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_improvements_btn	.removeEventListener(MouseEvent.CLICK, clickImprovements);
			_adventure_btn			.removeEventListener(MouseEvent.CLICK, clickAdventure);
			_survival_btn				.removeEventListener(MouseEvent.CLICK, clickSurvival);
			_duo_btn					.removeEventListener(MouseEvent.CLICK, clickDuo);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickImprovements(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButton();
			SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT);
		}
		
		private function clickAdventure(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButton();
			SceneManager.getInstance().setCurrentScene(Common.SCENE_SELECT_LEVEL);
		}
		
		private function clickSurvival(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButtonError();
			
			if (!GameState.user.isLog || GameState.user.level_adventure < 5)
			{
				var error_popup:ErrorPopup = new ErrorPopup();
				error_popup.setText('You must be logged in & have finished the adventure mode\nto access to survival mode.');
				addChild(error_popup);
				error_popup.display();
				
				return;
			}
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_SURVIVAL);
		}
		
		private function clickDuo(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButtonError();
			
			if (!GameState.user.isLog)
			{
				var error_popup:ErrorPopup = new ErrorPopup();
				error_popup.setText('You must be logged in to access to survival mode.');
				addChild(error_popup);
				error_popup.display();
				
				return;
			}
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_DUO);
		}
	}
}