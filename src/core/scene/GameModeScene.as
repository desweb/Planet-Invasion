package core.scene 
{
	import flash.events.MouseEvent;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.popup.ErrorPopup;
	
	/**
	 * Select game mode or improvement
	 * @author desweb
	 */
	public class GameModeScene extends Scene
	{
		private var _is_survival_restricted	:Boolean = false;
		private var _is_duo_restricted			:Boolean = false;
		
		private var _tutorial_btn				:BtnFlash;
		private var _improvements_btn	:BtnFlash;
		private var _adventure_btn			:BtnFlash;
		private var _survival_btn			:BtnFlash;
		private var _duo_btn					:BtnFlash;
		private var _special_level_btn		:BtnFlash;
		
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
			
			_return_scene_uid = Common.SCENE_MENU;
			
			/**
			 * Menu
			 */
			
			// Tutorial button
			_tutorial_btn = generateBtn('Tutorial');
			_tutorial_btn.y = GameState.stageHeight * .25;
			
			// Improvements button
			_improvements_btn = generateBtn('Improvements');
			_improvements_btn.y = GameState.stageHeight * .35;
			
			// Adventure button
			_adventure_btn = generateBtn('Adventure');
			_adventure_btn.y = GameState.stageHeight * .5;
			
			// Survival button
			_survival_btn = generateBtn('Survival', !GameState.user.isLog || GameState.user.level_adventure < Common.TOTAL_LEVEL? Common.FRAME_BTN_LOCK: Common.FRAME_BTN_DEFAULT);
			_survival_btn.y = GameState.stageHeight * .6;
			
			// Duo button
			_duo_btn = generateBtn('Duo', Common.FRAME_BTN_LOCK);
			_duo_btn.y = GameState.stageHeight * .7;
			
			// Special level button
			_special_level_btn = generateBtn('Special level', GameState.user.level_adventure < Common.TOTAL_LEVEL? Common.FRAME_BTN_LOCK: Common.FRAME_BTN_DEFAULT);
			_special_level_btn.y = GameState.stageHeight * .8;
			
			// Events
			_tutorial_btn				.addEventListener(MouseEvent.CLICK, clickTutorial);
			_improvements_btn	.addEventListener(MouseEvent.CLICK, clickImprovements);
			_adventure_btn			.addEventListener(MouseEvent.CLICK, clickAdventure);
			_survival_btn				.addEventListener(MouseEvent.CLICK, clickSurvival);
			_duo_btn					.addEventListener(MouseEvent.CLICK, clickDuo);
			_special_level_btn		.addEventListener(MouseEvent.CLICK, clickSpecialLevel);
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
		
		private function clickTutorial(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_TOTURIAL);
		}
		
		private function clickImprovements(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT);
		}
		
		private function clickAdventure(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_SELECT_LEVEL);
		}
		
		private function clickSurvival(e:MouseEvent):void
		{
			if (!GameState.user.isLog || GameState.user.level_adventure < Common.TOTAL_LEVEL)
			{
				SoundManager.getInstance().play(SoundManager.MENU_BUTTON_ERROR);
				
				var error_popup:ErrorPopup = new ErrorPopup();
				error_popup.setText('You must be logged in & have finished the adventure mode\nto access to survival mode.');
				addChild(error_popup);
				error_popup.display();
				
				return;
			}
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_SURVIVAL);
		}
		
		private function clickDuo(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON_ERROR);
			
			var error_popup:ErrorPopup = new ErrorPopup();
			error_popup.setText('The duo mode will soon be available.');
			addChild(error_popup);
			error_popup.display();
			
			return;
			
			if (!GameState.user.isLog)
			{
				var error_popup:ErrorPopup = new ErrorPopup();
				error_popup.setText('You must be logged in to access to duo mode.');
				addChild(error_popup);
				error_popup.display();
				
				return;
			}
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_DUO);
		}
		
		private function clickSpecialLevel(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON_ERROR);
			
			/*if (GameState.user.level_adventure < Common.TOTAL_LEVEL)
			{
				var error_popup:ErrorPopup = new ErrorPopup();
				error_popup.setText('You must have finished the adventure mode\nto access to special levels.');
				addChild(error_popup);
				error_popup.display();
				
				return;
			}*/
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_SELECT_SPECIAL_LEVEL);
		}
	}
}