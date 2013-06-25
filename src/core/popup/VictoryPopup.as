package core.popup 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
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
			
			// Metal
			var metal_label:TextField = generateInputLabel('Metal : ' + GameState.game.metal);
			metal_label.x	= 0;
			metal_label.y	= GameState.stageHeight * .1;
			setPopupContent(metal_label);
			
			// Crystal
			var crystal_label:TextField = generateInputLabel('Crystal : ' + GameState.game.crystal);
			crystal_label.x	= GameState.stageWidth	* .15;
			crystal_label.y	= GameState.stageHeight	* .1;
			setPopupContent(crystal_label);
			
			// Money
			var money_label:TextField = generateInputLabel('Money : ' + GameState.game.money);
			money_label.x	= GameState.stageWidth	* .3;
			money_label.y	= GameState.stageHeight	* .1;
			setPopupContent(money_label);
			
			if (GameState.game.current_level < 5)
			{
				_next_level_btn		= generateBtn('Next level');
				_next_level_btn.y	= GameState.stageHeight * .5;
			}
			
			_back_menu_btn = generateBtn('Back to menu');
			_back_menu_btn.y	= GameState.stageHeight * .6;
			
			SoundManager.getInstance().play('win');
			
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
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_ADVENTURE, GameState.game.current_level + 1);
		}
		
		private function clickBackMenuBtn(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
	}
}