package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import core.Common;
	import core.SoundManager;
	
	/**
	 * Preloader class of the application
	 * @author desweb
	 */
	
	public class Preloader extends MovieClip
	{
		private var _bg:BgFlash;
		private var _loading_label:TextField;
		private var _loader:LoaderFlash;
		
		public function Preloader() 
		{
			if (Common.IS_DEBUG) trace('create Preloader');
			
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// Show loader scene
			_bg = new BgFlash();
			_bg.gotoAndStop(2);
			addChild(_bg);
			
			var font:Font = new MyArialPolicy();
			
			var format:TextFormat = new TextFormat();
			format.color	= 0x00ffff;
			format.size		= 24;
			format.font		= font.fontName;
			
			_loading_label = new TextField();
			_loading_label.text = 'Loading...';
			_loading_label.selectable = false;
			_loading_label.setTextFormat(format);
			addChild(_loading_label);
			
			_loading_label.x = stage.stageWidth/2 - _loading_label.width/2;
			_loading_label.y = stage.stageHeight*0.3;
			
			_loader = new LoaderFlash();
			_loader.x = stage.stageWidth / 2;
			_loader.y = stage.stageHeight / 2;
			addChild(_loader);
			
			SoundManager.getInstance().load();
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			
			if (Common.IS_DEBUG)
			{
				var percent:int = (e.bytesLoaded / e.bytesTotal) * 100;
				trace('loading : ' + percent + '%');
			}
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
			if (Common.IS_DEBUG) trace('loading finished');
			
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void 
		{
			if (Common.IS_DEBUG) trace('launch project');
			
			var mainClass:Class = getDefinitionByName('Main') as Class;
			addChild(new mainClass() as DisplayObject);
			
			removeChild(_bg);
			removeChild(_loading_label);
			removeChild(_loader);
			
			_bg					= null;
			_loading_label	= null;
			_loader				= null;
		}
	}
}