package core.game 
{
	import core.game.weapon.hero.Bombardment;
	import core.game.weapon.hero.IEM;
	import core.game.weapon.hero.Reinforcement;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.hero.HeroLaser;
	import core.game.weapon.hero.HeroGun;
	import core.game.weapon.hero.HeroMissile;
	import core.game.weapon.hero.HeroMissileHoming;
	import core.scene.Scene;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Hero extends HeroFlash
	{
		private var _is_available_move:Boolean = false;
		
		private var _keys:Array = new Array();
		
		private static const KEY_GUN						:String = 'a';
		private static const KEY_LAZER					:String = 'z';
		private static const KEY_MISSILE					:String = 'e';
		private static const KEY_MISSILE_HOMING	:String = 'r';
		private static const KEY_IEM						:String = 's';
		private static const KEY_BOMBARDMENT		:String = 'd';
		private static const KEY_REINFORCEMENT	:String = 'f';
		
		private var _propellant:PropellantFlash;
		private var _propellant_tween:TweenLite;
		
		private var _shield:ShieldFlash;
		
		private var _fireGunTimer					:Timer = new Timer(100);
		private var _fireLazerTimer					:Timer = new Timer(1000);
		private var _fireMissileTimer				:Timer = new Timer(1000);
		private var _fireMissileHomingTimer	:Timer = new Timer(1000);
		private var _fireIEMTimer					:Timer = new Timer(5000);
		private var _fireBombardmentTimer	:Timer = new Timer(5000);
		private var _fireReinforcementTimer	:Timer = new Timer(5000);
		
		private var _isPaused:Boolean = false;
		
		// Improvements
		private var _is_gun_double			:Boolean;
		private var _is_missile_double	:Boolean;
		private var _is_tri_force				:Boolean;
		private var _is_iem					:Boolean;
		private var _is_bombardment		:Boolean;
		private var _is_reinforcement		:Boolean;
		
		public function Hero() 
		{
			if (Common.IS_DEBUG) trace('create Hero');
			
			_is_gun_double		= GameState.user.improvements[Common.IMPROVEMENT_GUN_DOUBLE]			? true: false;
			_is_missile_double	= GameState.user.improvements[Common.IMPROVEMENT_MISSILE_DOUBLE]	? true: false;
			_is_tri_force			= GameState.user.improvements[Common.IMPROVEMENT_TRI_FORCE]			? true: false;
			_is_iem					= GameState.user.improvements[Common.IMPROVEMENT_IEM]						? true: false;
			_is_bombardment	= GameState.user.improvements[Common.IMPROVEMENT_BOMB]					? true: false;
			_is_reinforcement	= GameState.user.improvements[Common.IMPROVEMENT_REINFORCE]			? true: false;
			
			x = -width;
			y = GameState.stageHeight / 2;
			
			_propellant = new PropellantFlash();
			_propellant.x = -width / 2;
			addChild(_propellant);
			
			propellantTween();
			
			_shield = new ShieldFlash();
			addChild(_shield);
			
			TweenLite.to(this, 1, { x : width / 2 + 50, onComplete:start });
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			_keys[KEY_GUN]						= new Array();
			_keys[KEY_LAZER]					= new Array();
			_keys[KEY_MISSILE]					= new Array();
			_keys[KEY_MISSILE_HOMING]	= new Array();
			_keys[KEY_IEM]						= new Array();
			_keys[KEY_BOMBARDMENT]		= new Array();
			_keys[KEY_REINFORCEMENT]		= new Array();
			
			for (var i:String in _keys)
			{
				_keys[i]['is_down']	= false;
				_keys[i]['is_timer']	= false;
			}
			
			/**
			 * Globals events
			 */
			
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.addEventListener(KeyboardEvent.KEY_UP,	upKey);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
			
			_fireGunTimer				.addEventListener(TimerEvent.TIMER, enableFireGun);
			_fireLazerTimer				.addEventListener(TimerEvent.TIMER, enableFireLazer);
			_fireMissileTimer			.addEventListener(TimerEvent.TIMER, enableFireMissile);
			_fireMissileHomingTimer	.addEventListener(TimerEvent.TIMER, enableFireMissileHoming);
			_fireIEMTimer				.addEventListener(TimerEvent.TIMER, enableFireIEM);
			_fireBombardmentTimer	.addEventListener(TimerEvent.TIMER, enableFireBombardment);
			_fireReinforcementTimer.addEventListener(TimerEvent.TIMER, enableFireReinforcement);
		}
		
		// Update
		private function update(e:Event):void
		{
			if (_isPaused) return;
			
			var dt:Number = GameState.game.dt;
			
			if (_shield) _shield.rotation += 10;
		}
		
		private function start():void
		{
			_is_available_move = true;
		}
		
		public function pause():void
		{
			_isPaused = true;
		}
		
		public function resume():void
		{
			_isPaused = false;
		}
		
		public function hitItem(type:int):void
		{
			
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
			
			_propellant_tween = new TweenLite(_propellant, Common.TIMER_TWEEN_PROPELLANT, { scaleX : is_mini? .5: 1, scaleY : is_mini? .5: 1, onComplete : propellantTween, onCompleteParams:[!is_mini] } );		
		}
		
		/**
		 * Events
		 */
		
		private function downKey(e:KeyboardEvent):void
		{
			if (_isPaused) return;
			
			var keyCode:String = String.fromCharCode(e.charCode);
			
			for (var i:String in _keys)
			{
				if (keyCode == i && !_keys[keyCode]['is_down'] && !_keys[keyCode]['is_timer'])
				{
					_keys[keyCode]['is_down']	= true;
					_keys[keyCode]['is_timer']	= true;
					
					switch (keyCode)
					{
						case KEY_GUN						: fireGun();				break;
						case KEY_LAZER					: fireLazer();				break;
						case KEY_MISSILE					: fireMissile();			break;
						case KEY_MISSILE_HOMING	: fireMissileHoming();	break;
						case KEY_IEM						: fireIEM();				break;
						case KEY_BOMBARDMENT		: fireBombardment();	break;
						case KEY_REINFORCEMENT		: fireReinforcement();break;
						default: return;
					}
					
					return;
				}
			}
		}
		
		private function upKey(e:KeyboardEvent):void
		{
			if (_isPaused) return;
			
			switch (String.fromCharCode(e.charCode))
			{
				case KEY_GUN						: _keys[KEY_GUN]						['is_down'] = false; break;
				case KEY_LAZER					: _keys[KEY_LAZER]					['is_down'] = false; break;
				case KEY_MISSILE					: _keys[KEY_MISSILE]				['is_down'] = false; break;
				case KEY_MISSILE_HOMING	: _keys[KEY_MISSILE_HOMING]	['is_down'] = false; break;
				case KEY_IEM						: _keys[KEY_IEM]						['is_down'] = false; break;
				case KEY_BOMBARDMENT		: _keys[KEY_BOMBARDMENT]		['is_down'] = false; break;
				case KEY_REINFORCEMENT		: _keys[KEY_REINFORCEMENT]	['is_down'] = false; break;
				default	: return;
			}
		}
		
		private function mouseMove(e:MouseEvent):void
		{
			if (!_is_available_move || _isPaused) return;
			
			TweenLite.to(this, 1, { x:GameState.main.mouseX, y:GameState.main.mouseY });
		}
		
		private function enableFireGun(e:TimerEvent):void
		{
			_fireGunTimer.stop();
			_fireGunTimer.reset();
			_keys[KEY_GUN]['is_timer'] = false;
			
			if (_keys[KEY_GUN]['is_down']) fireGun();
		}
		
		private function enableFireLazer(e:TimerEvent):void
		{
			_fireLazerTimer.stop();
			_fireLazerTimer.reset();
			_keys[KEY_LAZER]['is_timer'] = false;
			
			if (_keys[KEY_LAZER]['is_down']) fireGun();
		}
		
		private function enableFireMissile(e:TimerEvent):void
		{
			_fireMissileTimer.stop();
			_fireMissileTimer.reset();
			_keys[KEY_MISSILE]['is_timer'] = false;
			
			if (_keys[KEY_MISSILE]['is_down']) fireMissile();
		}
		
		private function enableFireMissileHoming(e:TimerEvent):void
		{
			_fireMissileHomingTimer.stop();
			_fireMissileHomingTimer.reset();
			_keys[KEY_MISSILE_HOMING]['is_timer'] = false;
			
			if (_keys[KEY_MISSILE_HOMING]['is_down']) fireMissileHoming();
		}
		
		private function enableFireIEM(e:TimerEvent):void
		{
			_fireIEMTimer.stop();
			_fireIEMTimer.reset();
			_keys[KEY_IEM]['is_timer'] = false;
			
			if (_keys[KEY_IEM]['is_down']) fireIEM();
		}
		
		private function enableFireBombardment(e:TimerEvent):void
		{
			_fireBombardmentTimer.stop();
			_fireBombardmentTimer.reset();
			_keys[KEY_BOMBARDMENT]['is_timer'] = false;
			
			if (_keys[KEY_BOMBARDMENT]['is_down']) fireBombardment();
		}
		
		private function enableFireReinforcement(e:TimerEvent):void
		{
			_fireReinforcementTimer.stop();
			_fireReinforcementTimer.reset();
			_keys[KEY_REINFORCEMENT]['is_timer'] = false;
			
			if (_keys[KEY_REINFORCEMENT]['is_down']) fireReinforcement();
		}
		
		/**
		 * Fire actions
		 */
		
		private function fireGun():void
		{
			if (_is_gun_double && _is_tri_force)
			{
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_TOP_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_TOP_RIGHT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_MIDDLE_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_MIDDLE_RIGHT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_BOTTOM_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_BOTTOM_RIGHT));
			}
			else if (_is_gun_double)
			{
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_MIDDLE_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_MIDDLE_RIGHT));
			}
			else if (_is_tri_force)
			{
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_MIDDLE_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_TOP_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_BOTTOM_DEFAULT));
			}
			else GameState.game.weaponsContainer.addChild(new HeroGun(Common.FIRE_MIDDLE_DEFAULT));
			
			_keys[KEY_GUN]['is_timer'] = true;
			_fireGunTimer.start();
		}
		
		private function fireLazer():void
		{
			if (_is_tri_force)
			{
				GameState.game.weaponsContainer.addChild(new HeroLaser(Common.FIRE_MIDDLE_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroLaser(Common.FIRE_TOP_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroLaser(Common.FIRE_BOTTOM_DEFAULT));
			}
			else GameState.game.weaponsContainer.addChild(new HeroLaser(Common.FIRE_MIDDLE_DEFAULT));
			
			_keys[KEY_LAZER]['is_timer'] = true;
			_fireLazerTimer.start();
		}
		
		private function fireMissile():void
		{
			if (_is_missile_double && _is_tri_force)
			{
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_TOP_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_TOP_RIGHT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_MIDDLE_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_MIDDLE_RIGHT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_BOTTOM_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_BOTTOM_RIGHT));
			}
			else if (_is_missile_double)
			{
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_MIDDLE_LEFT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_MIDDLE_RIGHT));
			}
			else if (_is_tri_force)
			{
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_MIDDLE_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_TOP_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_BOTTOM_DEFAULT));
			}
			else GameState.game.weaponsContainer.addChild(new HeroMissile(Common.FIRE_MIDDLE_DEFAULT));
			
			_keys[KEY_MISSILE]['is_timer'] = true;
			_fireMissileTimer.start();
		}
		
		private function fireMissileHoming():void
		{
			if (_is_tri_force)
			{
				GameState.game.weaponsContainer.addChild(new HeroMissileHoming(Common.FIRE_MIDDLE_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroMissileHoming(Common.FIRE_TOP_DEFAULT));
				GameState.game.weaponsContainer.addChild(new HeroMissileHoming(Common.FIRE_BOTTOM_DEFAULT));
			}
			else GameState.game.weaponsContainer.addChild(new HeroMissileHoming(Common.FIRE_MIDDLE_DEFAULT));
			
			_keys[KEY_MISSILE_HOMING]['is_timer'] = true;
			_fireMissileHomingTimer.start();
		}
		
		/**
		 * Specials actions
		 */
		
		private function fireIEM():void
		{
			if (!_is_iem) return;
			
			GameState.game.powersContainer.addChild(new IEM());
			
			_keys[KEY_IEM]['is_timer'] = true;
			_fireIEMTimer.start();
		}
		
		private function fireBombardment():void
		{
			if (!_is_bombardment) return;
			
			GameState.game.powersContainer.addChild(new Bombardment());
			
			_keys[KEY_BOMBARDMENT]['is_timer'] = true;
			_fireBombardmentTimer.start();
		}
		
		private function fireReinforcement():void
		{
			if (!_is_reinforcement) return;
			
			GameState.game.powersContainer.addChild(new Reinforcement());
			
			_keys[KEY_REINFORCEMENT]['is_timer'] = true;
			_fireReinforcementTimer.start();
		}
		
		// Destroy
		public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy Hero');
			
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
			
			if (_shield)
			{
				removeChild(_shield);
				_shield = null;
			}
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,	downKey);
			stage.removeEventListener(KeyboardEvent.KEY_UP,			upKey);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,	mouseMove);
			
			_fireGunTimer					.removeEventListener(TimerEvent.TIMER, enableFireGun);
			_fireLazerTimer					.removeEventListener(TimerEvent.TIMER, enableFireLazer);
			_fireMissileTimer				.removeEventListener(TimerEvent.TIMER, enableFireMissile);
			_fireMissileHomingTimer		.removeEventListener(TimerEvent.TIMER, enableFireMissileHoming);
			_fireIEMTimer					.removeEventListener(TimerEvent.TIMER, enableFireIEM);
			_fireBombardmentTimer		.removeEventListener(TimerEvent.TIMER, enableFireBombardment);
			_fireReinforcementTimer	.removeEventListener(TimerEvent.TIMER, enableFireReinforcement);
			
			gotoAndStop(Common.FRAME_ENTITY_DEAD);
			
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