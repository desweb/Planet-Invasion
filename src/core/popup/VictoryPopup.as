package core.popup 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.scene.SceneManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class VictoryPopup extends Popup implements IPopup
	{
		private var _next_level_btn	:BtnFlash;
		private var _back_menu_btn	:BtnFlash;
		
		public function VictoryPopup() 
		{
			generateBackground();
			generateContent(false);
			
			setTitleText('Victory');
			setPopupHeight(GameState.stageHeight * .5);
			
			generatePopup();
			
			var interface_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 10);
			interface_format.align = 'center';
			
			// Metal
			var metal_label:TextField = new TextField();
			metal_label.x								= GameState.stageWidth	* .05;
			metal_label.y								= GameState.stageHeight	* .1;
			metal_label.width						= GameState.stageWidth	* .15;
			metal_label.height						= 30;
			metal_label.defaultTextFormat	= interface_format;
			metal_label.selectable				= false;
			metal_label.text							= 'Metal : ' + GameState.game.metal;
			setPopupContent(metal_label);
			
			// Crystal
			var crystal_label:TextField = new TextField();
			crystal_label.x							= GameState.stageWidth	* .225;
			crystal_label.y							= GameState.stageHeight	* .1;
			crystal_label.width						= GameState.stageWidth	* .15;
			crystal_label.height					= 30;
			crystal_label.defaultTextFormat	= interface_format;
			crystal_label.selectable				= false;
			crystal_label.text						= 'Crystal : ' + GameState.game.crystal;
			setPopupContent(crystal_label);
			
			// Money
			var money_label:TextField = new TextField();
			money_label.x							= GameState.stageWidth	* .4;
			money_label.y							= GameState.stageHeight	* .1;
			money_label.width						= GameState.stageWidth	* .15;
			money_label.height					= 30;
			money_label.defaultTextFormat	= interface_format;
			money_label.selectable				= false;
			money_label.text						= 'Money : ' + GameState.game.money;
			setPopupContent(money_label);
			
			// Enemy
			var enemy_label:TextField = new TextField();
			enemy_label.x							= GameState.stageWidth	* .05;
			enemy_label.y							= GameState.stageHeight	* .15;
			enemy_label.width						= GameState.stageWidth	* .15;
			enemy_label.height					= 30;
			enemy_label.defaultTextFormat	= interface_format;
			enemy_label.selectable				= false;
			enemy_label.text						= 'Enemy kill : ' + GameState.game.total_enemy_kill;
			setPopupContent(enemy_label);
			
			// Boost
			var boost_label:TextField = new TextField();
			boost_label.x							= GameState.stageWidth	* .225;
			boost_label.y							= GameState.stageHeight	* .15;
			boost_label.width					= GameState.stageWidth	* .15;
			boost_label.height					= 30;
			boost_label.defaultTextFormat	= interface_format;
			boost_label.selectable			= false;
			boost_label.text						= 'Boost pick : ' + GameState.game.total_boost_pick;
			setPopupContent(boost_label);
			
			// Point
			var point:int = GameState.game.money + GameState.game.crystal + GameState.game.money;
			
			var point_label:TextField = new TextField();
			point_label.x							= GameState.stageWidth	* .4;
			point_label.y							= GameState.stageHeight	* .15;
			point_label.width					= GameState.stageWidth	* .15;
			point_label.height					= 30;
			point_label.defaultTextFormat	= interface_format;
			point_label.selectable				= false;
			point_label.text						= 'Point : ' + point;
			setPopupContent(point_label);
			
			if (GameState.game.current_level < 5)
			{
				_next_level_btn		= generateBtn('Next level');
				_next_level_btn.y	= GameState.stageHeight * .5;
			}
			
			_back_menu_btn = generateBtn('Back to menu');
			_back_menu_btn.y	= GameState.stageHeight * .6;
			
			SoundManager.getInstance().play(SoundManager.WIN);
			
			// Events
			if (_next_level_btn) _next_level_btn.addEventListener(MouseEvent.CLICK, clickNextLevelBtn);
			
			_back_menu_btn.addEventListener(MouseEvent.CLICK, clickBackMenuBtn);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (_next_level_btn) _next_level_btn.removeEventListener(MouseEvent.CLICK, clickNextLevelBtn);
			
			_back_menu_btn.removeEventListener(MouseEvent.CLICK, clickBackMenuBtn);
			
			stage.dispatchEvent(new Event('resumeGameScene'));
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickNextLevelBtn(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			destroy();
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_ADVENTURE, GameState.game.current_level + 1);
		}
		
		private function clickBackMenuBtn(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			destroy();
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
	}
}