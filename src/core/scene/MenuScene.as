package core.scene 
{
	import flash.events.MouseEvent;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * First menu
	 * @author desweb
	 */
	public class MenuScene extends Scene
	{
		private var _btnPlay				:BtnFlash;
		private var _btnRanking			:BtnFlash;
		private var _btnAchievements	:BtnFlash;
		private var _btnCredits			:BtnFlash;
		
		/**
		 * Contructor
		 */
		
		public function MenuScene()
		{
			/**
			 * Initialization
			 */
			
			is_alien_menu = true;
			
			generateBg();
			generateBtnSound();
			generateLogin();
			
			/**
			 * Menu
			 */
			
			// Play button
			_btnPlay = generateBtn('Play');
			_btnPlay.y = GameState.stageHeight * 0.3;
			
			// Ranking button
			_btnRanking = generateBtn('Ranking');
			_btnRanking.y = GameState.stageHeight * 0.4;
			
			// Achievements button
			_btnAchievements = generateBtn('Achievements');
			_btnAchievements.y = GameState.stageHeight * 0.5;
			
			// Credits button
			_btnCredits = generateBtn('Credits');
			_btnCredits.y = GameState.stageHeight * 0.6;
			
			/**
			 * Events
			 */
			
			_btnPlay				.addEventListener(MouseEvent.CLICK, clickPlay);
			_btnRanking			.addEventListener(MouseEvent.CLICK, clickRanking);
			_btnAchievements	.addEventListener(MouseEvent.CLICK, clickAchievements);
			_btnCredits			.addEventListener(MouseEvent.CLICK, clickCredits);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_btnPlay.removeEventListener(MouseEvent.MOUSE_OVER, over);
			_btnPlay.removeEventListener(MouseEvent.MOUSE_OUT, out);
			_btnPlay.removeEventListener(MouseEvent.CLICK, clickPlay);
			
			_btnRanking.removeEventListener(MouseEvent.MOUSE_OVER, over);
			_btnRanking.removeEventListener(MouseEvent.MOUSE_OUT, out);
			_btnRanking.removeEventListener(MouseEvent.CLICK, clickRanking);
			
			_btnAchievements.removeEventListener(MouseEvent.MOUSE_OVER, over);
			_btnAchievements.removeEventListener(MouseEvent.MOUSE_OUT, out);
			_btnAchievements.removeEventListener(MouseEvent.CLICK, clickAchievements);
			
			_btnCredits.removeEventListener(MouseEvent.MOUSE_OVER, over);
			_btnCredits.removeEventListener(MouseEvent.MOUSE_OUT, out);
			_btnCredits.removeEventListener(MouseEvent.CLICK, clickCredits);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickPlay(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButton();
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
		
		private function clickRanking(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButton();
			SceneManager.getInstance().setCurrentScene(Common.SCENE_RANK);
		}
		
		private function clickAchievements(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButton();
			SceneManager.getInstance().setCurrentScene(Common.SCENE_ACHIEVEMENT);
		}
		
		private function clickCredits(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButton();
			SceneManager.getInstance().setCurrentScene(Common.SCENE_CREDIT);
		}
	}
}