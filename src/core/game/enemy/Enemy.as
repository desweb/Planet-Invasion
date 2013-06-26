package core.game.enemy 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.scene.SceneManager;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Enemy extends Sprite
	{
		// Const
		protected static const TWEEN_COMPLETE_DETROY_TRUE	:uint = 1;
		protected static const TWEEN_COMPLETE_DETROY_FALSE	:uint = 2;
		
		// Initialize
		protected	var _life					:int;
		protected	var _collision_damage:int;
		protected	var _metal				:int;
		protected	var _crystal				:int;
		protected	var _money				:int;
		public		var is_kill					:Boolean = false;
		protected var _is_pause				:Boolean = false;
		
		protected var dt:Number = 0;
		
		protected var _graphic:MovieClip;
		
		protected var _tween:TweenLite;
		protected var _tween_complete_destroy:uint;
		protected var _is_tween_finish:Boolean = false;
		
		
		private var _fire_timer:Timer;
		
		protected var _target_x:int;
		
		/**
		 * Constructor
		 */
		
		public function Enemy() 
		{
			if (!_life)									_life									= 1;
			if (!_collision_damage)				_collision_damage				= 5;
			if (!_metal)								_metal								= 1;
			if (!_crystal)								_crystal								= 1;
			if (!_money)								_money							= 1;
			if (!_target_x)							_target_x							= -width;
			if (!_tween_complete_destroy)	_tween_complete_destroy	= TWEEN_COMPLETE_DETROY_TRUE;
			
			x = GameState.stageWidth+50;
			if (!y) y = Tools.random(0, GameState.stageHeight - 50);
			
			if (!_tween) _tween = new TweenLite(this, 10, { x:_target_x, ease:Linear.easeNone, onComplete:isTweenCompleteDestroy()? destroy: completeTween } );
			
			SoundManager.getInstance().play('propellant');
			
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
			
			// Roadhog achievement
			SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_ROADHOG, 1);
			
			GameState.game.hero.hitWeapon(_collision_damage);
			
			_life = 0;
			
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
			
			if (_fire_timer)
			{
				_fire_timer.removeEventListener(TimerEvent.TIMER, completeFireTimer);
				_fire_timer.stop();
				_fire_timer = null
			}
			
			if (_life)
			{
				removeThis();
				return;
			}
			
			GameState.game.total_enemy_kill++;
			
			_graphic.gotoAndStop(Common.FRAME_ENTITY_DEAD);
			
			SoundManager.getInstance().play('explosion');
			
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
			_is_pause = true;
			
			if (_fire_timer) _fire_timer.stop();
			
			_tween.pause();
		}
		
		public function resume():void
		{
			_is_pause = false;
			
			if (_fire_timer) _fire_timer.start();
			
			_tween.resume();
		}
		
		/**
		 * Fires
		 */
		
		protected function launchFireTimer():void
		{
			_fire_timer = new Timer(1000);
			_fire_timer.start();
			_fire_timer.addEventListener(TimerEvent.TIMER, completeFireTimer);
		}
		
		protected function completeFireTimer(e:TimerEvent):void {}
		
		/**
		 * Hits
		 */
		
		public function hitWeapon(damage:int):void
		{
			if (!_life) return;
			
			_life -= damage;
			
			if (_life <= 0)
			{
				GameState.game.metal		= GameState.game.hero.is_metal_item	? _metal	* 2 :_metal;
				GameState.game.crystal	= GameState.game.hero.is_crystal_item	? _crystal	* 2 :_crystal;
				GameState.game.money	= GameState.game.hero.is_gold_item		? _money	* 2 :_money;
				
				destroy();
			}
		}
		
		/**
		 * Tweens
		 */
		
		private function completeTween():void
		{
			_is_tween_finish = true;
		}
		
		/**
		 * Checks
		 */
		
		private function isTweenCompleteDestroy():Boolean
		{
			return _tween_complete_destroy == TWEEN_COMPLETE_DETROY_TRUE;
		}
	}
}