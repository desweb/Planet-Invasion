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
			
			var textFormatInput:TextFormat = Common.getPolicy('Arial', 0xffffff, 15);
			var textFormatLabel:TextFormat = Common.getPolicy('Arial', 0x00ffff, 15);
			
			// Username
			var usernameLabel:TextField = new TextField();
			usernameLabel.text			= 'Username';
			usernameLabel.x				= GameState.stageWidth*0.15;
			usernameLabel.y				= GameState.stageHeight*0.1;
			usernameLabel.width			= GameState.stageWidth*0.3;
			usernameLabel.height		= GameState.stageHeight * 0.05;
			usernameLabel.selectable	= false;
			usernameLabel.textColor	= 0x00ffff;
			usernameLabel.setTextFormat(textFormatLabel);
			setPopupContent(usernameLabel);
			
			_usernameInput = new TextField();
			_usernameInput.type			= 'input';
			_usernameInput.x			= GameState.stageWidth*0.15;
			_usernameInput.y			= GameState.stageHeight*0.15;
			_usernameInput.width		= GameState.stageWidth*0.3;
			_usernameInput.height		= GameState.stageHeight*0.05;
			_usernameInput.border 		= true;
			_usernameInput.borderColor	= 0x00ffff;
			_usernameInput.textColor	= 0xffffff;
			_usernameInput.setTextFormat(textFormatInput);
			setPopupContent(_usernameInput);
			
			// Password
			var passwordLabel:TextField = new TextField();
			passwordLabel.text			= 'Password';
			passwordLabel.x				= GameState.stageWidth*0.15;
			passwordLabel.y				= GameState.stageHeight*0.3;
			passwordLabel.width			= GameState.stageWidth*0.3;
			passwordLabel.height		= GameState.stageHeight * 0.05;
			passwordLabel.selectable	= false;
			passwordLabel.textColor		= 0x00ffff;
			passwordLabel.setTextFormat(textFormatLabel);
			setPopupContent(passwordLabel);
			
			_passwordInput = new TextField();
			_passwordInput.type					= 'input';
			_passwordInput.x					= GameState.stageWidth*0.15;
			_passwordInput.y					= GameState.stageHeight * 0.35;
			_passwordInput.width				= GameState.stageWidth*0.3;
			_passwordInput.height				= GameState.stageHeight*0.05;
			_passwordInput.border				= true;
			_passwordInput.borderColor			= 0x00ffff;
			_passwordInput.textColor			= 0xffffff;
			_passwordInput.displayAsPassword	= true;
			_passwordInput.setTextFormat(textFormatInput);
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
			
			_submitBtn.addEventListener(MouseEvent.MOUSE_OVER,	over);
			_submitBtn.addEventListener(MouseEvent.MOUSE_OUT,	out);
			_submitBtn.addEventListener(MouseEvent.CLICK,				clickSubmit);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy LoginPopup');
			
			_submitBtn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
			_submitBtn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
			_submitBtn.removeEventListener(MouseEvent.CLICK,				clickSubmit);
			
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
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, completeResponse);
			_loader.load(API.post_auth(_usernameInput.text, _passwordInput.text));
			
			addEventListener(Event.ENTER_FRAME, updateResponse);
		}
		
		private function updateResponse(e:Event):void
		{
			_submitLoader.rotation += 10;
		}
		
		private function completeResponse(e:Event):void
		{
			_isURLLoader = false;
			
			_submitLoader	.alpha = 0;
			_submitBtn		.alpha = 1;
			
			removeEventListener(Event.ENTER_FRAME, updateResponse);
			
			_loader.removeEventListener(Event.COMPLETE, completeResponse);
			
			var loader:URLLoader = URLLoader(e.target);
			
			var xml:XML;
			xml = new XML(loader.data);
			
			if (xml.error.length() > 0)
			{
				displayErrorPopup('Login failed !');
				return;
			}
			
			GameState.user.login(xml.access_token, xml.expired_at);
			
			SceneManager.getInstance().setCurrentScene(Common.SCENE_MENU);
		}
	}
}