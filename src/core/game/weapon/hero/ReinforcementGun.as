package core.game.weapon.hero 
{
	import flash.events.Event;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.Gun;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ReinforcementGun extends Gun
	{
		public function ReinforcementGun()
		{
			_fire_type		= Common.FIRE_MIDDLE_DEFAULT;
			_owner			= GameState.game.hero;
			_owner_type	= Common.OWNER_HERO;
			
			y = Tools.random(0, GameState.stageHeight);
			
			_target_x = x + GameState.stageWidth;
			_target_y = y;
			
			//super();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			moveSpeed = .5;
			_target_x = GameState.stageWidth + 10;
			
			super.initialize(e);
		}
		
		override protected function update(e:Event):void 
		{
			super.update(e);
			
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.is_kill || !hitTestObject(e_hit)) continue;
				
				e_hit.destroy();
				destroy();
			}
		}
	}
}