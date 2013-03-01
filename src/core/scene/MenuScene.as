package core.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * First menu
	 * @author desweb
	 */
	public class MenuScene extends Scene
	{
		private var _btnPlay:Btn;
		private var _btnRanking:Btn;
		private var _btnAchievements:Btn;
		private var _btnCredits:Btn;
		
		public function MenuScene()
		{
			if (Common.IS_DEBUG) trace('create MenuScene');
			
			/**
			 * Initialization
			 */
			generateBg();
			//generateBtnReturn();
			generateBtnSound();
			generateLogin();
			
			/**
			 * Menu
			 */
			
			// Play button
			_btnPlay = new Btn();
			_btnPlay.btn_txt.backgroundColor = 0xFFFFFF;
			_btnPlay.btn_txt.text = 'Play';
			_btnPlay.y = GameState.stageHeight*0.3;
			_btnPlay.btn_txt.selectable = false;
			addChild(_btnPlay);
			
			_btnPlay.x = GameState.stageWidth/2 - _btnPlay.width/2;
			
			// Ranking button
			_btnRanking = new Btn();
			_btnRanking.btn_txt.backgroundColor = 0xFFFFFF;
			_btnRanking.btn_txt.text = 'Ranking';
			_btnRanking.y = GameState.stageHeight*0.4;
			_btnRanking.btn_txt.selectable = false;
			addChild(_btnRanking);
			
			_btnRanking.x = GameState.stageWidth/2 - _btnRanking.width/2;
			
			// Achievements button
			_btnAchievements = new Btn();
			_btnAchievements.btn_txt.text = 'Achievements';
			_btnAchievements.y = GameState.stageHeight*0.5;
			_btnAchievements.btn_txt.selectable = false;
			addChild(_btnAchievements);
			
			_btnAchievements.x = GameState.stageWidth/2 - _btnAchievements.width/2;
			
			// Credits button
			_btnCredits = new Btn();
			_btnCredits.btn_txt.text = 'Credits';
			_btnCredits.y = GameState.stageHeight*0.6;
			_btnCredits.btn_txt.selectable = false;
			addChild(_btnCredits);
			
			_btnCredits.x = GameState.stageWidth/2 - _btnCredits.width/2;
			
			/**
			 * Events
			 */
			
			_btnPlay.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnPlay.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnPlay.addEventListener(MouseEvent.CLICK, clickPlay);
			
			_btnRanking.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnRanking.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnRanking.addEventListener(MouseEvent.CLICK, clickRanking);
			
			_btnAchievements.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnAchievements.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnAchievements.addEventListener(MouseEvent.CLICK, clickAchievements);
			
			_btnCredits.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnCredits.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnCredits.addEventListener(MouseEvent.CLICK, clickCredits);
		}
		
		/**
		 * Events functions
		 */
		
		private function clickPlay(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
		
		private function clickRanking(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_RANK);
		}
		
		private function clickAchievements(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_ACHIEVEMENT);
		}
		
		private function clickCredits(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_CREDIT);
		}
	}

}