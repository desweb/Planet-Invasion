package core.popup 
{
	import flash.text.TextField;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ErrorPopup extends Popup
	{
		private var _errorLabel:TextField;
		
		public function ErrorPopup()
		{
			if (Common.IS_DEBUG) trace('create ErrorPopup');
			
			setPopupBorderColor(0xff0000);
			
			generatePopup();
			
			// Label
			_errorLabel = new TextField();
			_errorLabel.x			= GameState.stageWidth*0.15;
			_errorLabel.y			= GameState.stageHeight*0.1;
			_errorLabel.width		= GameState.stageWidth*0.3;
			_errorLabel.height		= GameState.stageHeight * 0.05;
			_errorLabel.selectable	= false;
			_errorLabel.textColor	= 0xff0000;
			_errorLabel.setTextFormat(Common.getPolicy('MyArialPolicy', 0xff0000, 20));
			setPopupContent(_errorLabel);
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