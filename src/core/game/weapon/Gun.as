package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Gun extends Weapon
	{
		protected var _target_x:int;
		protected var _target_y:int;
		
		public function Gun()
		{
			if (Common.IS_DEBUG) trace('create Gun');
			
			_graphic = new GunFlash();
			addChild(_graphic);
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			super.initialize(e);
			
			_tween = new TweenLite(this, moveSpeed, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy });
		}
		
		override public function destroy():void 
		{
			if (Common.IS_DEBUG) trace('destroy Gun');
			
			super.destroy();
		}
		
		/**
		 * Functions
		 */
		
	}
}