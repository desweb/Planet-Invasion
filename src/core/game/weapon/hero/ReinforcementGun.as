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
			if (Common.IS_DEBUG) trace('create ReinforcementGun');
			
			_fire_type = Common.FIRE_MIDDLE_DEFAULT;
			
			y = Tools.random(0, GameState.stageHeight);
			
			_target_x = x + GameState.stageWidth;
			_target_y = y;
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
				if (e_hit.isKilled || !hitTestObject(e_hit)) continue;
				
				e_hit.destroy();
				destroy();
			}
		}
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy ReinforcementGun');
			
			super.destroy();
		}
	}
}