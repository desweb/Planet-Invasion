package core.game.enemy 
{
	import flash.events.Event;
	
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AsteroidEnemy extends Enemy
	{
		private static const ROTATION_1:uint = 1;
		private static const ROTATION_2:uint = 2;
		
		private var _rotation_type	:uint;
		private var _rotation_speed:int;
		
		public function AsteroidEnemy() 
		{
			_life = 5;
			
			_graphic = new AsteroidFlash();
			addChild(_graphic);
			
			_rotation_type	= Tools.random(0, 1)? ROTATION_1: ROTATION_2;
			_rotation_speed	= Tools.random(1, 20);
			
			rotation = Tools.random(0, 360);
			
			scaleX = 
			scaleY = Tools.random(1, 10) * .1;
			
			super();
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void
		{
			if (is_kill) return;
			
			super.update(e);
			
			if (isRotation1())	rotation += 10;
			else						rotation -= 10;
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