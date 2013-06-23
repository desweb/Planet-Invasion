package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class MetalItem extends Item
	{
		public function MetalItem() 
		{
			_type = Common.ITEM_METAL;
			_item = new ItemMetalFlash();
			addChild(_item);
		}
	}
}