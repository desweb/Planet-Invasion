package core.game.item 
{
	/**
	 * ...
	 * @author desweb
	 */
	public class Item 
	{
		
		public function Item() 
		{
			graphics.lineStyle(2, 0x00ff00);
			graphics.beginFill(0xededed);
			graphics.drawRect(0, 0, 20, 20);
			graphics.endFill();
		}
	}
}