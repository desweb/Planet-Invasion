package core.scene 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class TutorialScene extends Scene
	{
		
		public function TutorialScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			// Title format
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 20);
			format_title.bold = true;
			
			// Title label
			var title_label:TextField = new TextField();
			title_label.x							= GameState.stageWidth	* .25;
			title_label.y							= GameState.stageHeight	* .1;
			title_label.width						= GameState.stageWidth	* .5;
			title_label.height					= GameState.stageHeight	* .5;
			title_label.defaultTextFormat	= format_title;
			title_label.text						= 'Tutorial';
			title_label.selectable				= false;
			addChild(title_label);
			
			var tutorial:TutorialSceneFlash = new TutorialSceneFlash();
			tutorial.x = GameState.stageWidth	* .125;
			tutorial.y = GameState.stageHeight	* .3;
			
			var bg:Sprite = new Sprite();
			bg.x = tutorial.x - 10;
			bg.y = tutorial.y - 20;
			bg.graphics.beginFill(0x000000, .75);
			bg.graphics.drawRect(0, 0, tutorial.width + 20, tutorial.height + 40);
			bg.graphics.endFill();
			addChild(bg);
			
			addChild(tutorial);
		}
	}
}