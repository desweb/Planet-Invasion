package core.popup 
{
	import flash.text.TextField;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class SuccessPopup extends Popup implements IPopup
	{
		private var _successLabel:TextField;
		
		public function SuccessPopup()
		{
			if (Common.IS_DEBUG) trace('create SuccessPopup');
			
			setPopupBorderColor(0x00ff00);
			
			generatePopup();
			
			// Label
			_successLabel = new TextField();
			_successLabel.x				= GameState.stageWidth*0.15;
			_successLabel.y				= GameState.stageHeight*0.1;
			_successLabel.width			= GameState.stageWidth*0.3;
			_successLabel.height		= GameState.stageHeight * 0.05;
			_successLabel.selectable	= false;
			_successLabel.textColor		= 0x00ff00;
			_successLabel.setTextFormat(Common.getPolicy('Arial', 0x00ff00, 20));
			setPopupContent(_successLabel);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy SuccessPopup');
			
			super.destroy();
		}
		
		/**
		 * Setters
		 */
		
		public function setText(value:String):void
		{
			_successLabel.text = value;
		}
	}
}