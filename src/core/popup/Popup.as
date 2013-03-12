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
		private var _bg:Sprite;
		private var _title:TextField;
		private var _close:BtnClose;
		private var _popup:Sprite;
		private var _popupWidth:int			= GameState.stageWidth*0.6;
		private var _popupHeight:int		= GameState.stageHeight*0.8;
		private var _popupBorderColor:int	= 0xffffff;
		
		public function Popup() 
		{
			alpha = 0;
			
			// Background
			_bg = new Sprite();
			_bg.alpha = 0.5;
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
			_close.scaleX = 0.25;
			_close.scaleY = 0.25;
			_popup.addChild(_close);
			
			_close.x = _popup.width - _close.width - 5;
			
			_close.addEventListener(MouseEvent.MOUSE_OVER, over);
			_close.addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		/**
		 * Events
		 */
		public function over(e:MouseEvent):void { buttonMode = true; }
		public function out	(e:MouseEvent):void { buttonMode = false; }
		
		/**
		 * Getters
		 */
		public function get close():BtnClose { return _close; }
		
		/**
		 * Setters
		 */
		public function set popupWidth		(value:int)		:void	{ _popupWidth		= value; }
		public function set popupHeight		(value:int)		:void	{ _popupHeight		= value; }
		public function set popupBorderColor(value:int)		:void	{ _popupBorderColor	= value; }
		
		public function setTitleText	(value:String)			:void { _title.text = value; }
		public function setPopupContent	(value:DisplayObject)	:void { _popup.addChild(value); }
	}
}