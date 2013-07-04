package core.popup 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.text.TextField;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	import core.scene.SceneManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class LoginPopup extends Popup implements IPopup 
	{
		private var _is_loading:Boolean = false;
		private var _loader:URLLoader;
		
		private var _usernameInput:TextField;
		private var _passwordInput:TextField;
		private var _submitLoader:LoaderFlash;
		private var _submitBtn:BtnFlash;
		
		public function LoginPopup() 
		{
			generateBackground();
			generateContent();
			
			setTitleText('Login');
			setPopupHeight(GameState.stageHeight * .5);
			
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
			passwordLabel.y	= GameState.stageHeight*0.25;
			setPopupContent(passwordLabel);
			
			_passwordInput = generateInput();
			_passwordInput.x	= GameState.stageWidth*0.15;
			_passwordInput.y	= GameState.stageHeight * 0.3;
			_passwordInput.displayAsPassword = true;
			setPopupContent(_passwordInput);
			
			// Loader
			_submitLoader = new LoaderFlash();
			_submitLoader.alpha = 0;
			_submitLoader.scaleX = 0.5;
			_submitLoader.scaleY = 0.5;
			_submitLoader.x = GameState.stageWidth*0.3;
			_submitLoader.y = GameState.stageHeight*0.425;
			setPopupContent(_submitLoader);
			
			// Submit
			_submitBtn = generateBtn('Submit');
			_submitBtn.x = GameState.stageWidth*0.18;
			_submitBtn.y = GameState.stageHeight*0.4;
			setPopupContent(_submitBtn);
			
			_submitBtn.addEventListener(MouseEvent.CLICK, clickSubmit);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			_submitBtn.removeEventListener(MouseEvent.CLICK, clickSubmit);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickSubmit(e:MouseEvent):void
		{
			if (_is_loading) return;
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			if (!_usernameInput.text || !_passwordInput.text)
			{
				displayErrorPopup('All fields are required !');
				return;
			}
			
			_is_loading = true;
			
			_submitLoader	.alpha = 1;
			_submitBtn		.alpha = 0;
			
			_submitBtn.y = GameState.stageHeight;
			
			addEventListener(Event.ENTER_FRAME, updateLoader);
			
			API.post_auth(_usernameInput.text, _passwordInput.text,
			function(response:XML):void
			{
				_is_loading = false;
				
				_submitLoader	.alpha = 0;
				_submitBtn		.alpha = 1;
				
				_submitBtn.y = GameState.stageHeight * .4;
				
				removeEventListener(Event.ENTER_FRAME, updateLoader);
				
				if (response.error.length() > 0)
				{
					displayErrorPopup(response.error.description? response.error.description: 'Login failed !');
					return;
				}
				
				SceneManager.getInstance().setCurrentScene(Common.SCENE_MENU);
			});
		}
		
		private function updateLoader(e:Event):void
		{
			_submitLoader.rotation += 10;
		}
	}
}