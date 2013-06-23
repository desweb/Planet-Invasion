package core.popup 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import core.Common;
	import core.scene.SceneManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class PausePopup extends Popup implements IPopup 
	{
		private var _back_menu_btn:BtnFlash;
		
		public function PausePopup()
		{
			generateBackground();
			generateContent();
			
			setTitleText('Pause');
			
			generatePopup();
			
			_back_menu_btn = generateBtn('Back to menu');
			
			// Events
			_back_menu_btn.addEventListener(MouseEvent.CLICK, clickBackMenuBtn);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_back_menu_btn.removeEventListener(MouseEvent.CLICK, clickBackMenuBtn);
			
			stage.dispatchEvent(new Event('resumeGameScene'));
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickBackMenuBtn(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
	}
}