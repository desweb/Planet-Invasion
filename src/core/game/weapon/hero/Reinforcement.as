package core.game.weapon.hero 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Reinforcement extends Sprite
	{
		
		public function Reinforcement()
		{
			if (Common.IS_DEBUG) trace('create Reinforcement');
			
			x = -210;
			y = 0;
			
			graphics.lineStyle(2, 0x00ffff);
			graphics.beginFill(0xededed);
			graphics.drawRect(0, 0, 200, GameState.stageHeight);
			graphics.endFill();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		public function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			TweenLite.to(this, 3, { x:GameState.stageWidth+10, ease:Linear.easeNone, onComplete:destroy });
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		// Update
		public function update(e:Event):void
		{
			var mg:ReinforcementMachineGun = new ReinforcementMachineGun();
			mg.x = this.x;
			GameState.game.weaponsContainer.addChild(mg);
			
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.isKilled || !hitTestObject(e_hit)) continue;
				
				e_hit.destroy();
			}
		}
		
		// Destroy
		public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy Reinforcement');
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			GameState.game.powersContainer.removeChild(this);
		}
	}
}