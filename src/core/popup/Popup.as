package core.popup 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.greensock.TweenLite;
	
	import core.Common;
	import core.GameState;
	import core.Interface;
	import core.SoundManager;
	import core.scene.SceneManager;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Popup extends Interface
	{
		public static const ANIM_TIMER	:Number = .5;
		public static const BG_ALPHA		:Number = .5;
		
		private var _bg:Sprite;
		private var _title:TextField;
		private var _close:BtnCloseFlash;
		private var _popup:Sprite;
		private var _y:int;
		private var _popupWidth:int			= GameState.stageWidth	* .6;
		private var _popupHeight:int			= GameState.stageHeight	* .8;
		private var _popupBorderColor:int	= 0xffffff;
		
		public var successPopup:SuccessPopup;
		public var errorPopup:ErrorPopup;
		
		public function Popup() 
		{
			alpha = 0;
		}
		
		public function display	():void { TweenLite.to(this, ANIM_TIMER, { alpha:1 }); }
		public function undisplay	():void { TweenLite.to(this, ANIM_TIMER, { alpha:0 }); }
		
		/**
		 * Generation functions
		 */
		
		// Background
		protected function generateBackground():void
		{
			_bg = new Sprite();
			_bg.alpha = BG_ALPHA;
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0, 0, GameState.stageWidth, GameState.stageHeight);
			_bg.graphics.endFill();
			addChild(_bg);
		}
		
		// Content
		protected function generateContent():void
		{
			_popup	= new Sprite();
			_title		= new TextField();
			_close	= new BtnCloseFlash();
			
			_close.addEventListener(MouseEvent.CLICK, clickClose);
		}
		
		// Popup
		protected function generatePopup():void
		{
			_popup.x = (GameState.stageWidth - _popupWidth) / 2;
			_popup.y = _y? _y: (GameState.stageHeight - _popupHeight) / 2;
			_popup.graphics.lineStyle(1, _popupBorderColor);
			_popup.graphics.beginFill(0x000000);
			_popup.graphics.drawRect(0, 0, _popupWidth, _popupHeight);
			_popup.graphics.endFill();
			addChild(_popup);
			
			// Title
			_title.x = 10;
			_title.y = 10;
			_title.width	= GameState.stageWidth*0.2;
			_title.height	= GameState.stageHeight*0.1;
			_title.selectable = false;
			_title.setTextFormat(Common.getPolicy('Arial', 0x00ffff, 20, 'left'));
			_popup.addChild(_title);
			
			// Close
			_close.y = 5;
			_popup.addChild(_close);
			
			_close.x = _popup.width - _close.width - 5;
			
			_close.addEventListener(MouseEvent.MOUSE_OVER, over);
			_close.addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		public function displaySuccessPopup (message:String):void
		{
			successPopup = new SuccessPopup();
			successPopup.setText(message);
			SceneManager.getInstance().scene.addChild(successPopup);
			successPopup.display();
		}
		
		public function displayErrorPopup (message:String):void
		{
			errorPopup = new ErrorPopup();
			errorPopup.setText(message);
			
			SceneManager.getInstance().scene.addChild(errorPopup);
			
			errorPopup.display();
		}
		
		/**
		 * Events
		 */
		
		private function clickClose(e:MouseEvent):void
		{
			SoundManager.getInstance().playMenuButtonError();
			destroy();
		}
		
		/**
		 * Getters
		 */
		
		
		
		/**
		 * Setters
		 */
		
		public function setPopupY				(value:int)					:void { _y							= value; }
		public function setPopupWidth			(value:int)					:void { _popupWidth			= value; }
		public function setPopupHeight		(value:int)					:void { _popupHeight			= value; }
		public function setPopupBorderColor(value:int)					:void { _popupBorderColor	= value; }
		public function setTitleText				(value:String)			:void { _title.text 				= value; }
		public function setPopupContent		(value:DisplayObject)	:void { _popup.addChild(value); }
		
		/**
		 * Removes
		 */
		
		public function destroy():void
		{
			_close.removeEventListener(MouseEvent.CLICK,				clickClose);
			_close.removeEventListener(MouseEvent.MOUSE_OVER,	over);
			_close.removeEventListener(MouseEvent.MOUSE_OUT,		out);
			
			TweenLite.to(this, ANIM_TIMER, {alpha:0, onComplete:SceneManager.getInstance().scene.removeChild, onCompleteParams:[this]});
		}
	}
}