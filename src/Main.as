package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.User;
	import core.scene.SceneManager;
	import core.utils.Stats;
	import core.utils.StatsMonitor;
	
	/**
	 * Main class of the application
	 * @author desweb
	 */
	
	[SWF(backgroundColor='#000', frameRate='60', width='640', height='480')]
	[Frame(factoryClass='Preloader')]
	
	public class Main extends Sprite
	{
		private var _stats:Stats;
		private var _stats_monitor:StatsMonitor;
		
		public var user:User;
		
		public function Main():void 
		{
			if (stage)	init();
			else			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			if (Common.IS_DEBUG)
			{
				//_stats = new Stats();
				//stage.addChild(_stats);
				
				_stats_monitor = new StatsMonitor();
				stage.addChild(_stats_monitor);
			}
			
			user = new User();
			
			GameState.main = this;
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_MENU);
		}
	}
}