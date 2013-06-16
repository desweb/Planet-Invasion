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
	public class Missile extends Weapon
	{
		protected var _target_x:int;
		protected var _target_y:int;
		
		private var _propellant:PropellantFlash;
		private var _propellant_tween:TweenLite;
		
		public function Missile()
		{
			_graphic = new MissileFlash();
			addChild(_graphic);
			
			_propellant = new PropellantFlash();
			_propellant.x = -width / 2;
			_propellant.scaleX =
			_propellant.scaleY = .5;
			addChild(_propellant);
			
			propellantTween();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			super.initialize(e);
			
			_target_x = x + GameState.stageWidth;
			
			_tween = new TweenLite(this, moveSpeed, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy });
		}
		
		override public function destroy():void
		{
			if (_propellant_tween)
			{
				_propellant_tween.kill();
				_propellant_tween = null;
			}
			
			if (_propellant)
			{
				removeChild(_propellant);
				_propellant = null;
			}
			
			super.destroy();
		}
		
		/**
		 * Tweens
		 */
		
		private function propellantTween(is_mini:Boolean = true):void
		{
			if (_propellant_tween)
			{
				_propellant_tween.kill();
				_propellant_tween = null;
			}
			
			_propellant_tween = new TweenLite(_propellant, Common.TIMER_TWEEN_PROPELLANT, { scaleX : is_mini? .25: .5, scaleY : is_mini? .25: .5, onComplete : propellantTween, onCompleteParams:[!is_mini] } );		
		}
	}
}