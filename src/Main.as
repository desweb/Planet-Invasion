package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.scene.MenuScene;
	import core.scene.SceneManager;
	
	/**
	 * Main class of the application
	 * @author desweb
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			GameState.main = this;
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_MENU);
		}

	}

}