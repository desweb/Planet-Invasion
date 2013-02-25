package core.scene 
{
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class SceneManager 
	{
		private static var _instance:SceneManager;
		
		private var _current_scene_uid:uint;
		
		private var _current_scene:Scene;
		
		public function SceneManager() 
		{
			_instance = null;
			_current_scene_uid = 0;
		}
		
		/**
		 * Singleton
		 */	
		public static function getInstance():SceneManager
		{
			if (_instance == null) _instance = new SceneManager();
			
			return _instance;
		}
		
		public function setCurrentScene(scene_uid:uint):void
		{
			if (_current_scene_uid)
			{
				GameState.main.removeChild(_current_scene);
				_current_scene = null;
			}
			
			_current_scene = checkNewScene(scene_uid);
			GameState.main.addChild(_current_scene);
			
			_current_scene_uid = scene_uid;
		}
		
		private static function checkNewScene(scene_uid:uint):Scene
		{
			switch (scene_uid)
			{
				case Common.SCENE_ACHIEVEMENT:	return new AchievementScene(); break;
				case Common.SCENE_CREDIT:		return new CreditScene(); break;
				case Common.SCENE_DIALOG:		return new DialogScene(); break;
				case Common.SCENE_FINAL:		return new FinalScene(); break;
				case Common.SCENE_GAME_MODE:	return new GameModeScene(); break;
				case Common.SCENE_IMPROVEMENT:	return new ImprovementScene(); break;
				case Common.SCENE_MENU:			return new MenuScene(); break;
				case Common.SCENE_RANK:			return new RankScene(); break;
				case Common.SCENE_RESEARCH_DUO:	return new ResearchDuoScene(); break;
				case Common.SCENE_SELECT_LEVEL:	return new SelectLevelScene(); break;
				default:						return new MenuScene();
			}
		}
	}

}