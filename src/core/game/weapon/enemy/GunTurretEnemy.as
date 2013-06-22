package core.game.weapon.enemy 
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.game.weapon.Gun;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GunTurretEnemy extends Gun
	{
		
		public function GunTurretEnemy(enemy:Enemy) 
		{
			_owner			= enemy;
			_owner_type	= Common.OWNER_ENEMY;
			
			var pos:Point = Tools.pointOnCirclePerimeter(new Point(_owner.x, _owner.y), _owner.rotation - 180, 20);
			
			x = pos.x;
			y = pos.y;
			
			super();
			
			rotation = Math.atan2(GameState.game.hero.y - y, GameState.game.hero.x - x) / (Math.PI / 180) - 180;
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			// Haut/Bas
			if (x == GameState.game.hero.x)
			{
				_target_x = x;
				_target_y = y + GameState.stageHeight * (y < GameState.game.hero.y? 1: -1);
				
			}
			// Avant/Arrière
			else if (y == GameState.game.hero.y)
			{
				_target_x = x + GameState.stageHeight * (x < GameState.game.hero.x? 1: -1);
				_target_y = y;
			}
			// Autour
			else
			{
				var ratio_x:Number = (x - GameState.game.hero.x) / GameState.stageWidth;
				var ratio_y:Number = (y - GameState.game.hero.y) / GameState.stageHeight;
				
				if (ratio_x < 0) ratio_x *= -1;
				if (ratio_y < 0) ratio_y *= -1;
				
				var ratio:Number = ratio_x < ratio_y? ratio_y: ratio_x;
				
				ratio = 1 / ratio;
				
				_target_x = (x - GameState.game.hero.x) * -ratio + GameState.game.hero.x;
				_target_y = (y - GameState.game.hero.y) * -ratio + GameState.game.hero.y;
			}
			
			var speed_ratio:Number = Math.sqrt(Math.pow(x - _target_x, 2) + Math.pow(y - _target_y, 2)) / GameState.stageWidth;
			
			_tween = new TweenLite(this, moveSpeed * speed_ratio, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy } );
			
			super.initialize(e);
		}
	}
}