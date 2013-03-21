package core.game.weapon 
{
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
	public class HeroMissileHoming extends HeroWeapon
	{
		private var _isTraget:Boolean = false;
		private var _eTarget:Enemy;
		
		private var _tweenX:int;
		private var _tweenY:int;
		
		private var _ratioTouchTarget:Number = 0.1;
		
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
			
			if (_isTraget)
			{
				tweenPointTarget();
				tween = new TweenLite(this, 0.2, { x:_tweenX, y:_tweenY, onComplete:reinitTween } );
			}
			else tween = new TweenLite(this, moveSpeed-moveSpeed*(x/GameState.stageWidth), { x:GameState.stageWidth+100, onComplete:destroy } );
		}
		
		override public function update(e:Event):void
		{
			super.update(e);
			
			// Enemy killed
			if (_isTraget && !_eTarget) destroy();
		}
		
		private function tweenPointTarget():void
		{
			_tweenX = x+((_eTarget.x-x)*_ratioTouchTarget);
			_tweenY = y + ((_eTarget.y - y) * _ratioTouchTarget);
			
			if (_ratioTouchTarget < 1) _ratioTouchTarget += 0.1;
		}
		
		private function reinitTween():void 
		{
			tweenPointTarget();
			
			var duration:Number = _eTarget.x > x? 0.1 * ((_eTarget.x - x) / 100): 0.1 * ((x - _eTarget.x) / 100);
			
			tween.pause();
			tween.kill();
			
			tween = new TweenLite(this, duration, { x:_tweenX, y:_tweenY, ease:Linear.easeNone, onComplete:reinitTween } );
		}
	}
}