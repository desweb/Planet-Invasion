package core.scene 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.popup.ErrorPopup;
	import core.popup.LoginPopup;
	import core.scene.IScene;
	import core.scene.SceneManager;
	
	/**
	 * Base of scenes
	 * @author desweb
	 */
	public class Scene extends Sprite implements IScene
	{
		private var _bg:Bg;
		private var _btnReturn:BtnReturn;
		private var _btnSound:BtnSound;
		private var _btnLogin:BtnLeft;
		private var _btnRegister:BtnRight;
		private var _txtUsername:TextField;
		//private var _btnLogout:BtnLogout;
		
		public var sceneReturn:uint;
		
		public var loginPopup:LoginPopup;
		public var errorPopup:ErrorPopup;
		
		public function Scene() 
		{
			
		}
		
		/**
		 * Generation
		 */
		
		// Background
		public function generateBg():void
		{
			_bg = new Bg();
			_bg.gotoAndStop(2);
			addChild(_bg);
		}
		
		// Return button
		public function generateBtnReturn():void
		{
			_btnReturn = new BtnReturn();
			_btnReturn.x = Common.IS_DEBUG? GameState.stageWidth*0.15: GameState.stageWidth*0.05;
			_btnReturn.y = GameState.stageHeight*0.05;
			addChild(_btnReturn);
			
			_btnReturn.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnReturn.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnReturn.addEventListener(MouseEvent.CLICK, clickReturn);
		}
		
		// Sound button
		public function generateBtnSound():void
		{
			_btnSound = new BtnSound();
			_btnSound.x = Common.IS_DEBUG? GameState.stageWidth*0.2: GameState.stageWidth*0.1;
			_btnSound.y = GameState.stageHeight*0.05;
			addChild(_btnSound);
			
			_btnSound.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnSound.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnSound.addEventListener(MouseEvent.CLICK, clickSound);
		}
		
		// Login area
		public function generateLogin():void
		{
			_btnLogin = new BtnLeft();
			_btnLogin.x = GameState.stageWidth * 0.6;
			_btnLogin.y = GameState.stageHeight * 0.05;
			//_btnLogin.btn_txt.text = 'Login';
			//_btnLogin.btn_txt.selectable = false;
			addChild(_btnLogin);
			
			_btnRegister = new BtnRight();
			_btnRegister.x = _btnLogin.x + _btnLogin.width;
			_btnRegister.y = _btnLogin.y;
			//_btnRegister.btn_txt.text = 'Register';
			//_btnRegister.btn_txt.selectable = false;
			addChild(_btnRegister);
			
			_btnLogin.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnLogin.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnLogin.addEventListener(MouseEvent.CLICK, clickLogin);
			
			_btnRegister.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnRegister.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnRegister.addEventListener(MouseEvent.CLICK, clickRegister);
		}
		
		/**
		 * Events
		 */
		
		public function over(e:MouseEvent):void
		{
			buttonMode = true;
		}
		
		public function out(e:MouseEvent):void
		{
			buttonMode = false;
		}
		
		private function clickReturn(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(sceneReturn);
		}
		
		private function clickSound(e:MouseEvent):void
		{
			
		}
		
		private function clickLogin(e:MouseEvent):void
		{
			loginPopup = new LoginPopup();
			addChild(loginPopup);
			loginPopup.display();
			
			loginPopup.close.addEventListener(MouseEvent.CLICK, clickLoginPopupClose);
		}
		
		private function clickRegister(e:MouseEvent):void
		{
			
		}
		
		private function clickLoginPopupClose(e:MouseEvent):void
		{
			loginPopup.removeEventListener(MouseEvent.CLICK, clickLoginPopupClose);
			
			TweenLite.to(loginPopup, 1, {alpha:0, onComplete:removeLoginPopup});
		}
		
		private function clickErrorPopupClose(e:MouseEvent):void
		{
			errorPopup.removeEventListener(MouseEvent.CLICK, clickErrorPopupClose);
			
			TweenLite.to(errorPopup, 1, {alpha:0, onComplete:removeErrorPopup});
		}
		
		/**
		 * Removes
		 */
		
		private function removeLoginPopup():void
		{
			if (!loginPopup) return;
			
			if (Common.IS_DEBUG) trace('delete LoginPopup');
			
			removeChild(loginPopup);
			loginPopup = null;
		}
		
		private function removeErrorPopup():void
		{
			if (!errorPopup) return;
			
			if (Common.IS_DEBUG) trace('delete ErrorPopup');
			
			removeChild(errorPopup);
			errorPopup = null;
		}
	}
}