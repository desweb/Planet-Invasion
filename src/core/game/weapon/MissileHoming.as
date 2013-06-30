package core.game.weapon 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class MissileHoming extends Weapon
	{
		protected var _target_x:int;
		protected var _target_y:int;
		
		public var isTraget:Boolean = false;
		public var target:Sprite;
		
		private var _tweenX:int;
		private var _tweenY:int;
		
		private var _ratioTouchTarget:Number = .1;
		
		public function MissileHoming()
		{
			_graphic = new MissileFlash();
			addChild(_graphic);
			
			SoundManager.getInstance().play(SoundManager.MISSILE);
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			super.initialize(e);
			
			// Check target
			if (isTraget)
			{
				tweenPointTarget();
				autoRotation();
				
				_tween = new TweenLite(this, .2, { x:_tweenX, y:_tweenY, onComplete:reinitTween } );
			}
			else _tween = new TweenLite(this, moveSpeed, { x:_target_x, y:_target_y, ease:Linear.easeNone, onComplete:destroy });
		}
		
		override public function destroy():void
		{
			if (_tween)
			{
				_tween.kill();
				_tween = null;
			}
			
			super.destroy();
		}
		
		/**
		 * Tweens
		 */
		
		private function tweenPointTarget():void
		{
			var new_tween_x:int = x + ((target.x - x) * _ratioTouchTarget);
			var new_tween_y:int = y + ((target.y - y) * _ratioTouchTarget);
			
			if (new_tween_x == _tweenX && new_tween_y == _tweenY)
			{
				destroy();
				return;
			}
			
			_tweenX = new_tween_x;
			_tweenY = new_tween_y;
			
			if (_ratioTouchTarget < 1) _ratioTouchTarget += .1;
		}
		
		private function reinitTween():void
		{
			tweenPointTarget();
			
			if (!_tween) return;
			
			var duration:Number = target.x > x? .1 * ((target.x - x) / 100): .1 * ((x - target.x) / 100);
			
			_tween.pause();
			_tween.kill();
			
			autoRotation();
			
			_tween = new TweenLite(this, duration, { x:_tweenX, y:_tweenY, ease:Linear.easeNone, onComplete:reinitTween } );
		}
		
		/**
		 * Functions
		 */
		
		private function autoRotation():void
		{
			// Haut/Bas
			if	(x < target.x+target.width && x > target.x)
			{
				if (y < target.y)	rotation = 90;
				else					rotation = -90;
			}
			// Avant/Arrière
			else if	(y < target.y+target.height && y > target.y)
			{
				if (x > target.x)	rotation = 180;
				else					rotation = 0;
			}
			// Avant-Haut/Avant-Bas
			else if (x < target.x)
			{
				var beforeDistMT:Number		= Math.pow(target.x+(target.width/2) - x, 2) + Math.pow(target.y+(target.height/2) - y, 2);
				var beforeAdjacent:Number	= Math.pow(target.x+(target.width/2) - x, 2);
				
				if (y < target.y)	rotation = 180 * Math.cos(beforeAdjacent/beforeDistMT) / Math.PI;
				else				rotation = -180 * Math.cos(beforeAdjacent/beforeDistMT) / Math.PI;
			}
			// Arrière-Haut/Arrière-Bas
			else if	(x > target.x+target.width)
			{
				var distMT		:Number	= Math.pow(target.x+(target.width/2) - x, 2) + Math.pow(target.y+(target.height/2) - y, 2);
				var adjacent	:Number	= Math.pow(target.x+(target.width/2) - x, 2);
				
				if (y < target.y)	rotation = 180 - (180 * Math.cos(adjacent/distMT) / Math.PI);
				else					rotation = 180 + (180 * Math.cos(adjacent/distMT) / Math.PI);
			}
			else rotation = 0;
		}
	}
}