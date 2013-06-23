package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.Missile;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissile extends Missile
	{
		public function HeroMissile(type:uint)
		{
			_fire_type		= type;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			super();
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
	}
}