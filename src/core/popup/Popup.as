package core.popup 
{
	import flash.display.Sprite;
	
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Popup 
	{
		private var _bg:Sprite;
		
		public function Popup() 
		{
			
		}
		
		/**
		 * Generation functions
		 */
		
		// Background
		public function generateBg():void
		{
			_bg = new Sprite();
			_bg.alpha = 0.5;
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0, 0, GameState.stageWidth, GameState.stageWidth);
			_bg.graphics.endFill();
			addChild(_bg);
		}
	}
}