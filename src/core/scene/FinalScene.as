package core.scene 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * Final of the adventure mode
	 * @author desweb
	 */
	public class FinalScene extends Scene
	{
		public function FinalScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			_return_scene_uid = Common.SCENE_GAME_MODE;
			
			var format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 30);
			format.align	= 'center';
			format.bold	= true;
			
			var label:TextField = new TextField();
			label.x							= 0;
			label.y							= GameState.stageHeight * .3;
			label.width						= GameState.stageWidth;
			label.height					= GameState.stageHeight * .5;
			label.defaultTextFormat	= format;
			label.selectable				= false;
			label.text						= 'Congratulations!\n\nYou are a winner!';
			addChild(label);
			
			// Conqueror achievement
			checkAchievement(Common.ACHIEVEMENT_CONQUEROR, 1);
		}
	}
}