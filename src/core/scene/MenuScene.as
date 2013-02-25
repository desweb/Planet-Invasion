package core.scene 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import core.Common;
	
	/**
	 * First menu
	 * @author desweb
	 */
	public class MenuScene extends Scene
	{
		
		public function MenuScene() 
		{
			var label:TextField = new TextField();
			label.text = "Hello world";
			label.x = 10;
			label.y = 10;
			addChild(label);
			
			label.addEventListener(MouseEvent.CLICK, clickLabel);
		}
		
		public function clickLabel(e:Event):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
	}

}