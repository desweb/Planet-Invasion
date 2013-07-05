package core.scene 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class SelectSpecialLevelScene extends Scene
	{
		private var buttons:Array = new Array();
		
		public function SelectSpecialLevelScene() 
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
			title_label.text						= 'Special levels';
			title_label.selectable				= false;
			addChild(title_label);
			
			var i:uint = 0;
			if (GameState.user.levels.length <= 5)
			{
				for each (var level:Array in GameState.user.levels)
				{
					buttons[i] = generateBtn(level.name);
					buttons[i].name = level.key;
					buttons[i].y = GameState.stageHeight * .3 + GameState.stageHeight * .1 * i;
					
					buttons[i].addEventListener(MouseEvent.CLICK, clickLevel);
					
					i++;
				}
			}
			else
			{
				for each (var level2:Array in GameState.user.levels)
				{
					buttons[i] = generateBtn(level2.name);
					buttons[i].name = level2.key;
					buttons[i].y = GameState.stageHeight * .3 + GameState.stageHeight * .1 * (i < 5? i: i - 5);
					buttons[i].x = i < 5? GameState.stageWidth * .2: GameState.stageWidth * .6;
					
					buttons[i].addEventListener(MouseEvent.CLICK, clickLevel);
					
					i++;
				}
			}
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			for each (var b:BtnFlash in buttons) b.removeEventListener(MouseEvent.CLICK, clickLevel);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickLevel(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_SPECIAL, parseInt(e.target.name));
		}
	}
}