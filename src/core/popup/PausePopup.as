package core.popup 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
		private var _is_kill:Boolean = false;
		
		public function PausePopup()
		{
			generateBackground();
			generateContent();
			
			setTitleText('Pause');
			
			generatePopup();
			
			_back_menu_btn = generateBtn('Back to menu');
			
			// Events
			_back_menu_btn.addEventListener(MouseEvent.CLICK, clickBackMenuBtn);
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	downKey);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (_is_kill) return;
			
			_is_kill = true;
			
			_back_menu_btn	.removeEventListener(MouseEvent.CLICK, clickBackMenuBtn);
			stage					.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			
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
		
		private function downKey(e:KeyboardEvent):void
		{
			if (String.fromCharCode(e.charCode) != 'p') return;
			
			destroy();
		}
	}
}