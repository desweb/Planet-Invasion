package core.game.weapon 
{
	import core.game.weapon.hero.HeroMissileHoming;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.utils.Tools;
	
	/**
	 * Class of weapons
	 * @author desweb
	 */
	public class Weapon extends Sprite
	{
		private var _is_hit					:Boolean = false;
		private var _is_kill					:Boolean = false;
		protected var _is_pause			:Boolean = false;
		protected var _is_hit_destroy	:Boolean = true;
		
		public var dt:Number = 0;
		
		protected var _damage:int;
		
		protected var _damage_timer:Number = 0;
		protected var _damage_timer_init:Number;
		
		public var moveSpeed:Number = 2;
		
		protected var _tween:TweenLite;
		
		protected var _owner:Sprite;
		protected var _owner_type:uint;
		
		protected var _fire_type:uint;
		
		protected var _graphic:MovieClip;
		
		public function Weapon()
		{
			if (!isReinforcement())
			{
				// Default position
				switch (_fire_type)
				{
					case Common.FIRE_TOP_DEFAULT			: y = _owner.y - _owner.height * .25;	break;
					case Common.FIRE_TOP_LEFT				: y = _owner.y - _owner.height * .3;	break;
					case Common.FIRE_TOP_RIGHT				: y = _owner.y - _owner.height * .2;	break;
					case Common.FIRE_MIDDLE_DEFAULT	: y = _owner.y;			break;
					case Common.FIRE_MIDDLE_LEFT			: y = _owner.y -	5;	break;
					case Common.FIRE_MIDDLE_RIGHT		: y = _owner.y +	5;	break;
					case Common.FIRE_BOTTOM_DEFAULT	: y = _owner.y + _owner.height * .25;	break;
					case Common.FIRE_BOTTOM_LEFT			: y = _owner.y + _owner.height * .2;		break;
					case Common.FIRE_BOTTOM_RIGHT		: y = _owner.y + _owner.height * .3;		break;
				}
			}
			
			if			(isHero())		constructorHero();
			else if	(isEnemy())	constructorEnemy();
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
			
			GameState.game.weapons_container = this;
		}
		
		private function constructorHero():void
		{
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: x = _owner.x + _owner.width * .25;	rotation = -45; break;
				case Common.FIRE_TOP_LEFT				: x = _owner.x + _owner.width * .2;	rotation = -45; break;
				case Common.FIRE_TOP_RIGHT				: x = _owner.x + _owner.width * .3;	rotation = -45; break;
				case Common.FIRE_MIDDLE_DEFAULT	: x = _owner.x + _owner.width * .5; break;
				case Common.FIRE_MIDDLE_LEFT			: x = _owner.x + _owner.width * .5; break;
				case Common.FIRE_MIDDLE_RIGHT		: x = _owner.x + _owner.width * .5; break;
				case Common.FIRE_BOTTOM_DEFAULT	: x = _owner.x + _owner.width * .25;	rotation = 45; break;
				case Common.FIRE_BOTTOM_LEFT			: x = _owner.x + _owner.width * .3;	rotation = 45; break;
				case Common.FIRE_BOTTOM_RIGHT		: x = _owner.x + _owner.width * .2;	rotation = 45; break;
			}
		}
		
		private function constructorEnemy():void
		{
			switch (_fire_type)
			{
				case Common.FIRE_TOP_DEFAULT			: x = _owner.x - _owner.width * .25;	rotation = -135;	break;
				case Common.FIRE_TOP_LEFT				: x = _owner.x - _owner.width * .2;	rotation = -135;	break;
				case Common.FIRE_TOP_RIGHT				: x = _owner.x - _owner.width * .3;	rotation = -135;	break;
				case Common.FIRE_MIDDLE_DEFAULT	: x = _owner.x - _owner.width * .5;	rotation = 180;	break;
				case Common.FIRE_MIDDLE_LEFT			: x = _owner.x - _owner.width * .5;	rotation = 180;	break;
				case Common.FIRE_MIDDLE_RIGHT		: x = _owner.x - _owner.width * .5;	rotation = 180;	break;
				case Common.FIRE_BOTTOM_DEFAULT	: x = _owner.x - _owner.width * .25;	rotation = 135;	break;
				case Common.FIRE_BOTTOM_LEFT			: x = _owner.x - _owner.width * .3;	rotation = 135;	break;
				case Common.FIRE_BOTTOM_RIGHT		: x = _owner.x - _owner.width * .2;	rotation = 135;	break;
			}
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
			if (_is_pause) return;
			
			dt = GameState.game.dt;
			
			if (_damage_timer_init)
			{
				_damage_timer -= dt;
				
				if (_damage_timer > 0)	return;
				else								_damage_timer = _damage_timer_init;
			}
			
			if			(isHero())		heroUpdate();
			else if	(isEnemy())	enemyUpdate();
		}
		
		private function heroUpdate():void
		{
			// Enemy hit
			for each(var e_hit:Enemy in GameState.game.enemies)
			{
				if (e_hit.is_kill || !hitTestObject(e_hit)) continue;
				
				_is_hit = true;
				
				e_hit.hitWeapon(_damage);
				
				if (_is_hit_destroy) destroy();
				
				break;
			}
		}
		
		private function enemyUpdate():void
		{
			// Hero hit
			if (GameState.game.hero.is_kill || !GameState.game.hero.hitTestPoint(x - 10, y, true)) return;
			
			_is_hit = true;
			
			GameState.game.hero.hitWeapon(_damage);
			
			if (_is_hit_destroy) destroy();
		}
		
		// Destroy
		public function destroy():void
		{
			if (_is_kill) return;
			
			_is_kill = true;
			
			GameState.game.destroyElementOfList(this);
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			if (_tween)
			{
				_tween.pause();
				_tween.kill();
			}
			
			if (!_is_hit || !_is_hit_destroy)
			{
				GameState.game.destroyElement(this);
				return;
			}
			
			rotation = Tools.random(0, 359);
			_graphic.gotoAndStop(Common.FRAME_ENTITY_DEAD);
			
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
		
		public function pause():void
		{
			_is_pause = true;
			
			if (_tween) _tween.pause();
		}
		
		public function resume():void
		{
			_is_pause = false;
			
			if (_tween) _tween.resume();
		}
		
		/**
		 * Check
		 */
		
		public function isHero					():Boolean { return _owner_type == Common.OWNER_HERO; }
		public function isEnemy				():Boolean { return _owner_type == Common.OWNER_ENEMY; }
		public function isReinforcement	():Boolean { return _owner_type == Common.OWNER_REINFORCEMENT; }
	}
}