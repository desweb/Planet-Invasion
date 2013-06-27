package core.game.weapon.enemy 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.MissileHoming;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class EnemyMissileHoming extends MissileHoming
	{
		private var _propellant:PropellantEnemyFlash;
		private var _propellant_tween:TweenLite;
		
		public function EnemyMissileHoming(type:uint, enemy:Enemy) 
		{
			_damage = 10;
			
			_fire_type		= type;
			_owner			= enemy;
			_owner_type	= Common.OWNER_ENEMY;
			
			isTraget	= true;
			target		= GameState.game.hero;
			
			_target_x = _owner.x + GameState.stageWidth;
			
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_MIDDLE_DEFAULT	: _target_y = _owner.y; break;
				case Common.FIRE_BOTTOM_DEFAULT	: _target_y = _owner.y + GameState.stageHeight; break;
			}
			
			super();
			
			_propellant = new PropellantEnemyFlash();
			_propellant.x = -width / 2;
			_propellant.scaleX =
			_propellant.scaleY = .5;
			addChild(_propellant);
			
			propellantTween();
		}
		
		/**
		 * Overrides
		 */
		
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