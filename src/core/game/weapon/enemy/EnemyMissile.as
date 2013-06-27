package core.game.weapon.enemy 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.Missile;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class EnemyMissile extends Missile
	{
		private var _propellant:PropellantEnemyFlash;
		private var _propellant_tween:TweenLite;
		
		public function EnemyMissile(type:uint, enemy:Enemy)
		{
			_damage = 10;
			
			_fire_type		= type;
			_owner			= enemy;
			_owner_type	= Common.OWNER_ENEMY;
			
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
		
		override protected function initialize(e:Event):void
		{
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_TOP_LEFT				: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_TOP_RIGHT				: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_MIDDLE_DEFAULT	: _target_y = _owner.y; break;
				case Common.FIRE_MIDDLE_LEFT			: _target_y = _owner.y; break;
				case Common.FIRE_MIDDLE_RIGHT		: _target_y = _owner.y; break;
				case Common.FIRE_BOTTOM_DEFAULT	: _target_y = _owner.y + GameState.stageHeight; break;
				case Common.FIRE_BOTTOM_LEFT			: _target_y = _owner.y + GameState.stageHeight; break;
				case Common.FIRE_BOTTOM_RIGHT		: _target_y = _owner.y + GameState.stageHeight; break;
			}
			
			super.initialize(e);
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