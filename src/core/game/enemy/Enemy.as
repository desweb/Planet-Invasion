package core.game.enemy 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Enemy extends Sprite
	{
		protected var dt:Number = 0;
		
		public var isKilled:Boolean = false;
		
		protected var _graphic:MovieClip;
		
		private var _tween:TweenLite;
		
		private var _isPaused:Boolean = false;
		
		public function Enemy() 
		{
			x = GameState.stageWidth+50;
			y = Tools.random(0, GameState.stageHeight-50)
			
			_tween = new TweenLite(this, 10, { x:-100, ease:Linear.easeNone, onComplete:destroy });
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		protected function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		// Update
		protected function update(e:Event):void
		{
			dt = GameState.game.dt;
			
			if (!hitTestObject(GameState.game.hero)) return;
			
			destroy();
		}
		
		public function stop():void
		{
			_tween.pause();
		}
		
		public function restart():void
		{
			_tween.play();
		}
		
		public function pause():void
		{
			_isPaused = true;
			
			_tween.pause();
		}
		
		public function resume():void
		{
			_isPaused = false;
			
			_tween.resume();
		}
		
		public function destroy():void
		{
			if (isKilled) return;
			
			isKilled = true;
			
			if (_tween)
			{
				_tween.pause();
				_tween.kill();
			}
			
			_graphic.gotoAndStop(Common.FRAME_ENTITY_DEAD);
			
			var remove_timer:Timer = new Timer(Common.TIMER_ANIMATION_DEAD);
			
			remove_timer.addEventListener(TimerEvent.TIMER, function timerRemove(e:TimerEvent):void
			{
				remove_timer.removeEventListener(TimerEvent.TIMER, timerRemove);
				
				removeThis();
			});
			
			remove_timer.start();
		}
		
		private function removeThis():void
		{
			parent.removeChild(this);
		}
	}
}