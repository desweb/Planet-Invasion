package core 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Interface extends Sprite
	{
		public var btnFormat			:TextFormat;
		public var btnErrorFormat	:TextFormat;
		public var inputFormat		:TextFormat;
		public var inputLabelFormat:TextFormat;
		
		public function Interface() 
		{
			btnFormat				= Common.getPolicy('Arial', 0x00FFFF, 15);
			btnErrorFormat		= Common.getPolicy('Arial', 0xFF0000, 15);
			inputFormat			= Common.getPolicy('Arial', 0xFFFFFF, 15);
			inputLabelFormat	= Common.getPolicy('Arial', 0x00FFFF, 15);
		}
		
		protected function generateTab(txt:String):Sprite
		{
			var tab:Sprite = new Sprite();
			tab.mouseChildren	= false;
			addChild(tab);
			
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0, 0, GameState.stageWidth * .2, GameState.stageHeight * .05);
			bg.graphics.endFill();
			bg.alpha = .5;
			tab.addChild(bg);
			
			tab.x = (GameState.stageWidth - bg.width) / 2;
			tab.y = (GameState.stageHeight - bg.height) / 2;
			
			var label:TextField = new TextField();
			label.x							= 0;
			label.y							= 0;
			label.width						= tab.width;
			label.height					= tab.height;
			label.defaultTextFormat	= btnFormat;
			label.text						= txt;
			label.selectable				= false;
			label.border					= true;
			label.borderColor			= 0x00ffff;
			tab.addChild(label);
			
			tab.addEventListener(MouseEvent.MOUSE_OVER, over);
			tab.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			return tab;
		}
		
		protected function generateBtn(txt:String, frame:int = Common.FRAME_BTN_DEFAULT):BtnFlash
		{
			var btn:BtnFlash = new BtnFlash();
			btn.mouseChildren = false;
			addChild(btn);
			
			btn.x = (GameState.stageWidth - btn.width) / 2;
			btn.y = (GameState.stageHeight - btn.height) / 2;
			
			var label:TextField = new TextField();
			label.y							= btn.height * .15;
			label.width						= btn.width;
			label.height					= btn.height;
			label.defaultTextFormat	= frame == Common.FRAME_BTN_LOCK? btnErrorFormat: btnFormat;
			label.text						= txt;
			label.selectable				= false;
			btn.addChild(label);
			
			btn.gotoAndStop(frame);
			
			btn.addEventListener(MouseEvent.MOUSE_OVER, over);
			btn.addEventListener(MouseEvent.MOUSE_OUT, out);
			
			return btn;
		}
		
		protected function generateBtnLeft(txt:String, frame:int = 1):BtnLeftFlash
		{
			var btn:BtnLeftFlash = new BtnLeftFlash();
			btn.mouseChildren = false;
			addChild(btn);
			
			btn.x = (GameState.stageWidth - btn.width) / 2;
			btn.y = (GameState.stageHeight - btn.height) / 2;
			
			var label:TextField = new TextField();
			label.y							= btn.height * .1;
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
		
		protected function generateBtnRight(txt:String, frame:int = 1):BtnRightFlash
		{
			var btn:BtnRightFlash = new BtnRightFlash();
			btn.mouseChildren = false;
			addChild(btn);
			
			btn.x = (GameState.stageWidth - btn.width) / 2;
			btn.y = (GameState.stageHeight - btn.height) / 2;
			
			var label:TextField = new TextField();
			label.y							= btn.height * .1;
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
		
		protected function generateBtnCenter(txt:String, frame:String = 'default'):TextField
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
		
		protected function generateInputLabel(txt:String):TextField
		{
			var label:TextField	= new TextField();
			label.text			= txt;
			label.width			= GameState.stageWidth*0.3;
			label.height		= GameState.stageHeight * 0.05;
			label.x				= (GameState.stageWidth - label.width) * 0.5;
			label.y				= (GameState.stageHeight - label.height) * 0.5;
			label.selectable	= false;
			label.textColor	= 0x00ffff;
			label.setTextFormat(inputLabelFormat);
			
			return label;
		}
		
		protected function generateInput():TextField
		{
			var input:TextField = new TextField();
			input.type				= 'input';
			input.width			= GameState.stageWidth*0.3;
			input.height			= GameState.stageHeight*0.05;
			input.x					= (GameState.stageWidth - input.width) * 0.5;
			input.y					= (GameState.stageHeight - input.height) * 0.5;
			input.border 			= true;
			input.borderColor	= 0x00ffff;
			input.textColor		= 0xffffff;
			input.setTextFormat(inputFormat);
			
			return input;
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
	}
}