package core 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import core.Common;
	
	/**
	 * Manage sounds & musics
	 * @author desweb
	 */
	public class SoundManager 
	{
		private static var _instance:SoundManager;
		
		private static var _menu						:Sound;
		private static var _menu_button			:Sound;
		private static var _menu_button_error	:Sound;
		
		private var _menu_button_channel			:SoundChannel;
		private var _menu_button_error_channel	:SoundChannel;
		
		public var available:int;
		
		public function SoundManager() 
		{
			_instance	= this;
			available	= Common.SOUND_ON;
			
			
		}
		
		/**
		 * Instance
		 */
		
		static public function getInstance():SoundManager
		{
			if (_instance == null) _instance = new SoundManager();
			
			return _instance;
		}
		
		/**
		 * Functions
		 */
		
		public function load():void
		{
			_menu = new Sound();
			_menu.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu.mp3'));
			
			_menu_button = new Sound();
			_menu_button.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-button.mp3'));
			
			_menu_button_error = new Sound();
			_menu_button_error.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-button-error.mp3'));
		}
		
		public function playMenuButton():void
		{
			_menu_button_channel = _menu_button.play();
			_menu_button_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButton);
		}
		
		public function playMenuButtonError():void
		{
			_menu_button_error_channel = _menu_button_error.play();
			_menu_button_error_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButtonError);
		}
		
		/**
		 * Events
		 */
		
		private function completeMenuButton(e:Event):void
		{
			if (!_menu_button_channel) return;
			
			_menu_button_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButton);
			_menu_button_channel = null;
		}
		
		private function completeMenuButtonError(e:Event):void
		{
			if (!_menu_button_error_channel) return;
			
			_menu_button_error_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButtonError);
			_menu_button_error_channel = null;
		}
		
		/**
		 * Getters
		 */
		
		public function get menu				():Sound { return _menu; }
		public function get menu_button	():Sound { return _menu_button; }
	}
}