package core.game.weapon 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class MissileHoming extends Weapon
	{
		public var isTraget:Boolean = false;
		public var target:Sprite;
		
		private var _tweenX:int;
		private var _tweenY:int;
		
		private var _ratioTouchTarget:Number = 0.1;
		
		public function MissileHoming()
		{
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
			
			// Check target
			if (isTraget)
			{
				tweenPointTarget();
				autoRotation();
				
				tween = new TweenLite(this, 0.2, { x:_tweenX, y:_tweenY, onComplete:reinitTween } );
			}
			else tween = new TweenLite(this, moveSpeed-moveSpeed*(x/GameState.stageWidth), { x:GameState.stageWidth+100, onComplete:destroy } );
		}
		
		override public function update(e:Event):void
		{
			super.update(e);
			
			// Target killed
			if (isTraget && !target) destroy();
		}
		
		private function tweenPointTarget():void
		{
			_tweenX = x + ((target.x - x + (target.width/2)) * _ratioTouchTarget);
			_tweenY = y + ((target.y - y + (target.height/2)) * _ratioTouchTarget);
			
			if (_ratioTouchTarget < 1) _ratioTouchTarget += 0.1;
		}
		
		private function reinitTween():void
		{
			tweenPointTarget();
			
			var duration:Number = target.x > x? 0.1 * ((target.x - x) / 100): 0.1 * ((x - target.x) / 100);
			
			tween.pause();
			tween.kill();
			
			autoRotation();
			
			tween = new TweenLite(this, duration, { x:_tweenX, y:_tweenY, ease:Linear.easeNone, onComplete:reinitTween } );
		}
		
		private function autoRotation():void
		{
			// Haut/Bas
			if	(x < target.x+target.width && x > target.x)
			{
				if (y < target.y)	rotation = 90;
				else				rotation = -90;
			}
			// Avant/Arrière
			else if	(y < target.y+target.height && y > target.y)
			{
				if (x > target.x)	rotation = 180;
				else				rotation = 0;
			}
			// Avant-Haut/Avant-Bas
			else if (x < target.x)
			{
				var beforeDistMT:Number		= Math.pow(target.x+(target.width/2) - x, 2) + Math.pow(target.y+(target.height/2) - y, 2);
				var beforeAdjacent:Number	= Math.pow(target.x+(target.width/2) - x, 2);
				
				if (y < target.y)	rotation = 180 * Math.cos(beforeAdjacent/beforeDistMT) / Math.PI;
				else				rotation = -180 * Math.cos(beforeAdjacent/beforeDistMT) / Math.PI;
				
				trace(rotation);
			}
			// Arrière-Haut/Arrière-Bas
			else if	(x > target.x+target.width)
			{
				var distMT:Number	= Math.pow(target.x+(target.width/2) - x, 2) + Math.pow(target.y+(target.height/2) - y, 2);
				var adjacent:Number	= Math.pow(target.x+(target.width/2) - x, 2);
				
				if (y < target.y)	rotation = 180 - (180 * Math.cos(adjacent/distMT) / Math.PI);
				else				rotation = 180 + (180 * Math.cos(adjacent/distMT) / Math.PI);
			}
			else rotation = 0;
		}
	}
}