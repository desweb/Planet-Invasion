package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Gun extends Weapon
	{
		protected var _target_x:int;
		protected var _target_y:int;
		
		protected var is_reinforcement:Boolean = false;
		
		public function Gun()
		{
			SoundManager.getInstance().play(SoundManager.GUN);
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			super.initialize(e);
			
			if (_tween) return;
			
			_target_x = isHero() || isReinforcement()? x + GameState.stageWidth: x - GameState.stageWidth;
			
			_tween = new TweenLite(this, moveSpeed, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy });
		}
	}
}