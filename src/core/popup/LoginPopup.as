package core.popup 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.scene.SceneManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class LoginPopup extends Popup implements IPopup 
	{
		private var _isURLLoader:Boolean = false;
		private var _loader:URLLoader;
		
		private var _usernameInput:TextField;
		private var _passwordInput:TextField;
		private var _submitLoader:Loader;
		private var _submitBtn:Btn;
		
		public function LoginPopup() 
		{
			if (Common.IS_DEBUG) trace('create LoginPopup');
			
			setTitleText('Login');
			
			generatePopup();
			
			// Username
			var usernameLabel:TextField = generateInputLabel('Username');
			usernameLabel.x	= GameState.stageWidth*0.15;
			usernameLabel.y	= GameState.stageHeight*0.1;
			setPopupContent(usernameLabel);
			
			_usernameInput = generateInput();
			_usernameInput.x	= GameState.stageWidth*0.15;
			_usernameInput.y	= GameState.stageHeight*0.15;
			setPopupContent(_usernameInput);
			
			// Password
			var passwordLabel:TextField = generateInputLabel('Password');
			passwordLabel.x	= GameState.stageWidth*0.15;
			passwordLabel.y	= GameState.stageHeight*0.3;
			setPopupContent(passwordLabel);
			
			_passwordInput = generateInput();
			_passwordInput.x	= GameState.stageWidth*0.15;
			_passwordInput.y	= GameState.stageHeight * 0.35;
			_passwordInput.displayAsPassword = true;
			setPopupContent(_passwordInput);
			
			// Loader
			_submitLoader = new Loader();
			_submitLoader.alpha = 0;
			_submitLoader.scaleX = 0.5;
			_submitLoader.scaleY = 0.5;
			_submitLoader.x = GameState.stageWidth*0.3;
			_submitLoader.y = GameState.stageHeight*0.5;
			setPopupContent(_submitLoader);
			
			// Submit
			_submitBtn = generateBtn('Submit');
			_submitBtn.x = GameState.stageWidth*0.15;
			_submitBtn.y = GameState.stageHeight*0.5;
			setPopupContent(_submitBtn);
			
			_submitBtn.addEventListener(MouseEvent.CLICK, clickSubmit);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy LoginPopup');
			
			_submitBtn.removeEventListener(MouseEvent.CLICK, clickSubmit);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickSubmit(e:MouseEvent):void
		{
			if (!_usernameInput.text || !_passwordInput.text)
			{
				displayErrorPopup('All fields are required !');
				return;
			}
			
			_isURLLoader = true;
			
			_submitLoader	.alpha = 1;
			_submitBtn		.alpha = 0;
			
			API.post_auth(_usernameInput.text, _passwordInput.text,
			function(response:XML):void
			{
				_isURLLoader = false;
				
				_submitLoader	.alpha = 0;
				_submitBtn		.alpha = 1;
				
				removeEventListener(Event.ENTER_FRAME, updateResponse);
				
				if (response.error.length() > 0)
				{
					displayErrorPopup('Login failed !');
					return;
				}
				
				SceneManager.getInstance().setCurrentScene(Common.SCENE_MENU);
			});
			
			addEventListener(Event.ENTER_FRAME, updateResponse);
		}
		
		private function updateResponse(e:Event):void
		{
			_submitLoader.rotation += 10;
		}
	}
}