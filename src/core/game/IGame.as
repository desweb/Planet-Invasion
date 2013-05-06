package core.game 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author desweb
	 */
	public interface IGame 
	{
		function initialize(e:Event):void;
		function pause	():void;
		function destroy	():void;
	}
}