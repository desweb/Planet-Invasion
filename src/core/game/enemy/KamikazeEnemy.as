package core.game.enemy 
{
	import flash.utils.Dictionary;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.BezierPlugin;
	
	import core.GameState;
	import core.game.Hero;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class KamikazeEnemy extends Enemy
	{
		private var _tween_x:int;
		private var _tween_y:int;
		
		private var target:Hero;
		
		private var _ratio_touch_target:Number = .1;
		
		public function KamikazeEnemy() 
		{
			TweenPlugin.activate([BezierPlugin]);
			
			_life = 5;
			_collision_damage = 20;
			
			_graphic = new KamikazeFlash();
			_graphic.rotation = 180;
			addChild(_graphic);
			
			target = GameState.game.hero;
			
			launchTween();
		}
		
		/**
		 * Tweens
		 */
		
		private function launchTween():void
		{
			if (_tween)
			{
				_tween.kill();
				_tween = null;
			}
			
			_tween = new TweenLite(this, Tools.random(1, 3), { bezier:[ { x:target.x * .5, y:target.y * .5 }, { x:target.x, y:target.y } ], orientToBezier:true, ease:Linear.easeNone, onComplete:launchTween } );
		}
	}
}