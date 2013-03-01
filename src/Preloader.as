package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Preloader class of the application
	 * @author desweb
	 */
	
	public class Preloader extends MovieClip
	{
		private var _txtLoading:TextField;
		private var _loader:Loader;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
			//var font:Font = new Arial();
			
			var format:TextFormat = new TextFormat();
			format.color	= 0xFFFF00;
			format.size		= 24;
			//format.font		= font.fontName;
			
			_txtLoading = new TextField();
			_txtLoading.text = 'Loading...';
			_txtLoading.selectable = false;
			_txtLoading.setTextFormat(format);
			addChild(_txtLoading);
			
			_txtLoading.x = stage.stageWidth/2 - _txtLoading.width/2;
			_txtLoading.y = stage.stageHeight / 2 - _txtLoading.height / 2;
			
			_loader = new Loader();
			_loader.y = _txtLoading.y + stage.stageHeight*0.1;
			addChild(_loader);
			
			_loader.x = stage.stageWidth / 2 - _txtLoading.width / 2;
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
		}
		
		private function checkFrame(e:Event):void 
		{
			_loader.rotation += 10;
			
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}