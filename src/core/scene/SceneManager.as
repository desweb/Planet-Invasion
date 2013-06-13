package core.scene 
{
	import com.greensock.TweenLite;
	
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
		
		private var _current_scene	:Scene;
		private var _old_scene		:Scene;
		
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
		
		/**
		 * Functions
		 */
		
		public function setCurrentScene(scene_uid:uint, level:uint = 0):void
		{
			if (_current_scene_uid) _old_scene = _current_scene;
			
			_current_scene = checkNewScene(scene_uid, level);
			_current_scene.alpha = 0;
			GameState.main.addChild(_current_scene);
			
			TweenLite.to(_current_scene, .5, {alpha:1});
			
			if (_old_scene) TweenLite.to(_old_scene, .5, {alpha:0, onComplete:destroyOldScene});
			
			_current_scene_uid = scene_uid;
		}
		
		private function destroyOldScene():void
		{
			if (!_old_scene) return;
			
			_old_scene.destroy();
			_old_scene = null;
		}
		
		static private function checkNewScene(scene_uid:uint, level:uint = 0):Scene
		{
			switch (scene_uid)
			{
				case Common.SCENE_ACHIEVEMENT			: return new AchievementScene();	break;
				case Common.SCENE_CREDIT					: return new CreditScene();			break;
				case Common.SCENE_DIALOG					: return new DialogScene();			break;
				case Common.SCENE_FINAL						: return new FinalScene();				break;
				case Common.SCENE_GAME_ADVENTURE	: return new GameScene(scene_uid, level);	break;
				case Common.SCENE_GAME_SURVIVAL		: return new GameScene(scene_uid);			break;
				case Common.SCENE_GAME_DUO				: return new GameScene(scene_uid);			break;
				case Common.SCENE_GAME_MODE			: return new GameModeScene();		break;
				case Common.SCENE_IMPROVEMENT			: return new ImprovementScene();	break;
				case Common.SCENE_MENU						: return new MenuScene();				break;
				case Common.SCENE_RANK						: return new RankScene();				break;
				case Common.SCENE_RESEARCH_DUO		: return new ResearchDuoScene();	break;
				case Common.SCENE_SELECT_LEVEL			: return new SelectLevelScene();	break;
				default														: return new MenuScene();
			}
		}
		
		/**
		 * Getters
		 */
		
		public function get sceneId()	:uint		{ return _current_scene_uid; }
		public function get scene()		:Scene	{ return _current_scene; }
	}
}