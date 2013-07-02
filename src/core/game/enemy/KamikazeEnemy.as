package core.game.enemy 
{
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
			
			_life						= 50;
			_collision_damage	= 40;
			_metal					= 2;
			_crystal					= 2;
			_money				= 2;
			
			_graphic = new KamikazeFlash();
			addChild(_graphic);
			
			target = GameState.game.hero;
			
			super();
			
			_propellant.x += 3;
			_propellant_scale = .5;
			
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
			
			_tween = new TweenLite(this, Tools.random(1, 3), { bezier:[ { x:target.x * Tools.random(1, 10) * .1, y:target.y * Tools.random(1, 10) * .1 }, { x:target.x, y:target.y } ], orientToBezier:true, ease:Linear.easeNone, onComplete:launchTween } );
		}
	}
}