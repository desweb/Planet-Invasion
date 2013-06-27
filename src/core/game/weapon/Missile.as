package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Missile extends Weapon
	{
		protected var _target_x:int;
		protected var _target_y:int;
		
		public function Missile()
		{
			_graphic = new MissileFlash();
			addChild(_graphic);
			
			//if (isEnemy()) rotation = 180;
			
			SoundManager.getInstance().play('missile');
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			super.initialize(e);
			
			_target_x = isHero()? x + GameState.stageWidth: x - GameState.stageWidth;
			
			_tween = new TweenLite(this, moveSpeed, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy });
		}
	}
}