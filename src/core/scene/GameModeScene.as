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
		private var _btnImprovements:Btn;
		private var _btnAdventure:Btn;
		private var _btnSurvival:Btn;
		private var _btnDuo:Btn;
		
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
			/*_btnSurvival = generateBtn('Survival', 3);
			_btnSurvival.y = GameState.stageHeight * 0.5;
			
			// Duo button
			_btnDuo = generateBtn('Duo', 3);
			_btnDuo.y = GameState.stageHeight * 0.6;*/
			
			_btnAdventure.addEventListener(MouseEvent.CLICK, clickAdventure);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy GameModeScene');
			
			_btnAdventure.removeEventListener(MouseEvent.CLICK, clickAdventure);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickAdventure(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME, Common.GAME_1);
		}
	}
}