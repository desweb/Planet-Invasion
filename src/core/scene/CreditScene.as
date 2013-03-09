package core.scene 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//import com.scroll.ScrollManager;
	//import com.scroll.ScrollBarMovieClip;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * Test scroll
	 */
	import com.jessamin.controls.*;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.pixelbreaker.ui.osx.MacMouseWheel;
	import com.spikything.utils.MouseWheelTrap;
	
	/**
	 * Credits list
	 * @author desweb
	 */
	public class CreditScene extends Scene
	{
		//private var _scroll:ScrollBarMovieClip;
		private var _credits:TextField;
		
		public function CreditScene() 
		{
			if (Common.IS_DEBUG) trace('create CreditScene');
			
			/**
			 * Initialization
			 */
			generateBg();
			generateBtnReturn();
			generateBtnSound();
			generateLogin();
			
			sceneReturn = Common.SCENE_MENU;
			
			var format:TextFormat = Common.getPolicy('Arial', 0xffffff, 20);
			
			/**
			 * Credits list
			 */
			_credits = new TextField();
			_credits.x = 200;
			_credits.y = 100;
			_credits.width = GameState.stageWidth * 0.9;
			_credits.defaultTextFormat = format;
			_credits.text = 'Développeurs\nVictor Delforge\nAudric Fourez \nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez\nDéveloppeurs\nVictor Delforge\nAudric Fourez';
			addChild(_credits);
			
			//_credits.x = GameState.stageWidth/2 - _credits.width/2;
			//_credits.y = GameState.stageHeight / 2 - _credits.height / 2;
			
			/**
			 * Test scroll
			 */
			/*_scroll = new ScrollBarMovieClip();
			
			_scroll.setHeight (200);
 
			// Spécifie le clip ou le sprite cible et sa hauteur maximum
			_scroll.setTarget (_credits, 0);
			
			addChild(_scroll);*/
			
			/*_scroll.x = 100;
			_scroll.y = 100;
			_scroll.width = 200;
			_scroll.height = 200;
			addChild(_scroll);
			
			_scroll.content.addChild(_credits);
			
			_scroll.generateScroll();*/
			
			MacMouseWheel.setup(GameState.stage);
			MouseWheelTrap.setup(GameState.stage);
			
			// Create window
			/*var _content:Sprite = new Sprite();
			_content.x = 200;
			_content.y = 100;
			_content.graphics.beginFill(0xffffff);
			_content.graphics.drawRect(0, 0, 200, 220);
			_content.graphics.endFill();
			addChild(_content);*/
			
			// Create window
			var _win:Sprite = new Sprite();
			_win.x = 200;
			_win.y = 100;
			_win.graphics.beginFill(0xff0000);
			_win.graphics.drawRect(0, 0, 200, 220);
			_win.graphics.endFill();
			addChild(_win);
			
			_credits.mask = _win;
			
			// Create up button
			var upPoints:Vector.<Number> = new Vector.<Number>(6, true);
			upPoints[0] = 5;
			upPoints[1] = 0;
			upPoints[2] = 10;
			upPoints[3] = 10;
			upPoints[4] = 0;
			upPoints[5] = 10;
			
			var _up:Sprite = new Sprite();
			_up.x = 410;
			_up.y = 100;
			_up.graphics.beginFill(0xffff00);
			_up.graphics.drawTriangles(upPoints);
			_up.graphics.endFill();
			addChild(_up);
			
			// Create scroll bar
			var _track:Sprite = new Sprite();
			_track.x = 410;
			_track.y = 120;
			_track.graphics.beginFill(0xffff00);
			_track.graphics.drawRect(0, 0, 10, 150);
			_track.graphics.endFill();
			addChild(_track);
			
			// Create scroll bar
			var _thumb:Sprite = new Sprite();
			_thumb.x = 410;
			_thumb.y = 120;
			_thumb.graphics.beginFill(0xffffff);
			_thumb.graphics.drawRect(0, 0, 10, 20);
			_thumb.graphics.endFill();
			addChild(_thumb);
			
			// Create down button
			var downPoints:Vector.<Number> = new Vector.<Number>(6, true);
			downPoints[0] = 0;
			downPoints[1] = 0;
			downPoints[2] = 10;
			downPoints[3] = 0;
			downPoints[4] = 5;
			downPoints[5] = 10;
			
			var _down:Sprite = new Sprite();
			_down.x = 410;
			_down.y = 280;
			_down.graphics.beginFill(0xffff00);
			_down.graphics.drawTriangles(downPoints);
			_down.graphics.endFill();
			addChild(_down);
			
			var scrollbar:VerticalScrollbar = new VerticalScrollbar(GameState.stage, _thumb, _track, _win, _credits, _up, _down);
		}
	}
}