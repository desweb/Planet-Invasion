package core.popup 
{
	import flash.text.TextField;
	
	import core.Achievement;
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AchievementPopup extends Popup implements IPopup
	{
		public function AchievementPopup(key:String) 
		{
			if (Common.IS_DEBUG) trace('create AchievementPopup');
			
			generateContent();
			
			setPopupBorderColor(0x00FF00);
			setPopupY			(GameState.stageHeight	* .025);
			setPopupWidth	(GameState.stageWidth	* .5);
			setPopupHeight	(GameState.stageHeight	* .1);
			
			generatePopup();
			
			var achievement:Achievement = new Achievement(key);
			
			// Label
			var label:TextField = new TextField();
			label.x				= GameState.stageWidth	* .15;
			label.y				= GameState.stageHeight	* .025;
			label.width			= GameState.stageWidth	* .3;
			label.height		= GameState.stageHeight	* .05;
			label.selectable	= false;
			label.textColor	= 0x00FF00;
			label.setTextFormat(Common.getPolicy('MyArialPolicy', 0x00FF00, 20));
			label.text			= 'Achievement unlocked : ' + achievement.name;
			setPopupContent(label);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy AchievementPopup');
			
			super.destroy();
		}
	}
}