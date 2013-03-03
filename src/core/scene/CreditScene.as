package core.scene 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	import com.scroll.ScrollBarMovieClip;
	
	import core.Common;
	import core.GameState;
	
	
	/**
	 * Credits list
	 * @author desweb
	 */
	public class CreditScene extends Scene
	{
		private var _scroll:ScrollBarMovieClip;
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
			_credits.width = GameState.stageWidth * 0.9;
			_credits.defaultTextFormat = format;
			_credits.text = 'Développeurs\nVictor Delforge\nAudric Fourez';
			//addChild(_credits);
			
			_credits.x = GameState.stageWidth/2 - _credits.width/2;
			_credits.y = GameState.stageHeight / 2 - _credits.height / 2;
			
			/**
			 * Test scroll
			 */
			_scroll = new ScrollBarMovieClip();
			
			_scroll.setHeight (200);
 
			// Spécifie le clip ou le sprite cible et sa hauteur maximum
			_scroll.setTarget (_credits, 0);
			
			addChild(_scroll);
			
			/*_scroll.x = 100;
			_scroll.y = 100;
			_scroll.width = 200;
			_scroll.height = 200;
			addChild(_scroll);
			
			_scroll.content.addChild(_credits);
			
			_scroll.generateScroll();*/
			
		}
	}
}