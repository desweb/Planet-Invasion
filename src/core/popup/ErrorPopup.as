package core.popup 
{
	import flash.text.TextField;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ErrorPopup extends Popup implements IPopup
	{
		private var _errorLabel:TextField;
		
		public function ErrorPopup()
		{
			if (Common.IS_DEBUG) trace('create ErrorPopup');
			
			setPopupBorderColor(0xff0000);
			setPopupWidth	(GameState.stageWidth	* .5);
			setPopupHeight	(GameState.stageHeight	* .1);
			
			generatePopup();
			
			// Label
			_errorLabel = new TextField();
			_errorLabel.x					= GameState.stageWidth	* .15;
			_errorLabel.y					= GameState.stageHeight	* .025;
			_errorLabel.width			= GameState.stageWidth	* .3;
			_errorLabel.height			= GameState.stageHeight	* .05;
			_errorLabel.selectable	= false;
			_errorLabel.textColor		= 0xff0000;
			_errorLabel.setTextFormat(Common.getPolicy('MyArialPolicy', 0xff0000, 20));
			setPopupContent(_errorLabel);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy ErrorPopup');
			
			super.destroy();
		}
		
		/**
		 * Setters
		 */
		
		public function setText(value:String):void
		{
			_errorLabel.text = value;
		}
	}
}