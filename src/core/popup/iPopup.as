package core.popup 
{
	import flash.display.DisplayObject;
	
	/**
	 * Popup interface
	 * @author desweb
	 */
	public interface IPopup 
	{
		function generatePopup():void;
		
		/**
		 * Getters
		 */
		function get close():BtnClose;
		
		/**
		 * Setters
		 */
		function set popupWidth			(value:int):void;
		function set popupHeight		(value:int):void;
		function set popupBorderColor	(value:int):void;
		function set popupContent		(value:DisplayObject):void;
	}
}