package core.scene 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.Interface;
	import core.popup.ErrorPopup;
	import core.popup.LoginPopup;
	import core.popup.RegisterPopup;
	import core.scene.IScene;
	import core.scene.SceneManager;
	
	/**
	 * Base of scenes
	 * @author desweb
	 */
	public class Scene extends Interface implements IScene
	{
		private var _bg:BgFlash;
		private var _btnReturn:BtnReturnFlash;
		private var _btnSound:BtnSoundFlash;
		private var _btnLogin:BtnLeftFlash;
		private var _btnRegister:BtnRightFlash;
		private var _txtUsername:TextField;
		private var _btnLogout:BtnLeftFlash;
		
		public var sceneReturn:uint;
		
		public function Scene()
		{
			
		}
		
		/**
		 * Generation
		 */
		
		// Background
		protected function generateBg():void
		{
			_bg = new BgFlash();
			_bg.gotoAndStop(2);
			addChild(_bg);
		}
		
		// Return button
		protected function generateBtnReturn():void
		{
			_btnReturn = new BtnReturnFlash();
			_btnReturn.x = Common.IS_DEBUG? GameState.stageWidth*0.15: GameState.stageWidth*0.02;
			_btnReturn.y = GameState.stageHeight*0.055;
			addChild(_btnReturn);
			
			_btnReturn.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnReturn.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnReturn.addEventListener(MouseEvent.CLICK, clickReturn);
		}
		
		// Sound button
		protected function generateBtnSound():void
		{
			_btnSound = new BtnSoundFlash();
			_btnSound.x = Common.IS_DEBUG? GameState.stageWidth*0.2: GameState.stageWidth*0.1;
			_btnSound.y = GameState.stageHeight*0.05;
			addChild(_btnSound);
			
			_btnSound.addEventListener(MouseEvent.MOUSE_OVER, over);
			_btnSound.addEventListener(MouseEvent.MOUSE_OUT, out);
			_btnSound.addEventListener(MouseEvent.CLICK, clickSound);
		}
		
		// Login area
		protected function generateLogin():void
		{
			if (GameState.user.isLog)
			{
				_btnLogout = generateBtnLeft('Logout');
				_btnLogout.x = GameState.stageWidth * 0.6;
				_btnLogout.y = GameState.stageHeight * 0.05;
				
				_btnLogout.addEventListener(MouseEvent.CLICK, clickLogout);
			}
			else
			{
				_btnLogin = generateBtnLeft('Login');
				_btnLogin.x = GameState.stageWidth * 0.6;
				_btnLogin.y = GameState.stageHeight * 0.05;
				
				_btnRegister = generateBtnRight('Register');
				_btnRegister.x = _btnLogin.x + _btnLogin.width;
				_btnRegister.y = _btnLogin.y;
				
				_btnLogin		.addEventListener(MouseEvent.CLICK, clickLogin);
				_btnRegister	.addEventListener(MouseEvent.CLICK, clickRegister);
			}
		}
		
		/**
		 * Events
		 */
		
		private function clickReturn(e:MouseEvent):void
		{
			SceneManager.getInstance().setCurrentScene(sceneReturn);
		}
		
		private function clickSound(e:MouseEvent):void
		{
			
		}
		
		private function clickLogin(e:MouseEvent):void
		{
			var loginPopup:LoginPopup = new LoginPopup();
			addChild(loginPopup);
			loginPopup.display();
		}
		
		private function clickLogout(e:MouseEvent):void
		{
			GameState.user.logout();
			
			SceneManager.getInstance().setCurrentScene(SceneManager.getInstance().sceneId);
		}
		
		private function clickRegister(e:MouseEvent):void
		{
			var registerPopup:RegisterPopup = new RegisterPopup();
			addChild(registerPopup);
			registerPopup.display();
		}
		
		/**
		 * Removes
		 */
		
		public function destroy():void
		{
			if (_btnLogout)	_btnLogout	.removeEventListener(MouseEvent.CLICK, clickLogout);
			if (_btnLogin)		_btnLogin		.removeEventListener(MouseEvent.CLICK, clickLogin);
			if (_btnRegister)	_btnRegister	.removeEventListener(MouseEvent.CLICK, clickRegister);
			
			GameState.main.removeChild(this);
		}
	}
}