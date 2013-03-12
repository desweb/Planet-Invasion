package core.popup 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * Popup interface
	 * @author desweb
	 */
	public interface IPopup 
	{
		function generatePopup():void;
		
		/**
		 * Events
		 */
		function over	(e:MouseEvent):void;
		function out	(e:MouseEvent):void;
		
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
		
		function setTitleText	(value:String)			:void
		function setPopupContent(value:DisplayObject)	:void;
	}
}