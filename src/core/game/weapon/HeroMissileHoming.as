package core.game.weapon 
{
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class HeroMissileHoming extends HeroWeapon
	{
		private var _isTraget:Boolean = false;
		private var _eTarget:Enemy;
		
		public function HeroMissileHoming()
		{
			if (Common.IS_DEBUG) trace('create HeroMissileHoming');
			
			var trianglePoints:Vector.<Number> = new Vector.<Number>(6, true);
			trianglePoints[0] = 0;
			trianglePoints[1] = 0;
			trianglePoints[2] = 15;
			trianglePoints[3] = 5;
			trianglePoints[4] = 0;
			trianglePoints[5] = 10;
			
			graphics.beginFill(0xededed);
			graphics.drawTriangles(trianglePoints);
			graphics.endFill();
		}
		
		override public function initialize(e:Event):void
		{
			super.initialize(e);
			
			// Targeting enemy
			for each(var eTarget:Enemy in GameState.game.enemies)
			{
				if (eTarget && eTarget.isKilled) continue;
				
				if (!_eTarget || (eTarget.x < _eTarget.x && eTarget.x > GameState.game.hero.x))
				{
					_isTraget = true;
					_eTarget = eTarget;
				}
			}
			
			if (_isTraget)	tween = new TweenLite(this, moveSpeed - moveSpeed * (x / _eTarget.x), { x:_eTarget.x, y:_eTarget.y, onComplete:destroy } );
			else			tween = new TweenLite(this, moveSpeed - moveSpeed * (x / GameState.stageWidth), { x:GameState.stageWidth+100, onComplete:destroy } );
		}
		
		override public function update(e:Event):void
		{
			super.update(e);
			
			// Enemy killed
			if (_isTraget && !_eTarget) destroy();
		}
	}
}