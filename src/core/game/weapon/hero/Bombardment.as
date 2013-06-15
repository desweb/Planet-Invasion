package core.game.weapon.hero 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.Common;
	import core.GameState;
	import core.game.enemy.Enemy;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Bombardment extends Sprite
	{
		public var isFinish:Boolean = false;
		
		private var _timerFinish					:Timer = new Timer(2000);
		private var _timerEnemiesDetroy	:Timer = new Timer(500);
		
		private var missileTrianglePoints:Vector.<Number> = new Vector.<Number>(6, true);
		
		private var _lastMissile:Sprite;
		
		public function Bombardment()
		{
			if (Common.IS_DEBUG) trace('create Bombardment');
			
			missileTrianglePoints[0] = 0;
			missileTrianglePoints[1] = 0;
			missileTrianglePoints[2] = 15;
			missileTrianglePoints[3] = 5;
			missileTrianglePoints[4] = 0;
			missileTrianglePoints[5] = 10;
			
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		// Init
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			_timerFinish				.addEventListener(TimerEvent.TIMER, endTimerFinish);
			_timerEnemiesDetroy	.addEventListener(TimerEvent.TIMER, endTimerEnemiesDestroy);
			
			_timerFinish		.start();
			_timerEnemiesDetroy	.start();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (!isFinish && Tools.random(1, 3) == 1)
			{
				var new_m:Sprite = new Sprite();
				new_m.x = Tools.random(0, GameState.stageWidth);
				new_m.y = -20;
				new_m.rotation = 60;
				
				new_m.graphics.beginFill(0xededed);
				new_m.graphics.drawTriangles(missileTrianglePoints);
				new_m.graphics.endFill();
				
				addChild(new_m);
				
				_lastMissile = new_m;
				
				TweenLite.to(new_m, 1, { x:new_m.x + GameState.stageWidth * 0.2, y:GameState.stageHeight+20, ease:Linear.easeNone, onComplete:removeChild, onCompleteParams:[new_m] } );
			}
			
			if (isFinish && _lastMissile.y > GameState.stageHeight) destroy();
		}
		
		private function endTimerFinish(e:TimerEvent):void
		{
			_timerFinish.stop();
			
			isFinish = true;
		}
		
		private function endTimerEnemiesDestroy(e:TimerEvent):void
		{
			for each(var e_destroy:Enemy in GameState.game.enemies)
			{
				if (Tools.random(1, 6) == 1) e_destroy.destroy();
			}
		}
		
		public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy Bombardment');
			
			_timerEnemiesDetroy.stop();
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_timerFinish		.removeEventListener(TimerEvent.TIMER, endTimerFinish);
			_timerEnemiesDetroy	.removeEventListener(TimerEvent.TIMER, endTimerEnemiesDestroy);
			
			GameState.game.powersContainer.removeChild(this);
		}
	}
}