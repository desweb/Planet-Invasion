package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.MissileHoming;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissileHoming extends MissileHoming
	{
		public function HeroMissileHoming(type:uint)
		{
			if (Common.IS_DEBUG) trace('create HeroMissileHoming');
			
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
			
			super();
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
				
				if (!target || (eTarget.x < target.x && eTarget.x > GameState.game.hero.x + GameState.game.hero.width))
				{
					isTraget = true;
					target = eTarget;
				}
			}
			
			super.initialize(e);
		}
		
		override public function destroy():void 
		{
			if (Common.IS_DEBUG) trace('destroy HeroMissileHoming');
			
			super.destroy();
		}
	}
}