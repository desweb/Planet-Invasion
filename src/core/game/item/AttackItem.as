package core.game.item 
{
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AttackItem extends Item
	{
		public function AttackItem() 
		{
			_type = Common.ITEM_ATTACK;
			_item = new ItemAttackFlash();
			addChild(_item);
		}
	}
}