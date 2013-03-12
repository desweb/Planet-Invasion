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
		function display():void;
		function undisplay():void;
		
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
		function setPopupWidth			(value:int)				:void;
		function setPopupHeight			(value:int)				:void;
		function setPopupBorderColor	(value:int)				:void;
		function setTitleText			(value:String)			:void
		function setPopupContent		(value:DisplayObject)	:void;
	}
}