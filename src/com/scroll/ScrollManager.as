package com.scroll 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.jessamin.controls.*;
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	import com.spikything.utils.MouseWheelTrap;
	
	import core.GameState;
	
	/**
	 * Generate scroll with standard skin
	 * @author desweb
	 */
	public class ScrollManager extends Sprite
	{
		private var _width	:int;
		private var _height	:int;
		
		private var _bg			:Sprite;
		private var _win			:Sprite;
		private var _content	:DisplayObject;
		private var _thumb	:Sprite;
		private var _track		:Sprite;
		private var _up			:Sprite;
		private var _down		:Sprite;
		
		public function ScrollManager(content:DisplayObject, width:int = 560, height:int = 360)
		{
			_width	= width;
			_height	= height;
			
			x = (GameState.stageWidth - _width) / 2;
			y = GameState.stageHeight - _height - 20;
			
			_content = content;
			
			MacMouseWheel	.setup(GameState.stage);
			MouseWheelTrap.setup(GameState.stage);
			
			// Background
			_bg = new Sprite();
			_bg.alpha = 0.75;
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			addChild(_bg);
			
			// Window
			_win = new Sprite();
			_win.graphics.beginFill(0x000000);
			_win.graphics.drawRect(0, 0, _width, _height);
			_win.graphics.endFill();
			addChild(_win);
			
			_content.x = 0;
			_content.y = 0;
			_content.mask = _win;
			addChild(_content);
			
			// Up button
			var upPoints:Vector.<Number> = new Vector.<Number>(6, true);
			upPoints[0] = 5;
			upPoints[1] = 0;
			upPoints[2] = 10;
			upPoints[3] = 10;
			upPoints[4] = 0;
			upPoints[5] = 10;
			
			_up = new Sprite();
			_up.x = _width + 10;
			_up.y = 0;
			_up.graphics.beginFill(0x00ffff);
			_up.graphics.drawTriangles(upPoints);
			_up.graphics.endFill();
			addChild(_up);
			
			// Scroll bar bg
			_track = new Sprite();
			_track.x = _width + 10;
			_track.y = 20;
			_track.graphics.beginFill(0x000000);
			_track.graphics.drawRect(0, 0, 10, _height - 40);
			_track.graphics.endFill();
			_track.alpha = 0.5;
			addChild(_track);
			
			// Scroller
			_thumb = new Sprite();
			_thumb.x = _track.x;
			_thumb.y = _track.y;
			_thumb.graphics.beginFill(0x00ffff);
			_thumb.graphics.drawRect(0, 0, 10, 50);
			_thumb.graphics.endFill();
			addChild(_thumb);
			
			// Down button
			var downPoints:Vector.<Number> = new Vector.<Number>(6, true);
			downPoints[0] = 0;
			downPoints[1] = 0;
			downPoints[2] = 10;
			downPoints[3] = 0;
			downPoints[4] = 5;
			downPoints[5] = 10;
			
			_down = new Sprite();
			_down.x = _width + 10;
			_down.y = _height - 10;
			_down.graphics.beginFill(0x00ffff);
			_down.graphics.drawTriangles(downPoints);
			_down.graphics.endFill();
			addChild(_down);
			
			if (_content.height <= _height)
			{
				_track	.visible = false;
				_thumb	.visible = false;
				_up		.visible = false;
				_down	.visible = false;
			}
			
			var scrollbar:VerticalScrollbar = new VerticalScrollbar(GameState.stage, _thumb, _track, _win, _content, _up, _down);
		}
	}
}