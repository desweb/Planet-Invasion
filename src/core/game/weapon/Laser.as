package core.game.weapon 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Laser extends Weapon
	{
		private var _life_timer:Timer = new Timer(5000);
		
		public function Laser() 
		{
			_is_hit_destroy = false;
			
			_life_timer.addEventListener(TimerEvent.TIMER, completeLifeTimer);
			
			_life_timer.start();
			
			SoundManager.getInstance().play(SoundManager.LASER);
		}
		
		/**
		 * Overrides
		 */
		
		override protected function initialize(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		override protected function update(e:Event):void 
		{
			super.update(e);
			
			x = _owner.x;
			y = _owner.y;
		}
		
		override public function destroy():void
		{
			if (_life_timer)
			{
				_life_timer.stop();
				_life_timer.removeEventListener(TimerEvent.TIMER, completeLifeTimer);
				_life_timer = null;
			}
			
			super.destroy();
		}
		
		override public function pause():void 
		{
			if (_life_timer) _life_timer.stop();
			
			super.pause();
		}
		
		override public function resume():void
		{
			if (_life_timer) _life_timer.start();
			
			super.resume();
		}
		
		/**
		 * Events
		 */
		
		private function completeLifeTimer(e:TimerEvent):void
		{
			removeChild(_graphic);
			_graphic = null;
			
			destroy();
		}
	}
}