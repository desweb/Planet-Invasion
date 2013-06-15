package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GoldItem 
	{
		public function GoldItem() 
		{
			_type = Common.ITEM_GOLD;
			_item = new ItemGoldFlash();
			addChild(_item);
		}
	}
}