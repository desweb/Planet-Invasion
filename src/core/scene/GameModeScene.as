package core.scene 
{
	import flash.text.TextField;
	
	/**
	 * Select game mode or improvement
	 * @author desweb
	 */
	public class GameModeScene extends Scene
	{
		
		public function GameModeScene() 
		{
			var label:TextField = new TextField();
			label.text = "Scene 2";
			label.x = 10;
			label.y = 10;
			addChild(label);
		}
		
	}

}