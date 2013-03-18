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
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Popup extends Sprite implements IPopup
	{
		public static const BG_ALPHA:Number = 0.5;
		
		private var _bg:Sprite;
		private var _title:TextField;
		private var _close:BtnClose;
		private var _popup:Sprite;
		private var _popupWidth:int			= GameState.stageWidth*0.6;
		private var _popupHeight:int		= GameState.stageHeight*0.8;
		private var _popupBorderColor:int	= 0xffffff;
		
		public var successPopup:SuccessPopup;
		public var errorPopup:ErrorPopup;
		
		public function Popup() 
		{
			alpha = 0;
			
			// Background
			_bg = new Sprite();
			_bg.alpha = BG_ALPHA;
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0, 0, GameState.stageWidth, GameState.stageHeight);
			_bg.graphics.endFill();
			addChild(_bg);
			
			_popup = new Sprite();
			_title = new TextField();
			_close = new BtnClose();
		}
		
		public function display		():void { TweenLite.to(this, 1, {alpha:1}); }
		public function undisplay	():void { TweenLite.to(this, 1, {alpha:0}); }
		
		/**
		 * Generation functions
		 */
		
		// Popup
		public function generatePopup():void
		{
			_popup.x = (GameState.stageWidth - _popupWidth) / 2;
			_popup.y = (GameState.stageHeight - _popupHeight) / 2;
			_popup.graphics.lineStyle(2, _popupBorderColor);
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
			addChild(successPopup);
			
			successPopup.close.addEventListener(MouseEvent.CLICK, clickSuccessPopupClose);
			
			successPopup.display();
			TweenLite.to(_bg, 1, {alpha:0});
		}
		
		public function displayErrorPopup (message:String):void
		{
			errorPopup = new ErrorPopup();
			errorPopup.setText(message);
			addChild(errorPopup);
			
			errorPopup.close.addEventListener(MouseEvent.CLICK, clickErrorPopupClose);
			
			errorPopup.display();
			TweenLite.to(_bg, 1, {alpha:0});
		}
		
		/**
		 * Events
		 */
		public function over(e:MouseEvent):void { buttonMode = true; }
		public function out	(e:MouseEvent):void { buttonMode = false; }
		
		
		public function clickSuccessPopupClose (e:MouseEvent):void
		{
			successPopup.close.removeEventListener(MouseEvent.CLICK, clickSuccessPopupClose);
			
			TweenLite.to(successPopup, 1, {alpha:0, onComplete:removeSuccessPopup});
			TweenLite.to(_bg, 1, {alpha:BG_ALPHA});
		}
		
		public function clickErrorPopupClose (e:MouseEvent):void
		{
			errorPopup.close.removeEventListener(MouseEvent.CLICK, clickErrorPopupClose);
			
			TweenLite.to(errorPopup, 1, {alpha:0, onComplete:removeErrorPopup});
			TweenLite.to(_bg, 1, {alpha:BG_ALPHA});
		}
		
		/**
		 * Getters
		 */
		public function get close():BtnClose { return _close; }
		
		/**
		 * Setters
		 */
		public function setPopupWidth		(value:int)				:void { _popupWidth			= value; }
		public function setPopupHeight		(value:int)				:void { _popupHeight		= value; }
		public function setPopupBorderColor	(value:int)				:void { _popupBorderColor	= value; }
		public function setTitleText		(value:String)			:void { _title.text 		= value; }
		public function setPopupContent		(value:DisplayObject)	:void { _popup.addChild(value); }
		
		/**
		 * Removes
		 */
		
		private function removeSuccessPopup():void
		{
			if (!successPopup) return;
			
			if (Common.IS_DEBUG) trace('delete SuccessPopup');
			
			removeChild(successPopup);
			successPopup = null;
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