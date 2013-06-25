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
	public class LoosePopup extends Popup implements IPopup
	{
		private var _restart_btn			:BtnFlash;
		private var _back_menu_btn	:BtnFlash;
		
		public function LoosePopup() 
		{
			generateBackground();
			generateContent(false);
			
			setTitleText('Loose');
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
			
			_restart_btn		= generateBtn('Restart');
			_restart_btn.y	= GameState.stageHeight * .5;
			
			_back_menu_btn	= generateBtn('Back to menu');
			_back_menu_btn.y	= GameState.stageHeight * .6;
			
			SoundManager.getInstance().play('game-over');
			
			// Events
			_restart_btn			.addEventListener(MouseEvent.CLICK, clickRestartBtn);
			_back_menu_btn	.addEventListener(MouseEvent.CLICK, clickBackMenuBtn);
		}
		
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_restart_btn			.removeEventListener(MouseEvent.CLICK, clickRestartBtn);
			_back_menu_btn	.removeEventListener(MouseEvent.CLICK, clickBackMenuBtn);
			
			stage.dispatchEvent(new Event('resumeGameScene'));
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickRestartBtn(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_ADVENTURE, GameState.game.current_level);
		}
		
		private function clickBackMenuBtn(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
	}
}