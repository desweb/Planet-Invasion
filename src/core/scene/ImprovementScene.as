package core.scene 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * Manage user improvements
	 * @author desweb
	 */
	public class ImprovementScene extends Scene
	{
		private var _title_label:TextField;
		
		public function ImprovementScene() 
		{
			if (Common.IS_DEBUG) trace('create ImprovementScene');
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			sceneReturn = Common.SCENE_GAME_MODE;
			
			// Title
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
			format_title.bold = true;
			
			_title_label = new TextField();
			_title_label.x							= GameState.stageWidth	* .25;
			_title_label.y							= GameState.stageHeight	* .1;
			_title_label.width					= GameState.stageWidth	* .5;
			_title_label.height					= GameState.stageHeight	* .5;
			_title_label.defaultTextFormat	= format_title;
			_title_label.text						= 'Improvements';
			_title_label.selectable				= false;
			addChild(_title_label);
			
		}
	}
}