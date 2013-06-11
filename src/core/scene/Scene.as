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
		
		private var _return_btn	:BtnReturnFlash;
		private var _sound_btn	:BtnSoundFlash;
		private var _login_btn	:BtnLeftFlash;
		private var _register_btn:BtnRightFlash;
		private var _logout_btn	:BtnDisconnectFlash;
		
		private var _txtUsername:TextField;
		
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
			_return_btn = new BtnReturnFlash();
			_return_btn.x = Common.IS_DEBUG? GameState.stageWidth * .15: GameState.stageWidth * .02;
			_return_btn.y = GameState.stageHeight * .055;
			addChild(_return_btn);
			
			_return_btn.addEventListener(MouseEvent.MOUSE_OVER,	over);
			_return_btn.addEventListener(MouseEvent.MOUSE_OUT,	out);
			_return_btn.addEventListener(MouseEvent.CLICK,			clickReturn);
		}
		
		// Sound button
		protected function generateBtnSound():void
		{
			_sound_btn = new BtnSoundFlash();
			_sound_btn.x = Common.IS_DEBUG? GameState.stageWidth * .2: GameState.stageWidth * .1;
			_sound_btn.y = GameState.stageHeight * .05;
			addChild(_sound_btn);
			
			_sound_btn.addEventListener(MouseEvent.MOUSE_OVER,	over);
			_sound_btn.addEventListener(MouseEvent.MOUSE_OUT,	out);
			_sound_btn.addEventListener(MouseEvent.CLICK,			clickSound);
		}
		
		// Login area
		protected function generateLogin():void
		{
			if (GameState.user.isLog)
			{
				var username_format:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
				username_format.bold = true;
				
				var username_label:TextField = new TextField();
				username_label.x							= GameState.stageWidth	* .8;
				username_label.y							= GameState.stageHeight	* .025;
				username_label.width						= GameState.stageWidth	* .1;
				username_label.height					= GameState.stageHeight	* .1;
				username_label.defaultTextFormat	= username_format;
				username_label.text						= GameState.user.username;
				username_label.selectable				= false;
				addChild(username_label);
				
				_logout_btn = new BtnDisconnectFlash();
				_logout_btn.x = GameState.stageWidth	* .925;
				_logout_btn.y = GameState.stageHeight	* .03;
				_logout_btn.scaleX	=
				_logout_btn.scaleY	= .3;
				addChild(_logout_btn);
				
				_logout_btn.addEventListener(MouseEvent.MOUSE_OVER,	over);
				_logout_btn.addEventListener(MouseEvent.MOUSE_OUT,	out);
				_logout_btn.addEventListener(MouseEvent.CLICK,			clickLogout);
			}
			else
			{
				_login_btn = generateBtnLeft('Login');
				_login_btn.x = GameState.stageWidth		* .55;
				_login_btn.y = GameState.stageHeight	* .05;
				
				_register_btn = generateBtnRight('Register');
				_register_btn.x = _login_btn.x + _login_btn.width;
				_register_btn.y = _login_btn.y;
				
				_login_btn		.addEventListener(MouseEvent.CLICK, clickLogin);
				_register_btn	.addEventListener(MouseEvent.CLICK, clickRegister);
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
			if (_return_btn)
			{
				_return_btn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_return_btn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
				_return_btn.removeEventListener(MouseEvent.CLICK,				clickReturn);
			}
			
			if (_sound_btn)
			{
				_sound_btn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_sound_btn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
				_sound_btn.removeEventListener(MouseEvent.CLICK,				clickSound);
			}
			
			if (_login_btn) _login_btn.removeEventListener(MouseEvent.CLICK, clickLogin);
			
			if (_logout_btn)
			{
				_logout_btn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_logout_btn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
				_logout_btn.removeEventListener(MouseEvent.CLICK,				clickLogout);
			}
			
			if (_register_btn) _register_btn.removeEventListener(MouseEvent.CLICK, clickRegister);
			
			GameState.main.removeChild(this);
		}
	}
}