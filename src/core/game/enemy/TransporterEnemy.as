package core.game.enemy 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	import core.Common;
	import core.GameState;
	import core.game.weapon.enemy.EnemyGun;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class TransporterEnemy extends Enemy
	{
		private var _fighter_timer		:Number;
		private var _fighter_timer_init	:uint = 5;
		
		public var deployement_area:int = 150;
		
		public function TransporterEnemy()
		{
			_life						= 150;
			_collision_damage	= 20;
			_metal					= 5;
			_crystal					= 1;
			_money				= 3;
			_tween_complete_destroy = TWEEN_COMPLETE_DETROY_FALSE;
			
			_graphic = new TransporterFlash();
			addChild(_graphic);
			
			_target_x = Tools.random(GameState.stageWidth * .5, GameState.stageWidth - width);
			
			y = Tools.random(deployement_area, GameState.stageHeight - deployement_area);
			
			super();
			
			rotation = 180;
			
			launchFireTimer();
			
			completeFireTimer(null);
			
			GameState.game.transporters_container	= this;
		}
		
		/**
		 * Overrides
		 */
		
		override protected function update(e:Event):void
		{
			super.update(e);
			
			if (!_is_tween_finish || is_kill) return;
			
			_fighter_timer -= dt;
			
			if (_fighter_timer > 0) return;
			
			launchFighter();
			
			_fighter_timer = _fighter_timer_init;
		}
		
		/**
		 * Events
		 */
		
		override protected function completeFireTimer(e:TimerEvent):void
		{
			new EnemyGun(Common.FIRE_MIDDLE_LEFT,	this);
			new EnemyGun(Common.FIRE_MIDDLE_RIGHT,	this);
		}
		
		/**
		 * Functions
		 */
		
		private function launchFighter():void
		{
			for (var i:int = 0; i < 2; i++) new LightFighterEnemy(true, this);
		}
	}
}