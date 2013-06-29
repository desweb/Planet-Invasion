package core.game.item 
{
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class SpecialItem extends Item
	{
		private var _is_active						:Boolean	= false;
		private var _is_follow_hero				:Boolean	= false;
		private var _is_full_power				:Boolean	= false;
		private var _current_rotation			:int			= 0;
		private var _current_rotation_timer	:Number	= 0;
		
		private var _bullets:Array = new Array();
		
		public function SpecialItem() 
		{
			_type = Common.ITEM_SPEED;
			_item = new ItemSpecialFlash();
			addChild(_item);
			
			scaleX =
			scaleY = .1;
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void
		{
			if (_is_pause) return;
			
			if (_is_full_power)
			{
				// Enemy hit
				for each(var e_hit:Enemy in GameState.game.enemies)
				{
					if (e_hit.is_kill || !e_hit._graphic.hitTestObject(this)) continue;
					
					e_hit.hitWeapon(1000);
				}
				
				return;
			}
			
			if (_is_follow_hero)
			{
				x = GameState.game.hero.x;
				y = GameState.game.hero.y;
				
				_current_rotation_timer -= GameState.game.dt;
				
				if (_current_rotation_timer <= 0)
				{
					_current_rotation++;
					_current_rotation_timer = 1;
				}
				
				rotation += _current_rotation;
				
				if (GameState.game.hero.is_kill)
				{
					destroy();
					return;
				}
				
				if (_current_rotation == 60) explosion();
				
				return;
			}
			
			// Hero hit
			if (!_is_active && hitTestObject(GameState.game.hero))
			{
				_is_hit = true;
				
				launchPower();
			}
		}
		
		/**
		 * Functions
		 */
		
		private function launchPower():void
		{
			if (_is_active) return;
			
			_is_active = true;
			
			if (_tween)
			{
				_tween.kill();
				_tween = null;
			}
			
			_tween = new TweenLite(this, .1, { x : GameState.game.hero.x, y : GameState.game.hero.y, alpha : 0, scaleX : 0, scaleY : 0, onComplete:launchFollowHero } );
		}
		
		private function launchFollowHero():void
		{
			_is_follow_hero = true;
			
			removeChild(_item);
			
			alpha = 1;
			
			scaleX	=
			scaleY	= 1;
			
			for (var i:int = 0; i < 6; i++)
			{
				var p:Point = Tools.pointOnCirclePerimeter(new Point(), 60 * i, 40);
				
				var item:ItemSpecialFlash = new ItemSpecialFlash();
				item.scaleX	=
				item.scaleY	= .05;
				addChild(item);
				
				_bullets[i] = item;
				
				TweenLite.to(item, 1, { x : p.x, y : p.y });
			}
		}
		
		private function explosion():void
		{
			for (var i:int; i < _bullets.length; i++)
				TweenLite.to(_bullets[i], 1, { x : 0, y : 0, onComplete:removeBullet, onCompleteParams:[i] } );
			
			_item.scaleX	=
			_item.scaleY	= .1;
			addChild(_item);
			
			_tween.kill();
			_tween = null;
			
			_tween = new TweenLite(this, .5, { scaleX : .5, scaleY : .5, onComplete:explosion2 } );
		}
		
		private function removeBullet(i:int):void
		{
			removeChild(_bullets[i]);
			_bullets[i] = null;
		}
		
		private function explosion2():void
		{
			_tween.kill();
			_tween = null;
			
			_tween = new TweenLite(this, .1, { scaleX : 0, scaleY : 0, onComplete:explosion3 } );
		}
		
		private function explosion3():void
		{
			_is_full_power = true;
			
			_item.gotoAndStop(2);
			_item.scaleX =
			_item.scaleY = 1;
			
			_tween.kill();
			_tween = null;
			
			_tween = new TweenLite(this, 1, { scaleX : 5, scaleY : 5, onComplete:destroy, onCompleteParams:[false] } );
		}
	}
}