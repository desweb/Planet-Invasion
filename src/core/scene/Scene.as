package core.scene 
{
	import core.scene.IScene;
	
	import flash.display.Sprite;
	
	/**
	 * Base of scenes
	 * @author desweb
	 */
	public class Scene extends Sprite implements IScene
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