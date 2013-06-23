package core.game.weapon 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	
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
		
		private var _propellant:PropellantFlash;
		private var _propellant_tween:TweenLite;
		
		public function MissileHoming()
		{
			_graphic = new MissileFlash();
			addChild(_graphic);
			
			_propellant = new PropellantFlash();
			_propellant.x = -width / 2;
			_propellant.scaleX =
			_propellant.scaleY = .5;
			addChild(_propellant);
			
			propellantTween();
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
		
		override protected function update(e:Event):void
		{
			super.update(e);
			
			// Target killed
			if (isTraget && !target) destroy();
		}
		
		override public function destroy():void
		{
			if (_propellant_tween)
			{
				_propellant_tween.kill();
				_propellant_tween = null;
			}
			
			if (_propellant)
			{
				removeChild(_propellant);
				_propellant = null;
			}
			
			super.destroy();
		}
		
		/**
		 * Tweens
		 */
		
		private function propellantTween(is_mini:Boolean = true):void
		{
			if (_propellant_tween)
			{
				_propellant_tween.kill();
				_propellant_tween = null;
			}
			
			_propellant_tween = new TweenLite(_propellant, Common.TIMER_TWEEN_PROPELLANT, { scaleX : is_mini? .25: .5, scaleY : is_mini? .25: .5, onComplete : propellantTween, onCompleteParams:[!is_mini] } );		
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