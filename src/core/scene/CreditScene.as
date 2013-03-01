package core.scene 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.Common;
	import core.GameState;
	
	
	/**
	 * Credits list
	 * @author desweb
	 */
	public class CreditScene extends Scene
	{
		private var _scroll:ScrollManager;
		private var _credits:TextField;
		
		public function CreditScene() 
		{
			if (Common.IS_DEBUG) trace('create MenuScene');
			
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
			_credits.width = GameState.stageWidth * 0.9;
			_credits.defaultTextFormat = format;
			_credits.text = 'Développeurs\nVictor Delforge\nAudric Fourez';
			//addChild(_credits);
			
			_credits.x = GameState.stageWidth/2 - _credits.width/2;
			_credits.y = GameState.stageHeight / 2 - _credits.height / 2;
			
			var upPoints:Vector.<Number> = new Vector.<Number>(6, true);
			upPoints[0] = 5;
			upPoints[1] = 0;
			upPoints[2] = 10;
			upPoints[3] = 10;
			upPoints[4] = 0;
			upPoints[5] = 10;
			
			var _up:Sprite = new Sprite();
			_up.x = 100;
			_up.y = 100;
			_up.graphics.beginFill(0xfff000);
			_up.graphics.drawTriangles(upPoints);
			_up.graphics.endFill();
			addChild(_up);
			
			/**
			 * Test scroll
			 */
			_scroll = new ScrollManager();
			_scroll.x = 100;
			_scroll.y = 100;
			_scroll.width = 200;
			_scroll.height = 200;
			addChild(_scroll);
			
			_scroll.content.addChild(_credits);
			
			_scroll.generateScroll();
		}
	}
}