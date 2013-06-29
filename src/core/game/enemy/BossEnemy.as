package core.game.enemy 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class BossEnemy extends Enemy
	{
		
		public function BossEnemy() 
		{
			_life						= 11000;
			_collision_damage	= 20;
			_metal					= 30;
			_crystal					= 10;
			_money				= 10;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_graphic = new BossFlash();
			addChild(_graphic);
			
			/*var graphic:Sprite = new Sprite();
			graphic.graphics.beginFill(0xff00ff, 1);
			graphic.graphics.drawCircle(0, 0, 100);
			graphic.graphics.endFill();
			addChild(graphic);*/
			
			/*var loader:Loader = new Loader();
			var image:URLRequest = new URLRequest(Common.PATH_ASSETS + 'images/boss.png');
			loader.load(image);
			
			addChild(loader);*/
			
			_target_x = 500;
			
			super(false);
			
			launchFireTimer();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void 
		{
			super.update(e);
		}
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
		}
	}
}