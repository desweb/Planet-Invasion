package core.game.enemy 
{
	import flash.events.TimerEvent;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	
	import core.Common;
	import core.game.weapon.enemy.EnemyGun;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class LightFighterEnemy extends Enemy
	{
		private var _is_fire:Boolean = true;
		
		public function LightFighterEnemy(is_transporter:Boolean = false, transporter:TransporterEnemy = null)
		{
			_life			= 15;
			_metal		= 1;
			_crystal		= 0;
			_money	= 1;
			
			_graphic = new FighterLightFlash();
			addChild(_graphic);
			
			super();
			
			_propellant.x += 3;
			_propellant_scale = .5;
			
			launchFireTimer();
			
			new EnemyGun(Common.FIRE_MIDDLE_DEFAULT, this);
			
			if (!is_transporter)
			{
				rotation = 180;
				return;
			}
			
			TweenPlugin.activate([BezierThroughPlugin]);
			
			x = transporter.x;
			y = transporter.y;
			
			_is_fire = false;
			
			var is_top:Boolean = Tools.random(0, 1)? true: false;
			
			var target_y:int = is_top? Tools.random(y - transporter.deployement_area, y - 50): Tools.random(y + 50, y + transporter.deployement_area);
			
			_tween = new TweenLite(this, 1, { bezierThrough:[ { x:transporter.x, y:transporter.y + 50 * (is_top? -1: 1) }, { x:transporter.x - 50, y:target_y } ], orientToBezier:true, ease:Linear.easeNone, onComplete:launchTween } );
			
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			if (!_is_fire) return;
			
			new EnemyGun(Common.FIRE_MIDDLE_DEFAULT, this);
		}
		
		/**
		 * Tweens
		 */
		
		private function launchTween():void
		{
			rotation = 180;
			_is_fire = true;
			
			_tween.kill();
			_tween = null;
			
			_tween = new TweenLite(this, 2, { x : _target_x, ease:Linear.easeNone, onComplete:destroy } );
		}
	}
}