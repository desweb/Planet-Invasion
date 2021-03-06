package core.game.weapon.hero 
{
	import com.greensock.TweenLite;
	
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ReinforcementShip extends ReinforcementFlash
	{
		private var _propellant:PropellantHeroFlash;
		private var _propellant_tween:TweenLite;
		
		public function ReinforcementShip() 
		{
			_propellant = new PropellantHeroFlash();
			_propellant.x = -width / 2;
			addChild(_propellant);
			
			propellantTween();
		}
		
		public function destroy():void
		{
			if (_propellant_tween)
			{
				_propellant_tween.pause();
				_propellant_tween.kill();
				_propellant_tween = null;
			}
			
			parent.removeChild(this);
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
			
			_propellant_tween = new TweenLite(_propellant, Common.TIMER_TWEEN_PROPELLANT, { scaleX : is_mini? .5: 1, scaleY : is_mini? .5: 1, onComplete : propellantTween, onCompleteParams:[!is_mini] } );		
		}
	}
}