package core.scene 
{
	import core.Common;
	import core.GameState;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class TutorialScene extends Scene
	{
		
		public function TutorialScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			sceneReturn = Common.SCENE_GAME_MODE;
			
			var tutorial:TutorialSceneFlash = new TutorialSceneFlash();
			tutorial.x = GameState.stageWidth	* .1;
			tutorial.y = GameState.stageHeight	* .3;
			
			var bg:Sprite = new Sprite();
			bg.x = tutorial.x - 10;
			bg.y = tutorial.y - 20;
			bg.graphics.beginFill(0x000000, .75);
			bg.graphics.drawRect(0, 0, tutorial.width + 20, tutorial.height + 40);
			bg.graphics.endFill();
			addChild(bg);
			
			addChild(tutorial);
		}
	}
}