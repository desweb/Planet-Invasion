package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.Improvement;
	import core.game.enemy.Enemy;
	import core.game.weapon.MissileHoming;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissileHoming extends MissileHoming
	{
		private var _propellant:PropellantHeroFlash;
		private var _propellant_tween:TweenLite;
		
		public function HeroMissileHoming(type:uint)
		{
			_fire_type		= type;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			_target_x = _owner.x + GameState.stageWidth;
			
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: _target_y = _owner.y - GameState.stageHeight; break;
				case Common.FIRE_MIDDLE_DEFAULT	: _target_y = _owner.y; break;
				case Common.FIRE_BOTTOM_DEFAULT	: _target_y = _owner.y + GameState.stageHeight; break;
			}
			
			var missile_search_damage_improvement:Improvement = new Improvement(Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE);
			_damage = missile_search_damage_improvement.value[GameState.user.improvements[Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE]];
			
			super();
			
			_propellant = new PropellantHeroFlash();
			_propellant.x = -width / 2;
			_propellant.scaleX =
			_propellant.scaleY = .5;
			addChild(_propellant);
			
			propellantTween();
			
			if (GameState.game.hero.is_attack_item) _damage *= 2;
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			// Research target enemy
			for each(var eTarget:Enemy in GameState.game.enemies)
			{
				if (eTarget && eTarget.is_kill) continue;
				
				if (eTarget.x > GameState.game.hero.x)
				{
					isTraget = true;
					target = eTarget;
					break;
				}
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