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
	 * Test scroll
	 */
	/*import com.jessamin.controls.*;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.pixelbreaker.ui.osx.MacMouseWheel;
	import com.spikything.utils.MouseWheelTrap;*/
	
	/**
	 * Credits list
	 * @author desweb
	 */
	public class CreditScene extends Scene
	{
		private var _scroll:ScrollManager;
		private var _scroll_content:Sprite;
		
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
			 * Content scroll
			 */
			_scroll_content = new Sprite();
			
			// Developpers
			var credits_dev:TextField = new TextField();
			credits_dev.width = 560;
			credits_dev.height = 560;
			credits_dev.defaultTextFormat = format;
			credits_dev.text = 'Développeurs\nVictor Delforge\nAudric Fourez';
			_scroll_content.addChild(credits_dev);
			
			// Graphistes
			var credits_graph:TextField = new TextField();
			credits_graph.y = 200;
			credits_graph.width = 560;
			credits_graph.height = 560;
			credits_graph.defaultTextFormat = format;
			credits_graph.text = 'Graphiste\nCaroline Saillot';
			_scroll_content.addChild(credits_graph);
			
			/**
			 * Test scroll
			 */
			_scroll = new ScrollManager(_scroll_content);
			addChild(_scroll);
		}
	}
}