package core.scene 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.popup.ErrorPopup;
	
	/**
	 * Select level for the adventure mode
	 * @author desweb
	 */
	public class SelectLevelScene extends Scene
	{
		private var _level_1_btn:BtnFlash;
		private var _level_2_btn:BtnFlash;
		private var _level_3_btn:BtnFlash;
		private var _level_4_btn:BtnFlash;
		private var _level_5_btn:BtnFlash;
		
		/**
		 * Constructor
		 */
		
		public function SelectLevelScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			generateBtnSound();
			
			_return_scene_uid = Common.SCENE_GAME_MODE;
			
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
			title_label.text						= 'Adventure';
			title_label.selectable				= false;
			addChild(title_label);
			
			/**
			 * Levels
			 */
			
			// Level 1 button
			_level_1_btn = generateBtn('Level 1');
			_level_1_btn.name = '1';
			_level_1_btn.y = GameState.stageHeight * .3;
			
			// Level 2 button
			_level_2_btn = generateBtn('Level 2', GameState.user.level_adventure < 1? Common.FRAME_BTN_LOCK: Common.FRAME_BTN_DEFAULT);
			_level_2_btn.name = '2';
			_level_2_btn.y = GameState.stageHeight * .4;
			
			// Level 3 button
			_level_3_btn = generateBtn('Level 3', GameState.user.level_adventure < 2? Common.FRAME_BTN_LOCK: Common.FRAME_BTN_DEFAULT);
			_level_3_btn.name = '3';
			_level_3_btn.y = GameState.stageHeight * .5;
			
			// Level 4 button
			_level_4_btn = generateBtn('Level 4', GameState.user.level_adventure < 3? Common.FRAME_BTN_LOCK: Common.FRAME_BTN_DEFAULT);
			_level_4_btn.name = '4';
			_level_4_btn.y = GameState.stageHeight * .6;
			
			// Level 5 button
			_level_5_btn = generateBtn('Level 5', GameState.user.level_adventure < 4? Common.FRAME_BTN_LOCK: Common.FRAME_BTN_DEFAULT);
			_level_5_btn.name = '5';
			_level_5_btn.y = GameState.stageHeight * .7;
			
			// Events
			_level_1_btn.addEventListener(MouseEvent.CLICK, clickLevel);
			_level_2_btn.addEventListener(MouseEvent.CLICK, clickLevel);
			_level_3_btn.addEventListener(MouseEvent.CLICK, clickLevel);
			_level_4_btn.addEventListener(MouseEvent.CLICK, clickLevel);
			_level_5_btn.addEventListener(MouseEvent.CLICK, clickLevel);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_level_1_btn.removeEventListener(MouseEvent.CLICK, clickLevel);
			_level_2_btn.removeEventListener(MouseEvent.CLICK, clickLevel);
			_level_3_btn.removeEventListener(MouseEvent.CLICK, clickLevel);
			_level_4_btn.removeEventListener(MouseEvent.CLICK, clickLevel);
			_level_5_btn.removeEventListener(MouseEvent.CLICK, clickLevel);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickLevel(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			var level:int = parseInt(e.target.name);
			
			for (var i:int = 2; i < 6; i++)
			{
				if (level == i && GameState.user.level_adventure < i - 1)
				{
					var error_popup:ErrorPopup = new ErrorPopup();
					error_popup.setText('You must unlock the previous levels.');
					addChild(error_popup);
					error_popup.display();
					return;
				}
			}
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_ADVENTURE, level);
		}
	}
}