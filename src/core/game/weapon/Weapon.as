package core.game.weapon 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.Hero;
	import core.game.enemy.Enemy;
	
	/**
	 * Class of weapons
	 * @author desweb
	 */
	public class Weapon extends Sprite
	{
		private var _is_hit		:Boolean = false;
		private var _isKilled	:Boolean = false;
		protected var _is_hit_destroy:Boolean = true;
		
		public var dt:Number = 0;
		
		public var damage:int = 1;
		
		public var moveSpeed:Number = 2;
		
		protected var _tween:TweenLite;
		
		protected var _owner:Sprite;
		protected var _owner_type:uint;
		
		protected var _fire_type:uint;
		
		protected var _graphic:MovieClip;
		
		public function Weapon()
		{
			// Default position
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT:
					y = _owner.y - _owner.height * .25;
					break;
				case Common.FIRE_TOP_LEFT:
					y = _owner.y - _owner.height * .3;
					break;
				case Common.FIRE_TOP_RIGHT:
					y = _owner.y - _owner.height * .2;
					break;
				case Common.FIRE_MIDDLE_DEFAULT:
					y = _owner.y;
					break;
				case Common.FIRE_MIDDLE_LEFT:
					y = _owner.y - _owner.height * .05;
					break;
				case Common.FIRE_MIDDLE_RIGHT:
					y = _owner.y + _owner.height * .05;
					break;
				case Common.FIRE_BOTTOM_DEFAULT:
					y = _owner.y + _owner.height * .25;
					break;
				case Common.FIRE_BOTTOM_LEFT:
					y = _owner.y + _owner.height * .2;
					break;
				case Common.FIRE_BOTTOM_RIGHT:
					y = _owner.y + _owner.height * .3;
					break;
			}
			
			if			(isHero())		constructorHero();
			else if	(isEnemy())	constructorEnemy();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function constructorHero():void
		{
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT:
					x = _owner.x + _owner.width * .25;
					rotation = -45;
					break;
				case Common.FIRE_TOP_LEFT:
					x = _owner.x + _owner.width * .2;
					rotation = -45;
					break;
				case Common.FIRE_TOP_RIGHT:
					x = _owner.x + _owner.width * .3;
					rotation = -45;
					break;
				case Common.FIRE_MIDDLE_DEFAULT:
					x = _owner.x + _owner.width * .5;
					break;
				case Common.FIRE_MIDDLE_LEFT:
					x = _owner.x + _owner.width * .5;
					break;
				case Common.FIRE_MIDDLE_RIGHT:
					x = _owner.x + _owner.width * .5;
					break;
				case Common.FIRE_BOTTOM_DEFAULT:
					x = _owner.x + _owner.width * .25;
					rotation = 45;
					break;
				case Common.FIRE_BOTTOM_LEFT:
					x = _owner.x + _owner.width * .3;
					rotation = 45;
					break;
				case Common.FIRE_BOTTOM_RIGHT:
					x = _owner.x + _owner.width * .2;
					rotation = 45;
					break;
			}
		}
		
		private function constructorEnemy():void
		{
			
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
			
			if			(isHero())		heroUpdate();
			else if	(isEnemy())	enemyUpdate();
		}
		
		private function heroUpdate():void
		{
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.isKilled || !hitTestObject(e_hit)) continue;
				
				_is_hit = true;
				
				e_hit.destroy();
				if (_is_hit_destroy) destroy();
			}
		}
		
		private function enemyUpdate():void
		{
			// Hero hit
			if (hitTestObject(GameState.game.hero))
			{
				_is_hit = true;
				
				GameState.game.hero.destroy();
				if (_is_hit_destroy) destroy();
			}
		}
		
		// Destroy
		public function destroy():void
		{
			if (_isKilled) return;
			
			_isKilled = true;
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			if (_tween)
			{
				_tween.pause();
				_tween.kill();
			}
			
			if (!_is_hit || !_is_hit_destroy)
			{
				removeThis();
				return;
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
		
		/**
		 * Check
		 */
		
		public function isHero():Boolean
		{
			return _owner_type == Common.OWNER_HERO;
		}
		
		public function isEnemy():Boolean
		{
			return _owner_type == Common.OWNER_ENEMY;
		}
	}
}