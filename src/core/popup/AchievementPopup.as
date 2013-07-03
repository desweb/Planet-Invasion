package core.popup 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import core.Achievement;
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AchievementPopup extends Popup implements IPopup
	{
		private var _destroy_timer:Timer = new Timer(5000);
		
		public function AchievementPopup(key:String) 
		{
			SoundManager.getInstance().play(SoundManager.ACHIEVEMENT);
			
			generateContent();
			
			setPopupBorderColor(0x00FF00);
			setPopupY			(GameState.stageHeight	* .025);
			setPopupWidth	(GameState.stageWidth	* .5);
			setPopupHeight	(GameState.stageHeight	* .1);
			
			generatePopup();
			
			var achievement:Achievement = new Achievement(key);
			
			// Label
			var label:TextField = new TextField();
			label.x				= GameState.stageWidth	* .01;
			label.y				= GameState.stageHeight	* .025;
			label.width			= GameState.stageWidth	* .3;
			label.height		= GameState.stageHeight	* .05;
			label.selectable	= false;
			label.textColor	= 0x00FF00;
			label.setTextFormat(Common.getPolicy('MyArialPolicy', 0x00FF00, 20));
			label.text			= 'Achievement unlocked : ' + achievement.name;
			setPopupContent(label);
			
			_destroy_timer.start();
			_destroy_timer.addEventListener(TimerEvent.TIMER, completeDestroyTimer);
		}
		
		/**
		 * Overrides
		 */
		
		override public function destroy():void
		{
			_destroy_timer.removeEventListener(TimerEvent.TIMER, completeDestroyTimer);
			_destroy_timer.stop();
			_destroy_timer = null;
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function completeDestroyTimer(e:TimerEvent):void
		{
			destroy();
		}
	}
}