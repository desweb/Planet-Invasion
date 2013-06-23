package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GoldItem extends Item
	{
		public function GoldItem() 
		{
			_type = Common.ITEM_GOLD;
			_item = new ItemGoldFlash();
			addChild(_item);
		}
	}
}