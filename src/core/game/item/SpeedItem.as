package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class SpeedItem 
	{
		public function SpeedItem() 
		{
			_type = Common.ITEM_SPEED;
			_item = new ItemSpeedFlash();
			addChild(_item);
		}
	}
}