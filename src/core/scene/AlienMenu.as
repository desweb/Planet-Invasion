package core.scene 
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.BezierPlugin;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class AlienMenu extends AlienMenuFlash
	{
		private var _life:int = 5;
		private var _tween:TweenLite;
		
		public function AlienMenu()
		{
			if (Common.IS_DEBUG) trace('create AlienMenu');
			
			addEventListener(MouseEvent.CLICK, click);
			
			TweenPlugin.activate([BezierPlugin]);
			
			switch (Tools.random(0, 3))
			{
				// Top
				case 0:
					x = Math.random() * GameState.stageWidth;
					y = -height;
					break;
				// Bottom
				case 1:
					x = Math.random() * GameState.stageWidth;
					y = GameState.stageHeight;
					break;
				// Left
				case 2:
					x = -width;
					y = Math.random() * GameState.stageHeight;
					break;
				// Right
				case 3:
					x = GameState.stageWidth;
					y = Math.random() * GameState.stageHeight;
					break;
			}
			
			var coord:Array = new Array();
			
			for (var i:int = 0; i < 2; i++)
			{
				var p:Dictionary = new Dictionary();
				p['x'] = Tools.random(0, GameState.stageWidth);
				p['y'] = Tools.random(0, GameState.stageHeight);
				coord[i] = p;
			}
			
			var p3:Dictionary = new Dictionary();
			switch (Tools.random(0, 3))
			{
				// Top
				case 0:
					p3['x'] = Tools.random(0, GameState.stageWidth);
					p3['y'] = -height;
					break;
				// Bottom
				case 1:
					p3['x'] = Tools.random(0, GameState.stageHeight);
					p3['y'] = -height;
					break;
				// Left
				case 2:
					p3['x'] = -width;
					p3['y'] = Tools.random(0, GameState.stageHeight);
					break;
				// Right
				case 3:
					p3['x'] = GameState.stageWidth;
					p3['y'] = Tools.random(0, GameState.stageHeight);
					break;
			}
			coord[2] = p3;
			
			_tween = new TweenLite(this, 5, { bezier:coord, onComplete:destroy });
			
			SoundManager.getInstance().playMenuAlien();
		}
		
		/**
		 * Overload
		 */
		
		private function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy AlienMenu');
			
			removeEventListener(MouseEvent.CLICK, click);
			
			if (_tween)
			{
				_tween.pause();
				_tween.kill();
				_tween = null;
			}
			
			if (_life > 0) removeThis();
			else
			{
				gotoAndStop(Common.FRAME_ENTITY_DEAD);
				
				var remove_timer:Timer = new Timer(Common.TIMER_ANIMATION_DEAD);
				
				remove_timer.addEventListener(TimerEvent.TIMER, function timerRemove(e:TimerEvent):void
				{
					remove_timer.removeEventListener(TimerEvent.TIMER, timerRemove);
					
					removeThis();
				});
				
				remove_timer.start();
			}
		}
		
		private function removeThis():void
		{
			parent.removeChild(this);
		}
		
		/**
		 * Events
		 */
		
		private function click(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuAlienHit();
			
			_life--;
			
			if (_life > 0) return;
			
			SoundManager.getInstance().playMenuAlienDead();
			
			// Achievement
			if (SceneManager.getInstance().scene.checkAchievement(Common.ACHIEVEMENT_ALIEN_BLAST, 1))
			{
				if (GameState.user.isLog) API.post_achievementKey(Common.ACHIEVEMENT_ALIEN_BLAST, function(response:XML):void {});
			}
			
			destroy();
		}
	}
}