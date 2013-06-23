package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class CrystalItem extends Item
	{
		public function CrystalItem() 
		{
			_type = Common.ITEM_CRYSTAL;
			_item = new ItemCrystalFlash();
			addChild(_item);
		}
	}
}