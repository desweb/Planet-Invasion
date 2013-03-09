package core.scene 
{
	import flash.events.MouseEvent;
	
	/**
	 * Scene interface
	 * @author desweb
	 */
	public interface IScene 
	{
		/**
		 * Interface elements
		 */
		function generateBg():void;
		function generateBtnReturn():void;
		function generateBtnSound():void;
		function generateLogin():void;
		
		/**
		 * Events
		 */
		function over(e:MouseEvent):void;
		function out(e:MouseEvent):void;
	}
}