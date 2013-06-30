package core.game.item 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	import core.GameState;
	import core.SoundManager;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Item extends Sprite
	{
		private static const SPEED_MIN:uint = 10;
		private static const SPEED_MAX:uint = 2;
		
		protected var _is_pause:Boolean = false;
		protected var _is_hit:Boolean = false;
		
		protected var _type:uint;
		
		protected var _item:MovieClip;
		
		protected var _tween:TweenLite;
		
		public function Item() 
		{
			x = GameState.stageWidth + 100;
			y = Tools.random(100 / 2, GameState.stageHeight - 100 / 2);
			
			_tween = new TweenLite(this, Tools.random(SPEED_MIN, SPEED_MAX), { x : -100, onComplete:destroy } );
			
			GameState.game.items[GameState.game.items.length] = this;
			GameState.game.items_container = this;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function update(e:Event):void
		{
			if (_is_hit || _is_pause) return;
			
			// Hero hit
			if (hitTestObject(GameState.game.hero))
			{
				_is_hit = true;
				
				GameState.game.hero.hitItem(_type);
				destroy(true);
			}
		}
		
		/**
		 * Destroy
		 */
		
		protected function destroy(is_anim:Boolean = false):void
		{
			_tween.kill();
			_tween = null;
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			if (!is_anim)
			{
				removeThis();
				return;
			}
			
			SoundManager.getInstance().play(SoundManager.ITEM);
			
			_tween = new TweenLite(this, .5, { scaleX : 2, scaleY : 2, alpha : 0, onComplete:removeThis });
		}
		
		private function removeThis():void
		{
			if (_tween)
			{
				_tween.kill();
				_tween = null;
			}
			
			parent.removeChild(this);
		}
		
		/**
		 * Manage
		 */
		
		public function pause():void
		{
			if (_is_pause) return;
			
			_is_pause = true;
			
			if (_tween) _tween.pause();
		}
		
		public function resume():void
		{
			if (!_is_pause) return;
			
			_is_pause = false;
			
			if (_tween) _tween.resume();
		}
		
	}
}