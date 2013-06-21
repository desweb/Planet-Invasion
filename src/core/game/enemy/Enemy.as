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
		protected static const TWEEN_COMPLETE_DETROY_TRUE	:uint = 1;
		protected static const TWEEN_COMPLETE_DETROY_FALSE	:uint = 2;
		
		// Initialize
		protected	var _life	:int;
		public		var is_kill	:Boolean = false;
		
		protected var dt:Number = 0;
		
		protected var _graphic:MovieClip;
		
		private var _tween:TweenLite;
		protected var _tween_complete_detroy:uint;
		
		private var _isPaused:Boolean = false;
		
		protected var _collision_damage:int;
		
		protected var _target_x:int;
		
		/**
		 * Constructor
		 */
		
		public function Enemy() 
		{
			x = GameState.stageWidth+50;
			y = Tools.random(0, GameState.stageHeight-50)
			
			if (!_collision_damage)			_collision_damage				= 5;
			if (!_target_x)						_target_x							= -100;
			if (!_tween_complete_detroy)	_tween_complete_detroy	= TWEEN_COMPLETE_DETROY_TRUE;
			
			_tween = new TweenLite(this, 10, { x:_target_x, ease:Linear.easeNone, onComplete:isTweenCompleteDestroy()? destroy: null } );
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		/**
		 * Initialize
		 */
		
		protected function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Update
		 */
		
		protected function update(e:Event):void
		{
			if (is_kill) return;
			
			dt = GameState.game.dt;
			
			if (GameState.game.hero.is_kill || !hitTestObject(GameState.game.hero)) return;
			
			GameState.game.hero.hitWeapon(_collision_damage);
			destroy();
		}
		
		/**
		 * Destroy
		 */
		
		public function destroy():void
		{
			if (is_kill) return;
			
			is_kill = true;
			
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
			GameState.game.destroyElement(this);
		}
		
		/**
		 * Manage
		 */
		
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
		
		/**
		 * Hits
		 */
		
		public function hitWeapon(damage:int):void
		{
			if (!_life) return;
			
			_life -= damage;
			
			if (_life <= 0) destroy();
		}
		
		/**
		 * Checks
		 */
		
		private function isTweenCompleteDestroy():Boolean
		{
			return _tween_complete_detroy == TWEEN_COMPLETE_DETROY_TRUE;
		}
	}
}