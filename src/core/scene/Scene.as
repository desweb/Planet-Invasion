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
		
		public var btnFormat:TextFormat;
		
		public function Scene()
		{
			btnFormat = Common.getPolicy('Arial', 0x00ffff, 15);
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
			_btnLogin = generateBtnLeft('Login');
			_btnLogin.x = GameState.stageWidth * 0.6;
			_btnLogin.y = GameState.stageHeight * 0.05;
			
			_btnRegister = generateBtnRight('Register');
			_btnRegister.x = _btnLogin.x + _btnLogin.width;
			_btnRegister.y = _btnLogin.y;
			
			_btnLogin		.addEventListener(MouseEvent.CLICK, clickLogin);
			_btnRegister	.addEventListener(MouseEvent.CLICK, clickRegister);
		}
		
		/**
		 * Interface
		 */
		
		public function generateBtn(txt:String, frame:int = 1):Btn
		{
			var btn:Btn = new Btn();
			btn.mouseChildren = false;
			addChild(btn);
			
			btn.x = (GameState.stageWidth - btn.width) / 2;
			btn.y = (GameState.stageHeight - btn.height) / 2;
			
			var label:TextField = new TextField();
			label.width						= btn.width;
			label.height					= btn.height;
			label.defaultTextFormat	= btnFormat;
			label.text						= txt;
			label.selectable				= false;
			btn.addChild(label);
			
			btn.gotoAndStop(frame);
			
			btn.addEventListener(MouseEvent.MOUSE_OVER, over);
			btn.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			return btn;
		}
		
		public function generateBtnLeft(txt:String, frame:int = 1):BtnLeft
		{
			var btn:BtnLeft = new BtnLeft();
			btn.mouseChildren = false;
			addChild(btn);
			
			btn.x = (GameState.stageWidth - btn.width) / 2;
			btn.y = (GameState.stageHeight - btn.height) / 2;
			
			var label:TextField = new TextField();
			label.width						= btn.width;
			label.height					= btn.height;
			label.defaultTextFormat	= btnFormat;
			label.text						= txt;
			label.selectable				= false;
			btn.addChild(label);
			
			btn.gotoAndStop(frame);
			
			btn.addEventListener(MouseEvent.MOUSE_OVER, over);
			btn.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			return btn;
		}
		
		public function generateBtnRight(txt:String, frame:int = 1):BtnRight
		{
			var btn:BtnRight = new BtnRight();
			btn.mouseChildren = false;
			addChild(btn);
			
			btn.x = (GameState.stageWidth - btn.width) / 2;
			btn.y = (GameState.stageHeight - btn.height) / 2;
			
			var label:TextField = new TextField();
			label.width						= btn.width;
			label.height					= btn.height;
			label.defaultTextFormat	= btnFormat;
			label.text						= txt;
			label.selectable				= false;
			btn.addChild(label);
			
			btn.gotoAndStop(frame);
			
			btn.addEventListener(MouseEvent.MOUSE_OVER, over);
			btn.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			return btn;
		}
		
		public function generateBtnCenter(txt:String, frame:String = 'default'):TextField
		{
			var label:TextField = new TextField();
			label.width						= GameState.stageWidth * .1;
			label.height					= GameState.stageHeight * .1;
			label.defaultTextFormat	= btnFormat;
			label.text						= txt;
			label.selectable				= false;
			label.border					= true;
			addChild(label);
			
			label.x = (GameState.stageWidth - label.width) / 2;
			label.y = (GameState.stageHeight - label.height) / 2;
			
			if			(frame == 'default')	label.borderColor = 0x00ffff;
			else if	(frame == 'error')		label.borderColor = 0xff0000;
			
			label.addEventListener(MouseEvent.MOUSE_OVER, over);
			label.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			return label;
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
		
		public function destroy():void
		{
			GameState.main.removeChild(this);
		}
	}
}