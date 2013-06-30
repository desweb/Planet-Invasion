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
	import core.utils.Security;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class RegisterPopup extends Popup implements IPopup
	{
		private var _is_loading:Boolean = false;
		private var _loader:URLLoader;
		
		private var _emailInput			:TextField;
		private var _usernameInput	:TextField;
		private var _passwordInput	:TextField;
		private var _submitLoader		:LoaderFlash;
		private var _submitBtn			:BtnFlash;
		
		public function RegisterPopup()
		{
			generateBackground();
			generateContent();
			
			setTitleText('Register');
			setPopupHeight(GameState.stageHeight	* .65);
			
			generatePopup();
			
			// Email
			var emailLabel:TextField = generateInputLabel('Email');
			emailLabel.x	= GameState.stageWidth*0.15;
			emailLabel.y	= GameState.stageHeight*0.1;
			setPopupContent(emailLabel);
			
			_emailInput = generateInput();
			_emailInput.x	= GameState.stageWidth*0.15;
			_emailInput.y	= GameState.stageHeight*0.15;
			setPopupContent(_emailInput);
			
			// Username
			var usernameLabel:TextField = generateInputLabel('Username');
			usernameLabel.x	= GameState.stageWidth*0.15;
			usernameLabel.y	= GameState.stageHeight*0.25;
			setPopupContent(usernameLabel);
			
			_usernameInput = generateInput();
			_usernameInput.x	= GameState.stageWidth*0.15;
			_usernameInput.y	= GameState.stageHeight*0.3;
			setPopupContent(_usernameInput);
			
			// Password
			var passwordLabel:TextField = generateInputLabel('Password');
			passwordLabel.x	= GameState.stageWidth*0.15;
			passwordLabel.y	= GameState.stageHeight*0.4;
			setPopupContent(passwordLabel);
			
			_passwordInput = generateInput();
			_passwordInput.x	= GameState.stageWidth*0.15;
			_passwordInput.y	= GameState.stageHeight * 0.45;
			_passwordInput.displayAsPassword = true;
			setPopupContent(_passwordInput);
			
			// Loader
			_submitLoader = new LoaderFlash();
			_submitLoader.alpha = 0;
			_submitLoader.scaleX	= .5;
			_submitLoader.scaleY	= .5;
			_submitLoader.x = GameState.stageWidth	* .3;
			_submitLoader.y = GameState.stageHeight	* .575;
			setPopupContent(_submitLoader);
			
			// Submit
			_submitBtn = generateBtn('Submit');
			_submitBtn.x = GameState.stageWidth	* .18;
			_submitBtn.y = GameState.stageHeight	* .55;
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
			
			if (!_emailInput.text || !_usernameInput.text || !_passwordInput.text)
			{
				displayErrorPopup('All fields are required !');
				return;
			}
			
			if (!Security.isValidEmail(_emailInput.text))
			{
				displayErrorPopup('You must enter a valid email !');
				return;
			}
			
			_is_loading = true;
			
			_submitLoader	.alpha = 1;
			_submitBtn		.alpha = 0;
			
			API.put_user(_usernameInput.text, _emailInput.text, _passwordInput.text,
			function(response:XML):void
			{
				_is_loading = false;
				
				_submitLoader	.alpha = 0;
				_submitBtn		.alpha = 1;
				
				removeEventListener(Event.ENTER_FRAME, updateResponse);
				
				if (response.error.length() > 0)
				{
					displayErrorPopup(response.error.description? response.error.description: 'Register failed !');
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