package core.popup 
{
	import core.Common;
	import core.GameState;
	import core.scene.GameScene;
	import core.scene.SceneManager;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class PausePopup extends Popup implements IPopup 
	{
		
		public function PausePopup()
		{
			if (Common.IS_DEBUG) trace('create PausePopup');
			
			generateBackground();
			generateContent();
			
			setTitleText('Pause');
			
			generatePopup();
			
			
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy PausePopup');
			
			stage.dispatchEvent(new Event('resumeGameScene'));
			
			super.destroy();
		}
	}
}