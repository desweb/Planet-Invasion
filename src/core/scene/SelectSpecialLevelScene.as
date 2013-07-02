package core.scene 
{
	import flash.events.MouseEvent;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class SelectSpecialLevelScene extends Scene
	{
		private var buttons:Array = new Array();
		
		public function SelectSpecialLevelScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			generateBtnSound();
			
			_return_scene_uid = Common.SCENE_GAME_MODE;
			
			var i:uint = 0;
			for each (var level:Array in GameState.user.levels)
			{
				buttons[i] = generateBtn(level.name);
				buttons[i].name = level.key;
				buttons[i].y = GameState.stageHeight * .25 + GameState.stageHeight * .1 * i;
				
				buttons[i].addEventListener(MouseEvent.CLICK, clickLevel);
				
				i++;
			}
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			for each (var b:BtnFlash in buttons) b.removeEventListener(MouseEvent.CLICK, clickLevel);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickLevel(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_SPECIAL, parseInt(e.target.name));
		}
	}
}