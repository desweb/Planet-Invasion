package core.scene 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.API;
	import core.Common;
	import core.GameState;
	
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
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			sceneReturn = Common.SCENE_MENU;
			
			var format:TextFormat = Common.getPolicy('Arial', 0xffffff, 20);
			
			// Title format
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
			format_title.bold = true;
			
			// Title label
			var title_label:TextField = new TextField();
			title_label.x							= GameState.stageWidth	* .25;
			title_label.y							= GameState.stageHeight	* .1;
			title_label.width						= GameState.stageWidth	* .5;
			title_label.height					= GameState.stageHeight	* .5;
			title_label.defaultTextFormat	= format_title;
			title_label.text						= 'Credits';
			title_label.selectable				= false;
			addChild(title_label);
			
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
			credits_graph.text = 'Graphiste\nEstelle Poitevin';
			_scroll_content.addChild(credits_graph);
			
			// Scroll
			_scroll = new ScrollManager(_scroll_content);
			addChild(_scroll);
			
			// Achievement
			if (checkAchievement(Common.ACHIEVEMENT_CURIOSITY, 1))
			{
				if (GameState.user.isLog) API.post_achievementKey(Common.ACHIEVEMENT_CURIOSITY, function(response:XML):void {});
			}
		}
	}
}