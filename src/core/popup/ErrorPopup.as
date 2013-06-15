package core.popup 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ErrorPopup extends Popup implements IPopup
	{
		private var _label:TextField;
		
		public function ErrorPopup()
		{
			if (Common.IS_DEBUG) trace('create ErrorPopup');
			
			generateBackground();
			generateContent();
			
			setPopupBorderColor(0xff0000);
			setPopupWidth	(GameState.stageWidth	* .5);
			setPopupHeight	(GameState.stageHeight	* .1);
			
			generatePopup();
			
			// Format
			var format:TextFormat = Common.getPolicy('MyArialPolicy', 0xff0000, 20);
			format.align = 'center';
			
			// Label
			_label = new TextField();
			_label.x					= 10;
			_label.y					= GameState.stageHeight	* .025;
			_label.width			= GameState.stageWidth	* .45;
			_label.height			= GameState.stageHeight	* .1;
			_label.selectable	= false;
			_label.textColor		= 0xFF0000;
			_label.setTextFormat(format);
			setPopupContent(_label);
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
			_label.text = value;
		}
	}
}