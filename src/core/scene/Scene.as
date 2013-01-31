package core.scene 
{
	import core.scene.iScene;
	
	import flash.display.Sprite;
	
	/**
	 * Base of scenes
	 * @author desweb
	 */
	public class Scene extends Sprite implements iScene
	{
		public function Scene() 
		{
		}
		
		public function onExit():void
		{
		}
		
		public function onEnter():void
		{
		}
	}
}