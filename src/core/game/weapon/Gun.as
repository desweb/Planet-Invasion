package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.SoundManager;
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
			SoundManager.getInstance().play('gun');
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			super.initialize(e);
			
			if (_tween) return;
			
			_target_x = isHero()? x + GameState.stageWidth: x - GameState.stageWidth;
			
			_tween = new TweenLite(this, moveSpeed, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy });
		}
	}
}