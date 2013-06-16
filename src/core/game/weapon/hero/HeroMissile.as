package core.game.weapon.hero 
{
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
			if (Common.IS_DEBUG) trace('create HeroMissile');
			
			_fire_type		= type;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			_target_x = _owner.x + GameState.stageWidth;
			
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
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override public function destroy():void 
		{
			if (Common.IS_DEBUG) trace('destroy HeroMissile');
			
			super.destroy();
		}
	}
}