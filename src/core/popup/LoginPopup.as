package core.popup 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class LoginPopup extends Popup
	{
		private var _content:Sprite;
		
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
			usernameLabel.textColor		= 0x00ffff;
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
			_submitLoader.x = GameState.stageWidth*0.15;
			_submitLoader.y = GameState.stageHeight*0.5;
			setPopupContent(_submitLoader);
			
			// Submit
			_submitBtn = new Btn();
			_submitBtn.btn_txt.text = 'Credits';
			_submitBtn.x = GameState.stageWidth*0.15;
			_submitBtn.y = GameState.stageHeight*0.5;
			_submitBtn.btn_txt.selectable = false;
			setPopupContent(_submitBtn);
			
			_submitBtn.addEventListener(MouseEvent.MOUSE_OVER,	over);
			_submitBtn.addEventListener(MouseEvent.MOUSE_OUT,	out);
			_submitBtn.addEventListener(MouseEvent.CLICK,		clickSubmit);
		}
		
		/**
		 * Events
		 */
		
		private function clickSubmit(e:MouseEvent):void
		{
			trace(_usernameInput.text + ' - ' + _passwordInput.text);
			
			_submitLoader	.alpha = 1;
			_submitBtn		.alpha = 0;
		}
	}
}