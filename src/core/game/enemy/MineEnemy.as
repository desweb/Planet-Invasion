package core.game.enemy 
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.GameState;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class MineEnemy extends Enemy
	{
		private static const ROTATION_1:uint = 1;
		private static const ROTATION_2:uint = 2;
		
		// Rotation
		private var _rotation_type	:uint;
		private var _rotation_speed:uint = 1;
		
		// Detonator
		private var _detonator:Sprite;
		private var _detonator_tween:TweenLite;
		
		public function MineEnemy() 
		{
			_life = 5;
			_collision_damage = 20;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_rotation_type	= Tools.random(0, 1)? ROTATION_1: ROTATION_2;
			
			rotation = Tools.random(0, 360);
			
			_graphic = new MineFlash();
			addChild(_graphic);
			
			_detonator = new Sprite();
			_detonator.graphics.beginFill(0xFF0000);
			_detonator.graphics.drawCircle(0, 0, 3);
			_detonator.graphics.endFill();
			addChild(_detonator);
			
			_target_x = Tools.random(width, width + GameState.stageWidth * .5);
			
			_detonator_tween = new TweenLite(_detonator, 1, { alpha : .25, onComplete:completeDetonatorTween });
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void
		{
			if (is_kill) return;
			
			super.update(e);
			
			if (isRotation1())	rotation +=	_rotation_speed;
			else						rotation -=	_rotation_speed;
		}
		
		override public function destroy():void 
		{
			if (_detonator_tween)
			{
				_detonator_tween.kill();
				_detonator_tween = null;
			}
			
			removeChild(_detonator);
			_detonator = null;
			
			super.destroy();
		}
		
		/**
		 * Tweens
		 */
		
		private function completeDetonatorTween(is_light:Boolean = true):void
		{
			_detonator_tween.kill();
			_detonator_tween = null;
			
			_detonator_tween = new TweenLite(_detonator, 1, { alpha : is_light? 1 :.25, onComplete:completeDetonatorTween, onCompleteParams:[!is_light] });
		}
		
		/**
		 * Checks
		 */
		
		private function isRotation1():Boolean
		{
			return _rotation_type == ROTATION_1;
		}
		
		private function isRotation2():Boolean
		{
			return _rotation_type == ROTATION_2;
		}
	}
}