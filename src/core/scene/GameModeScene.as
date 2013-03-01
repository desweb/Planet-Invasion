package core.scene 
{
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
			_btnImprovements = new Btn();
			_btnImprovements.btn_txt.text = 'Improvements';
			_btnImprovements.y = GameState.stageHeight*0.3;
			_btnImprovements.btn_txt.selectable = false;
			addChild(_btnImprovements);
			
			_btnImprovements.x = GameState.stageWidth/2 - _btnImprovements.width/2;
			
			// Adventure button
			_btnAdventure = new Btn();
			_btnAdventure.btn_txt.text = 'Improvements';
			_btnAdventure.btn_txt.selectable = false;
			addChild(_btnAdventure);
			
			_btnAdventure.y = _btnImprovements.y + _btnImprovements.height + GameState.stageHeight*0.1;
			_btnAdventure.x = GameState.stageWidth/2 - _btnAdventure.width/2;
			
			// Survival button
			_btnSurvival = new Btn();
			_btnSurvival.btn_txt.text = 'Improvements';
			_btnSurvival.btn_txt.selectable = false;
			_btnSurvival.gotoAndStop(3);
			addChild(_btnSurvival);
			
			_btnSurvival.y = _btnAdventure.y + _btnAdventure.height + GameState.stageHeight*0.1;
			_btnSurvival.x = GameState.stageWidth/2 - _btnSurvival.width/2;
			
			// Duo button
			_btnDuo = new Btn();
			_btnDuo.btn_txt.text = 'Improvements';
			_btnDuo.btn_txt.selectable = false;
			_btnDuo.gotoAndStop(3);
			addChild(_btnDuo);
			
			_btnDuo.y = _btnSurvival.y + _btnSurvival.height + GameState.stageHeight*0.1;
			_btnDuo.x = GameState.stageWidth/2 - _btnDuo.width/2;
		}
		
	}

}