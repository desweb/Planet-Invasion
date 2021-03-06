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
		
		public var _graphic:MovieClip;
		
		protected var _tween:TweenLite;
		protected var _tween_complete_destroy:uint;
		protected var _is_tween_finish:Boolean = false;
		
		private var _fire_timer:Timer;
		
		protected var _target_x:int;
		
		// Propellant
		protected var _propellant_scale:Number = 1;
		protected var _propellant			:PropellantEnemyFlash;
		private var _propellant_tween	:TweenLite;
		
		/**
		 * Constructor
		 */
		
		public function Enemy(is_propellant:Boolean = true) 
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
			
			// Propellant
			if (is_propellant)
			{
				_propellant = new PropellantEnemyFlash();
				_propellant.x = -width / 2;
				addChild(_propellant);
				
				propellantTween();
			}
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
			
			if (!(_graphic is TransporterFlash)) GameState.game.enemies_container = this;
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
			if (is_kill || GameState.game.hero.is_kill || !hitTestObject(GameState.game.hero)) return;
			
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
			
			GameState.game.destroyElementOfList(this);
			
			if (_tween)
			{
				_tween.kill();
				_tween = null;
			}
			
			if (_fire_timer)
			{
				_fire_timer.removeEventListener(TimerEvent.TIMER, completeFireTimer);
				_fire_timer.stop();
				_fire_timer = null;
			}
			
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
			
			if (_life > 0)
			{
				GameState.game.destroyElement(this);
				return;
			}
			
			GameState.game.incrementationEnemyKill();
			GameState.game.incrementationComboEnemy();
			
			rotation = Tools.random(0, 359);
			_graphic.gotoAndStop(Common.FRAME_ENTITY_DEAD);
			
			SoundManager.getInstance().play(SoundManager.EXPLOSION);
			
			var remove_timer:Timer = new Timer(Common.TIMER_ANIMATION_DEAD);
			
			remove_timer.addEventListener(TimerEvent.TIMER, function timerRemove(e:TimerEvent):void
			{
				remove_timer.removeEventListener(TimerEvent.TIMER, timerRemove);
				
				removeAfterTimer();
			});
			
			remove_timer.start();
		}
		
		private function removeAfterTimer():void
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
			
			if (_tween) _tween.pause();
		}
		
		public function resume():void
		{
			_is_pause = false;
			
			if (_fire_timer) _fire_timer.start();
			
			if (_tween) _tween.resume();
		}
		
		/**
		 * Fires
		 */
		
		protected function launchFireTimer():void
		{
			_fire_timer = new Timer(2000);
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
		
		protected function completeTween():void
		{
			_is_tween_finish = true;
		}
		
		private function propellantTween(is_mini:Boolean = true):void
		{
			if (_propellant_tween)
			{
				_propellant_tween.kill();
				_propellant_tween = null;
			}
			
			_propellant_tween = new TweenLite(_propellant, Common.TIMER_TWEEN_PROPELLANT, { scaleX : is_mini? _propellant_scale / 2: _propellant_scale, scaleY : is_mini? _propellant_scale / 2: _propellant_scale, onComplete : propellantTween, onCompleteParams:[!is_mini] } );		
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