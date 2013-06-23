package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.Gun;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroGun extends Gun
	{
		public function HeroGun(type:uint)
		{
			_fire_type		= type;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			super();
			
			if (GameState.game.hero.is_attack_item) _damage *= 2;
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: _target_y = y - GameState.stageHeight; break;
				case Common.FIRE_TOP_LEFT				: _target_y = y - GameState.stageHeight; break;
				case Common.FIRE_TOP_RIGHT				: _target_y = y - GameState.stageHeight; break;
				case Common.FIRE_MIDDLE_DEFAULT	: _target_y = y; break;
				case Common.FIRE_MIDDLE_LEFT			: _target_y = y; break;
				case Common.FIRE_MIDDLE_RIGHT		: _target_y = y; break;
				case Common.FIRE_BOTTOM_DEFAULT	: _target_y = y + GameState.stageHeight; break;
				case Common.FIRE_BOTTOM_LEFT			: _target_y = y + GameState.stageHeight; break;
				case Common.FIRE_BOTTOM_RIGHT		: _target_y = y + GameState.stageHeight; break;
			}
			
			super.initialize(e);
		}
	}
}