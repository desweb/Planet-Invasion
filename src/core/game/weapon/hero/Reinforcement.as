package core.game.weapon.hero 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Reinforcement extends Sprite
	{
		private var _ships:Vector.<ReinforcementShip> = new Vector.<ReinforcementShip>();
		
		public function Reinforcement()
		{
			if (Common.IS_DEBUG) trace('create Reinforcement');
			
			for (var i:int = 0; i < 4; i++)
			{
				for (var i2:int = 0; i2 < 5; i2++)
				{
					var ship:ReinforcementShip = new ReinforcementShip();
					ship.x = Tools.random(0, 100);
					ship.y = Tools.random(GameState.stageHeight * .25 * i, GameState.stageHeight * .25 * (i + 1));
					addChild(ship);
					
					_ships.push(ship);
				}
			}
			
			x = -width;
			y = 0;
			
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
			var gun:ReinforcementGun = new ReinforcementGun();
			gun.x = this.x;
			GameState.game.weaponsContainer.addChild(gun);
			
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
			
			for each (var ship:ReinforcementShip in _ships)
				ship.destroy();
			
			GameState.game.powersContainer.removeChild(this);
		}
	}
}