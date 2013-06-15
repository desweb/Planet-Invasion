package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class DefenseItem 
	{
		public function DefenseItem() 
		{
			_type = Common.ITEM_DEFENSE;
			_item = new ItemDefenseFlash();
			addChild(_item);
		}
	}
}