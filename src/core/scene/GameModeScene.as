package core.scene 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * Select game mode or improvement
	 * @author desweb
	 */
	public class GameModeScene extends Scene
	{
		private var _is_survival_restricted	:Boolean = false;
		private var _is_duo_restricted			:Boolean = false;
		
		private var _btnImprovements:BtnFlash;
		private var _btnAdventure		:BtnFlash;
		private var _btnSurvival			:BtnFlash;
		private var _btnDuo				:BtnFlash;
		
		/**
		 * Constructor
		 */
		
		public function GameModeScene() 
		{
			if (Common.IS_DEBUG) trace('create GameModeScene');
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			generateBtnSound();
			generateLogin();
			
			sceneReturn = Common.SCENE_MENU;
			
			/**
			 * Menu
			 */
			
			// Improvements button
			_btnImprovements = generateBtn('Improvements');
			_btnImprovements.y = GameState.stageHeight * 0.3;
			
			// Adventure button
			_btnAdventure = generateBtn('Adventure');
			_btnAdventure.y = GameState.stageHeight * 0.4;
			
			// Survival button
			_btnSurvival = generateBtn('Survival', 3);
			_btnSurvival.y = GameState.stageHeight * 0.5;
			
			// Duo button
			_btnDuo = generateBtn('Duo', 3);
			_btnDuo.y = GameState.stageHeight * 0.6;
			
			_btnImprovements	.addEventListener(MouseEvent.CLICK, clickImprovements);
			_btnAdventure		.addEventListener(MouseEvent.CLICK, clickAdventure);
			_btnSurvival			.addEventListener(MouseEvent.CLICK, clickSurvival);
			_btnDuo				.addEventListener(MouseEvent.CLICK, clickDuo);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy GameModeScene');
			
			_btnImprovements	.removeEventListener(MouseEvent.CLICK, clickImprovements);
			_btnAdventure		.removeEventListener(MouseEvent.CLICK, clickAdventure);
			_btnSurvival			.removeEventListener(MouseEvent.CLICK, clickSurvival);
			_btnDuo				.removeEventListener(MouseEvent.CLICK, clickDuo);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickImprovements(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT, 1);
		}
		
		private function clickAdventure(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_ADVENTURE, 1);
		}
		
		private function clickSurvival(e:MouseEvent):void
		{
			
		}
		
		private function clickDuo(e:MouseEvent):void
		{
			
		}
	}
}