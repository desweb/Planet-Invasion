package com.scroll 
{
	import flash.display.Sprite;
	
	/**
	 * To use this class, you must instantiate your object, enter your parameters (x, y, width, height) and use "generateScroll" last
	 * @author desweb
	 */
	public class ScrollManager extends Bg // Tmp extends, change by Scroll later
	{
		private static const SCROLL_WIDTH:uint = 20;
		
		private var _bg:Sprite;
		private var _content:Sprite;
		
		private var _scroll:Sprite;
		private var _bar:Sprite;
		private var _up:Sprite;
		private var _down:Sprite;
		
		private var _scrollOffsetY:int;
		
		public function ScrollManager() 
		{
			super();
			
			_content	= new Sprite();
		}
		
		public function generateScroll():void
		{
			trace(width + '*' + height);
			// Background
			_bg = new Sprite();
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0, 0, 200, 200);
			_bg.graphics.endFill();
			_bg.alpha = 0.5;
			addChild(_bg);
			
			// Scrollable content
			_content.width = width - SCROLL_WIDTH;
			_content.height = height;
			addChild(_content);
			
			// Scroll bar
			generateScrollBar();
		}
		
		private function generateScrollBar():void
		{
			_scroll = new Sprite();
			_scroll.x = width - SCROLL_WIDTH;
			_scroll.width = SCROLL_WIDTH;
			_scroll.height = height;
			addChild(_scroll);
			
			// Create up button
			var upPoints:Vector.<Number> = new Vector.<Number>(6, true);
			upPoints[0] = 5;
			upPoints[1] = 0;
			upPoints[2] = 10;
			upPoints[3] = 10;
			upPoints[4] = 0;
			upPoints[5] = 10;
			
			_up = new Sprite();
			_up.graphics.beginFill(0xffff00);
			_up.graphics.drawTriangles(upPoints);
			_up.graphics.endFill();
			_scroll.addChild(_up);
			
			// Create scroll bar
			_bar = new Sprite();
			_bar.graphics.beginFill(0xffff00);
			_bar.graphics.drawRect(0, 0, 10, 20);
			_bar.graphics.endFill();
			_scroll.addChild(_bar);
			
			// Create down button
			var downPoints:Vector.<Number> = new Vector.<Number>(6, true);
			downPoints[0] = 0;
			downPoints[1] = 0;
			downPoints[2] = 10;
			downPoints[3] = 0;
			downPoints[4] = 5;
			downPoints[5] = 10;
			
			_down = new Sprite();
			_down.graphics.beginFill(0xffff00);
			_down.graphics.drawTriangles(downPoints);
			_down.graphics.endFill();
			_scroll.addChild(_down);
		}
		
		/**
		 * Getters functions
		 */
		
		public function get content():Sprite
		{
			return _content;
		}
		
		/**
		 * Setters functions
		 */
	}
}